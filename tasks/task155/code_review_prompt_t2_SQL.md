# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPDNPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, NOPS, CITENS
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg) - TRECHOS RELEVANTES PARA PASS SQL (827 linhas total):

*-- Linhas 52 a 70:
52:                 *-- Criar cursor de trabalho das divisoes da O.P.
53:                 *-- Estrutura identica ao Temp_DivOp do legado (evento Load)
54:                 SET NULL ON
55:                 CREATE CURSOR cursor_4c_DivOp ;
56:                     (Qtds    N(12,3) NULL, QtdDivs N(12,3) NULL, ;
57:                      Dopes   C(20),        Numes   N(6,0)  NULL, ;
58:                      Dataes  D      NULL,  Obss    M       NULL, ;
59:                      Nops    N(10,0)NULL,  SeqDivs N(3,0)  NULL, ;
60:                      Cpros   C(10),        CodCors C(4),          ;
61:                      CodTams C(4),         cItens  N(10,0) NULL)
62:                 SET NULL OFF
63: 
64:                 *-- Construir controles visuais do form
65:                 THIS.ConfigurarPageFrame()
66:                 THIS.Caption = "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P."
67:                 THIS.ConfigurarPaginaLista()
68:                 THIS.ConfigurarPaginaDados()
69: 
70:                 *-- Propagar Caption correto para labels do cabecalho

*-- Linhas 177 a 307:
177:             .Height        = 285
178:             .FontName      = "Arial"
179:             .FontSize      = 8
180:             .DeleteMark    = .F.
181:             .RecordMark    = .F.
182:             .GridLines     = 3
183:             .GridLineWidth = 1
184:             .HeaderHeight  = 17
185:             .RowHeight     = 17
186:             .ScrollBars    = 2
187:             .ColumnCount   = 5
188: 
189:             *-- Column1: Pedido (Dopes + Numes - equivale a fGerMascara(Numes) do legado)
190:             WITH .Column1
191:                 .Width             = 256
192:                 .Alignment         = 0
193:                 .ControlSource     = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + TRANSFORM(cursor_4c_DivOp.Numes)"
194:                 .ReadOnly          = .T.
195:                 .Movable           = .F.
196:                 .Resizable         = .F.
197:                 .FontName          = "Arial"
198:                 .FontSize          = 8
199:                 .ForeColor         = RGB(0, 0, 0)
200:                 .Header1.Caption   = "Pedido"
201:                 .Header1.FontName  = "Arial"
202:                 .Header1.FontSize  = 8
203:                 .Header1.Alignment = 2
204:             ENDWITH
205: 
206:             *-- Column2: Cor (CodCors)
207:             WITH .Column2
208:                 .Width             = 54
209:                 .Alignment         = 0
210:                 .ControlSource     = "cursor_4c_DivOp.CodCors"
211:                 .ReadOnly          = .T.
212:                 .Movable           = .F.
213:                 .Resizable         = .F.
214:                 .FontName          = "Arial"
215:                 .FontSize          = 8
216:                 .Header1.Caption   = "Cor"
217:                 .Header1.FontSize  = 8
218:                 .Header1.Alignment = 2
219:             ENDWITH
220: 
221:             *-- Column3: Tam (CodTams)
222:             WITH .Column3
223:                 .Width             = 54
224:                 .Alignment         = 0
225:                 .ControlSource     = "cursor_4c_DivOp.CodTams"
226:                 .ReadOnly          = .T.
227:                 .Movable           = .F.
228:                 .Resizable         = .F.
229:                 .FontName          = "Arial"
230:                 .FontSize          = 8
231:                 .Header1.Caption   = "Tam"
232:                 .Header1.FontSize  = 8
233:                 .Header1.Alignment = 2
234:             ENDWITH
235: 
236:             *-- Column4: Qtd.Atual (Qtds - quantidade original, readonly)
237:             WITH .Column4
238:                 .Width             = 114
239:                 .Alignment         = 1
240:                 .ControlSource     = "cursor_4c_DivOp.Qtds"
241:                 .ReadOnly          = .T.
242:                 .Movable           = .F.
243:                 .Resizable         = .F.
244:                 .FontName          = "Arial"
245:                 .FontSize          = 8
246:                 .InputMask         = "999,999.999"
247:                 .Header1.Caption   = "Qtd.Atual"
248:                 .Header1.FontName  = "Arial"
249:                 .Header1.FontSize  = 8
250:                 .Header1.Alignment = 2
251:             ENDWITH
252: 
253:             *-- Column5: Quantidade nova (QtdDivs - editavel pelo usuario, Format=K limpa zeros)
254:             WITH .Column5
255:                 .Width             = 114
256:                 .Alignment         = 1
257:                 .ControlSource     = "cursor_4c_DivOp.QtdDivs"
258:                 .ReadOnly          = .F.
259:                 .Format            = "K"
260:                 .Movable           = .F.
261:                 .Resizable         = .F.
262:                 .FontName          = "Arial"
263:                 .FontSize          = 8
264:                 .Header1.Caption   = "Quantidade"
265:                 .Header1.FontName  = "Arial"
266:                 .Header1.FontSize  = 8
267:                 .Header1.Alignment = 2
268:             ENDWITH
269:         ENDWITH
270:         *-- RecordSource FORA do WITH: evita auto-bind sobrescrever ControlSources acima
271:         THIS.grd_4c_Dados.ColumnCount = 5
272:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_DivOp"
273:         *-- Re-definir ControlSources apos auto-bind do RecordSource (VFP9 mapeia por ordem de campo)
274:         THIS.grd_4c_Dados.Column1.ControlSource = "ALLTRIM(cursor_4c_DivOp.Dopes) + ' ' + TRANSFORM(cursor_4c_DivOp.Numes)"
275:         THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_DivOp.CodCors"
276:         THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_DivOp.CodTams"
277:         THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_DivOp.Qtds"
278:         THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_DivOp.QtdDivs"
279:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
280:         THIS.FormatarGridLista(THIS.grd_4c_Dados)
281: 
282:         *-- EditBox de observacoes da divisao selecionada (readonly, vinculada ao cursor)
283:         THIS.AddObject("edt_4c_Obss", "EditBox")
284:         WITH THIS.edt_4c_Obss
285:             .Top               = 490
286:             .Left              = 68
287:             .Width             = 632
288:             .Height            = 96
289:             .ReadOnly          = .T.
290:             .FontName          = "Tahoma"
291:             .FontSize          = 8
292:             .ControlSource     = "cursor_4c_DivOp.Obss"
293:             .DisabledBackColor = RGB(255, 255, 255)
294:         ENDWITH
295: 
296:         *-- CommandGroup: Confirmar (inicia desabilitado) + Encerrar
297:         THIS.AddObject("cmg_4c_Conf", "CommandGroup")
298:         WITH THIS.cmg_4c_Conf
299:             .Top           = 0
300:             .Left          = 775
301:             .Width         = 160
302:             .Height        = 85
303:             .BackStyle     = 0
304:             .BorderStyle   = 0
305:             .SpecialEffect = 1
306:             .ButtonCount   = 2
307:             .Themes        = .F.

*-- Linhas 372 a 390:
372:     *==========================================================================
373:     PROCEDURE AlternarPagina(par_nPagina)
374:         IF USED("cursor_4c_DivOp")
375:             SELECT cursor_4c_DivOp
376:             ZAP
377:         ENDIF
378: 
379:         IF VARTYPE(THIS.txt_4c_OP) = "O"
380:             THIS.txt_4c_OP.Value = ""
381:         ENDIF
382: 
383:         IF VARTYPE(THIS.txt_4c_Produto) = "O"
384:             THIS.txt_4c_Produto.Value = ""
385:         ENDIF
386: 
387:         IF VARTYPE(THIS.cmg_4c_Conf) = "O"
388:             THIS.cmg_4c_Conf.Buttons(1).Enabled = .F.
389:         ENDIF
390: 

*-- Linhas 424 a 442:
424: 
425:         IF EMPTY(ALLTRIM(THIS.txt_4c_OP.Value))
426:             IF USED("cursor_4c_DivOp")
427:                 SELECT cursor_4c_DivOp
428:                 ZAP
429:             ENDIF
430:             THIS.txt_4c_Produto.Value = ""
431:             THIS.grd_4c_Dados.Refresh
432:             RETURN
433:         ENDIF
434: 
435:         loc_nNops = VAL(ALLTRIM(THIS.txt_4c_OP.Value))
436:         IF loc_nNops = 0
437:             RETURN
438:         ENDIF
439: 
440:         IF THIS.this_oBusinessObject.CarregarOP(loc_nNops)
441:             THIS.txt_4c_Produto.Value               = THIS.this_oBusinessObject.this_cCodPds
442:             THIS.cmg_4c_Conf.Buttons(1).Enabled     = .T.

*-- Linhas 697 a 715:
697:     *==========================================================================
698:     PROCEDURE LimparCampos()
699:         IF USED("cursor_4c_DivOp")
700:             SELECT cursor_4c_DivOp
701:             ZAP
702:         ENDIF
703: 
704:         IF VARTYPE(THIS.txt_4c_OP) = "O"
705:             THIS.txt_4c_OP.Value = ""
706:         ENDIF
707: 
708:         IF VARTYPE(THIS.txt_4c_Produto) = "O"
709:             THIS.txt_4c_Produto.Value = ""
710:         ENDIF
711: 
712:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
713:             THIS.this_oBusinessObject.this_nNops  = 0
714:             THIS.this_oBusinessObject.this_cCodPds = ""
715:             THIS.this_oBusinessObject.this_cEmpDNps = ""


### BO (C:\4c\projeto\app\classes\SigPrAopBO.prg):
*------------------------------------------------------------------------------
* SigPrAopBO.prg - Business Object para Alteracao de Quantidade da O.P.
* Form OPERACIONAL: Altera quantidades de divisoes de Ordens de Producao
* Tabelas principais: SigOpPic, SigCdPam, SigCdNec, SigPdMvf
*------------------------------------------------------------------------------
DEFINE CLASS SigPrAopBO AS BusinessBase

    *-- Tabela principal e chave
    this_cTabela            = "SigOpPic"
    this_cCampoChave        = "cIdChaves"

    *-- Empresa corrente
    this_cEmps              = ""

    *-- O.P. corrente
    this_nNops              = 0        && Numero da O.P. (Nops)
    this_cEmpDNps           = ""       && Chave composta empresa+DoppPads+Nops (EmpDNps)

    *-- Produto da O.P. (de SigPdMvf)
    this_cCodPds            = ""       && Codigo do produto (CodPds)

    *-- Parametros de configuracao (SigCdPam)
    this_cDoppPads          = ""       && Prefixo de OP (DoppPads)
    this_cMascNums          = ""       && Mascara de numeros (MascNums)

    *-- Flags de estado da O.P.
    this_lOpEncerrada       = .F.      && OP ja encerrada (ChkSubn = .T.)
    this_lOpLocalizada      = .F.      && OP foi localizada em SigCdNec

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = DODEFAULT()

        IF loc_lSucesso
            THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de configuracao de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DoppPads, MascNums FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    THIS.this_cDoppPads = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros do sistema (SigCdPam).", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOP - Valida e carrega os itens da O.P. em cursor_4c_DivOp
    * Equivalente ao Get_OP.Valid do legado
    *--------------------------------------------------------------------------
    FUNCTION CarregarOP(par_nNops)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cEmpDNps
        LOCAL loc_lEncerrada, loc_nSeq, loc_lContinuar

        loc_lSucesso   = .F.
        loc_lContinuar = (par_nNops > 0)

        TRY
            IF loc_lContinuar
                THIS.this_nNops         = par_nNops
                loc_cEmpDNps            = THIS.this_cEmps + THIS.this_cDoppPads + STR(par_nNops, 10)
                THIS.this_cEmpDNps      = loc_cEmpDNps
                THIS.this_lOpLocalizada = .F.
                THIS.this_lOpEncerrada  = .F.
                THIS.this_cCodPds       = ""

                *-- Limpa cursor antes de carregar
                IF USED("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    ZAP
                ENDIF

                *-- Verifica existencia e status da O.P. em SigCdNec
                loc_cSQL = "SELECT ChkSubn FROM SigCdNec WHERE EmpDNps = " + EscaparSQL(loc_cEmpDNps)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nec") > 0
                    IF EOF("cursor_4c_Nec")
                        loc_lContinuar = .F.
                        IF USED("cursor_4c_Nec")
                            USE IN cursor_4c_Nec
                        ENDIF
                        MsgAviso("O.P. N" + CHR(227) + "o Localizada!!!", "Aviso")
                    ELSE
                        SELECT cursor_4c_Nec
                        loc_lEncerrada = NVL(ChkSubn, .F.)
                        IF USED("cursor_4c_Nec")
                            USE IN cursor_4c_Nec
                        ENDIF

                        THIS.this_lOpLocalizada = .T.
                        THIS.this_lOpEncerrada  = loc_lEncerrada

                        IF loc_lEncerrada
                            loc_lContinuar = .F.
                            MsgAviso("O.P. J" + CHR(225) + " Foi Encerrada!!!", "Aviso")
                        ENDIF
                    ENDIF
                ELSE
                    loc_lContinuar = .F.
                    MsgErro("Erro ao verificar O.P. em SigCdNec.", "Erro")
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Carrega codigo do produto da O.P. em SigPdMvf
                loc_cSQL = "SELECT CodPds FROM SigPdMvf WHERE EmpDNps = " + EscaparSQL(THIS.this_cEmpDNps)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mvf") > 0
                    IF !EOF("cursor_4c_Mvf")
                        SELECT cursor_4c_Mvf
                        THIS.this_cCodPds = ALLTRIM(NVL(CodPds, ""))
                    ENDIF
                    IF USED("cursor_4c_Mvf")
                        USE IN cursor_4c_Mvf
                    ENDIF
                ENDIF

                *-- Carrega divisoes da O.P. de SigOpPic
                loc_cSQL = "SELECT Dopes, Numes, Qtds, DataEs, Obss, " + ;
                           "CPros, CodCors, CodTams, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPicTemp") > 0
                    loc_nSeq = 1
                    SELECT cursor_4c_OpPicTemp
                    SCAN
                        INSERT INTO cursor_4c_DivOp ;
                            (Dopes, Numes, Qtds, QtdDivs, Dataes, Obss, ;
                             SeqDivs, Cpros, CodCors, CodTams, cItens) ;
                        VALUES ;
                            (ALLTRIM(NVL(cursor_4c_OpPicTemp.Dopes, "")), ;
                             NVL(cursor_4c_OpPicTemp.Numes, 0), ;
                             NVL(cursor_4c_OpPicTemp.Qtds, 0), ;
                             NVL(cursor_4c_OpPicTemp.Qtds, 0), ;
                             cursor_4c_OpPicTemp.DataEs, ;
                             NVL(cursor_4c_OpPicTemp.Obss, ""), ;
                             loc_nSeq, ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CPros, "")), ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CodCors, "")), ;
                             ALLTRIM(NVL(cursor_4c_OpPicTemp.CodTams, "")), ;
                             NVL(cursor_4c_OpPicTemp.Citens, 0))
                        loc_nSeq = loc_nSeq + 1
                    ENDSCAN

                    IF USED("cursor_4c_OpPicTemp")
                        USE IN cursor_4c_OpPicTemp
                    ENDIF

                    SELECT cursor_4c_DivOp
                    GO TOP
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar itens da O.P. em SigOpPic.", "Erro")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarAlteracoes - Salva quantidades alteradas de volta ao SQL Server
    * Equivalente ao Grupo_Conf.Salva.Click do legado:
    * 1. Reset SeqDivs=0 em SigOpPic para a O.P.
    * 2. Para cada linha de cursor_4c_DivOp, atualiza Qtds+SeqDivs em SigOpPic
    * 3. Soma total de QtdDivs e atualiza SigPdMvf
    *--------------------------------------------------------------------------
    FUNCTION SalvarAlteracoes(par_nNops)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        LOCAL loc_cIdChaves, loc_nQtdTotal, loc_lContinuar
        LOCAL loc_cDopes, loc_nNumes, loc_nCItens, loc_nQtdDivs, loc_nSeqDiv

        loc_lSucesso   = .F.
        loc_lContinuar = (par_nNops > 0)

        TRY
            IF loc_lContinuar
                *-- Passo 1: Reseta SeqDivs = 0 para todos os itens da O.P.
                loc_cSQL = "UPDATE SigOpPic SET SeqDivs = 0 " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd0") < 1
                    loc_lContinuar = .F.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update - SigOpPic 1)")
                ELSE
                    IF USED("cursor_4c_Upd0")
                        USE IN cursor_4c_Upd0
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 2: Recarrega SigOpPic com cIdChaves para UPDATE por chave
                loc_cSQL = "SELECT Nops, cIdChaves, Dopes, Numes, SeqDivs, Qtds, Citens " + ;
                           "FROM SigOpPic " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPicSave") < 1
                    loc_lContinuar = .F.
                    MsgErro("Erro ao recarregar dados de SigOpPic para grava" + ;
                            CHR(231) + CHR(227) + "o.", "Erro")
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 3: Para cada divisao, localiza e atualiza Qtds+SeqDivs em SigOpPic
                IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    GO TOP
                    SCAN WHILE loc_lContinuar
                        loc_cDopes   = ALLTRIM(cursor_4c_DivOp.Dopes)
                        loc_nNumes   = cursor_4c_DivOp.Numes
                        loc_nCItens  = cursor_4c_DivOp.cItens
                        loc_nQtdDivs = cursor_4c_DivOp.QtdDivs
                        loc_nSeqDiv  = cursor_4c_DivOp.SeqDivs

                        *-- Busca a linha correspondente em SigOpPic (SeqDivs=0 = ainda nao processado)
                        SELECT cursor_4c_OpPicSave
                        LOCATE FOR Citens         = loc_nCItens AND ;
                                   ALLTRIM(Dopes) = loc_cDopes  AND ;
                                   Numes          = loc_nNumes  AND ;
                                   SeqDivs        = 0

                        IF FOUND()
                            loc_cIdChaves = ALLTRIM(cursor_4c_OpPicSave.cIdChaves)

                            loc_cSQL = "UPDATE SigOpPic " + ;
                                       "SET Qtds = "    + FormatarNumeroSQL(loc_nQtdDivs) + ;
                                       ", SeqDivs = "   + FormatarNumeroSQL(loc_nSeqDiv)  + ;
                                       " WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd1") < 1
                                loc_lContinuar = .F.
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (Update - SigOpPic 2)")
                            ELSE
                                IF USED("cursor_4c_Upd1")
                                    USE IN cursor_4c_Upd1
                                ENDIF
                                *-- Marca como processado no cursor local (SeqDivs != 0)
                                REPLACE SeqDivs WITH loc_nSeqDiv IN cursor_4c_OpPicSave
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_DivOp
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_OpPicSave")
                    USE IN cursor_4c_OpPicSave
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 4: Soma QtdDivs e atualiza total em SigPdMvf
                loc_nQtdTotal = 0
                IF USED("cursor_4c_DivOp") AND !EOF("cursor_4c_DivOp")
                    SELECT SUM(QtdDivs) AS nTotalQtd FROM cursor_4c_DivOp ;
                           INTO CURSOR cursor_4c_Soma READWRITE
                    IF !EOF("cursor_4c_Soma")
                        loc_nQtdTotal = NVL(cursor_4c_Soma.nTotalQtd, 0)
                    ENDIF
                    IF USED("cursor_4c_Soma")
                        USE IN cursor_4c_Soma
                    ENDIF
                ENDIF

                loc_cSQL = "SELECT cIdChaves FROM SigPdMvf " + ;
                           "WHERE Nops = " + FormatarNumeroSQL(par_nNops)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvfSave") > 0
                    IF !EOF("cursor_4c_MvfSave")
                        SELECT cursor_4c_MvfSave
                        loc_cIdChaves = ALLTRIM(cursor_4c_MvfSave.cIdChaves)

                        loc_cSQL = "UPDATE SigPdMvf " + ;
                                   "SET Qtds = " + FormatarNumeroSQL(loc_nQtdTotal) + ;
                                   " WHERE cIdChaves = " + EscaparSQL(loc_cIdChaves)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd2") < 1
                            loc_lContinuar = .F.
                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                    "Falha na Conex" + CHR(227) + "o (Update - SigPdMvf)")
                        ELSE
                            IF USED("cursor_4c_Upd2")
                                USE IN cursor_4c_Upd2
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvfSave")
                        USE IN cursor_4c_MvfSave
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Passo 5: Auditoria, limpa cursor e reseta estado
                THIS.RegistrarAuditoria("ALTERAR")

                IF USED("cursor_4c_DivOp")
                    SELECT cursor_4c_DivOp
                    ZAP
                ENDIF

                THIS.this_nNops    = 0
                THIS.this_cEmpDNps = ""
                THIS.this_cCodPds  = ""

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    * Aceita alias contendo qualquer subset dos campos: Nops, CodPds, Dopes,
    * Numes, Qtds, DataEs, Obss, Cpros, CodCors, CodTams, cItens, SeqDivs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave da O.P.
            IF TYPE("Nops") != "U"
                THIS.this_nNops = NVL(Nops, 0)
            ENDIF

            *-- Empresa
            IF TYPE("Emps") != "U"
                THIS.this_cEmps = ALLTRIM(NVL(Emps, ""))
            ENDIF

            *-- Produto (SigPdMvf)
            IF TYPE("CodPds") != "U"
                THIS.this_cCodPds = ALLTRIM(NVL(CodPds, ""))
            ENDIF

            *-- Recompoe chave composta se possivel
            IF !EMPTY(THIS.this_cDoppPads) AND THIS.this_nNops > 0
                THIS.this_cEmpDNps = THIS.this_cEmps + THIS.this_cDoppPads + STR(THIS.this_nNops, 10)
            ENDIF

            *-- Status da O.P. (SigCdNec)
            IF TYPE("ChkSubn") != "U"
                THIS.this_lOpEncerrada  = NVL(ChkSubn, .F.)
                THIS.this_lOpLocalizada = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "Nops=" + TRANSFORM(THIS.this_nNops)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL nao insere novos registros em SigOpPic
    * A tela apenas ALTERA quantidades de OPs existentes. Metodo mantido
    * para satisfazer contrato de BusinessBase; delega para SalvarAlteracoes
    * quando invocado via Salvar() em modo de insercao (nao usado nesta tela).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nNops > 0
            loc_lSucesso = THIS.SalvarAlteracoes(THIS.this_nNops)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("INSERIR")
            ENDIF
        ELSE
            *-- Nada a inserir - fluxo nao aplicavel a esta tela operacional
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Grava alteracoes de quantidade de volta em SigOpPic
    * Fluxo real esta em SalvarAlteracoes (chamada por BtnConfirmarClick do
    * form). Este metodo delega e registra auditoria conforme contrato de
    * BusinessBase.Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nNops > 0
            loc_lSucesso = THIS.SalvarAlteracoes(THIS.this_nNops)
            IF loc_lSucesso
                THIS.RegistrarAuditoria("ATUALIZAR")
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Nenhuma O.P. carregada para atualiza" + CHR(231) + CHR(227) + "o."
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

