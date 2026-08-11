# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 274: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 299: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormFPP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (979 linhas total):

*-- Linhas 107 a 120:
107:             THIS.ConfigurarLabels()
108: 
109:             *-- BINDEVENTs de botoes
110:             BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "CmdInserirClick")
111:             BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
112:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
113: 
114:             *-- Atualizar caption do label com codigo da condicao de pagamento
115:             THIS.lbl_4c_Label1.Caption = "[ " + ALLTRIM(THIS.this_cFpags) + " ]"
116: 
117:             *-- Carregar dados do banco para cursor xFPagi
118:             IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFpags)
119:                 THIS.grd_4c_Dados.Refresh()
120:                 *-- Tornar controles visiveis

*-- Linhas 190 a 256:
190:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
191:         loc_oCab = THIS.cnt_4c_Cabecalho
192:         WITH loc_oCab
193:             .Top        = 0
194:             .Left       = 0
195:             .Width      = THIS.Width
196:             .Height     = 80
197:             .BackStyle  = 1
198:             .BackColor  = RGB(100, 100, 100)
199:             .BorderWidth = 0
200:         ENDWITH
201: 
202:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
203:         WITH loc_oCab.lbl_4c_Sombra
204:             .AutoSize   = .F.
205:             .FontBold   = .T.
206:             .FontName   = "Tahoma"
207:             .FontSize   = 18
208:             .WordWrap   = .T.
209:             .Alignment  = 0
210:             .BackStyle  = 0
211:             .Caption    = "Desconto por No. de Parcelas"
212:             .Height     = 40
213:             .Left       = 12
214:             .Top        = 18
215:             .Width      = THIS.Width - 20
216:             .ForeColor  = RGB(0, 0, 0)
217:         ENDWITH
218: 
219:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
220:         WITH loc_oCab.lbl_4c_Titulo
221:             .AutoSize   = .F.
222:             .FontBold   = .T.
223:             .FontName   = "Tahoma"
224:             .FontSize   = 18
225:             .WordWrap   = .T.
226:             .Alignment  = 0
227:             .BackStyle  = 0
228:             .Caption    = "Desconto por No. de Parcelas"
229:             .Height     = 46
230:             .Left       = 10
231:             .Top        = 17
232:             .Width      = THIS.Width - 20
233:             .ForeColor  = RGB(255, 255, 255)
234:         ENDWITH
235:     ENDPROC
236: 
237:     *==========================================================================
238:     * ConfigurarBotoes - botoes Inserir, Excluir e Encerrar
239:     *==========================================================================
240:     PROTECTED PROCEDURE ConfigurarBotoes()
241:         *-- Botao Inserir
242:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
243:         WITH THIS.cmd_4c_Inserir
244:             .Top             = 4
245:             .Left            = 435
246:             .Width           = 75
247:             .Height          = 75
248:             .Caption         = "Inserir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
250:             .FontName        = "Comic Sans MS"
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .FontSize        = 8
254:             .ForeColor       = RGB(90, 90, 90)
255:             .BackColor       = RGB(255, 255, 255)
256:             .Themes           = .T.

*-- Linhas 263 a 280:
263:         ENDWITH
264: 
265:         *-- Botao Excluir
266:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
267:         WITH THIS.cmd_4c_Excluir
268:             .Top             = 4
269:             .Left            = 510
270:             .Width           = 75
271:             .Height          = 75
272:             .Caption         = "Excluir"
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
274:             .FontName        = "Comic Sans MS"
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .FontSize        = 8
278:             .ForeColor       = RGB(90, 90, 90)
279:             .BackColor       = RGB(255, 255, 255)
280:             .Themes           = .T.

*-- Linhas 287 a 305:
287:         ENDWITH
288: 
289:         *-- Botao Encerrar
290:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
291:         WITH THIS.cmd_4c_Encerrar
292:             .Top             = 4
293:             .Left            = 585
294:             .Width           = 75
295:             .Height          = 75
296:             .Caption         = "Encerrar"
297:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .Cancel          = .T.
299:             .FontName        = "Comic Sans MS"
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .FontSize        = 8
303:             .ForeColor       = RGB(90, 90, 90)
304:             .BackColor       = RGB(255, 255, 255)
305:             .Themes           = .T.

*-- Linhas 346 a 355:
346:         THIS.AddObject("grd_4c_Dados", "Grid")
347:         loc_oGrid = THIS.grd_4c_Dados
348:         WITH loc_oGrid
349:             .Top              = 114
350:             .Left             = 163
351:             .Width            = 336
352:             .Height           = 244
353:             .ColumnCount      = 5
354:             .RecordSource     = "xFPagi"
355:             .RecordSourceType = 1

*-- Linhas 377 a 385:
377:             .FontSize        = 8
378:         ENDWITH
379:         WITH loc_oGrid.Column1.Header1
380:             .Caption         = "Parcelas"
381:             .Alignment       = 2
382:             .FontName        = "Tahoma"
383:             .FontSize        = 8
384:         ENDWITH
385:         WITH loc_oGrid.Column1.Text1

*-- Linhas 404 a 412:
404:             .FontSize        = 8
405:         ENDWITH
406:         WITH loc_oGrid.Column2.Header1
407:             .Caption         = "% Desconto"
408:             .Alignment       = 2
409:             .FontName        = "Tahoma"
410:             .FontSize        = 8
411:         ENDWITH
412:         WITH loc_oGrid.Column2.Text1

*-- Linhas 430 a 438:
430:             .FontSize        = 8
431:         ENDWITH
432:         WITH loc_oGrid.Column3.Header1
433:             .Caption         = "Valor M" + CHR(237) + "nimo"
434:             .Alignment       = 2
435:             .FontName        = "Tahoma"
436:             .FontSize        = 8
437:         ENDWITH
438:         WITH loc_oGrid.Column3.Text1

*-- Linhas 459 a 467:
459:             .FontSize        = 8
460:         ENDWITH
461:         WITH loc_oGrid.Column4.Header1
462:             .Caption         = "P"
463:             .Alignment       = 2
464:             .FontBold        = .T.
465:             .FontName        = "Tahoma"
466:             .FontSize        = 8
467:         ENDWITH

*-- Linhas 488 a 496:
488:             .FontSize        = 8
489:         ENDWITH
490:         WITH loc_oGrid.Column5.Header1
491:             .Caption         = "Valor M" + CHR(225) + "ximo"
492:             .Alignment       = 2
493:             .FontName        = "Tahoma"
494:             .FontSize        = 8
495:         ENDWITH
496:         WITH loc_oGrid.Column5.Text1

*-- Linhas 522 a 552:
522:     PROTECTED PROCEDURE ConfigurarLabels()
523:         *-- Label1: mostra codigo da condicao de pagamento (original: top=95, left=215)
524:         *-- Caption sera atualizado com THIS.this_cFpags em InicializarForm apos CarregarDados
525:         THIS.AddObject("lbl_4c_Label1", "Label")
526:         WITH THIS.lbl_4c_Label1
527:             .Top       = 95
528:             .Left      = 215
529:             .Width     = 154
530:             .Height    = 15
531:             .Caption   = "[ ]"
532:             .FontName  = "Tahoma"
533:             .FontSize  = 8
534:             .FontBold  = .T.
535:             .BackStyle = 0
536:             .AutoSize  = .T.
537:             .ForeColor = RGB(90, 90, 90)
538:         ENDWITH
539: 
540:         *-- Say2: legenda coluna P (original: top=364, left=162)
541:         THIS.AddObject("lbl_4c_Label2", "Label")
542:         WITH THIS.lbl_4c_Label2
543:             .Top       = 364
544:             .Left      = 162
545:             .Width     = 400
546:             .Height    = 15
547:             .Caption   = "[ P ] = Quantidade de Parcelas de Desconto"
548:             .FontName  = "Tahoma"
549:             .FontSize  = 8
550:             .FontBold  = .T.
551:             .BackStyle = 0
552:             .AutoSize  = .F.

*-- Linhas 624 a 632:
624: 
625:         TRY
626:             *-- Salvar somente se usuario tem permissao E dados foram alterados
627:             IF THIS.cmd_4c_Inserir.Visible AND THIS.this_lGravaDados
628:                 IF !THIS.this_oBusinessObject.SalvarDados(THIS.this_cFpags)
629:                     loc_lPodeSair = .F.
630:                 ENDIF
631:             ENDIF
632: 

*-- Linhas 859 a 871:
859: 
860:         loc_lHabilitar = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
861: 
862:         IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
863:             THIS.cmd_4c_Inserir.Enabled = loc_lHabilitar
864:         ENDIF
865:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
866:             THIS.cmd_4c_Excluir.Enabled = loc_lHabilitar
867:         ENDIF
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * LimparCampos - descarta alteracoes locais e zera estado de edicao

*-- Linhas 879 a 895:
879:     *==========================================================================
880:     * AjustarBotoesPorModo - ajusta visibilidade/estado dos botoes
881:     * Para popup OPERACIONAL sem modos CRUD tradicionais: avalia permissao de
882:     * insercao (cmd_4c_Inserir.Visible) e presenca de dados para ajustar Excluir.
883:     *==========================================================================
884:     PROCEDURE AjustarBotoesPorModo()
885:         LOCAL loc_lTemDados
886: 
887:         loc_lTemDados = USED("xFPagi") AND RECCOUNT("xFPagi") > 0
888: 
889:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
890:             THIS.cmd_4c_Excluir.Enabled = loc_lTemDados AND THIS.cmd_4c_Inserir.Visible
891:         ENDIF
892:     ENDPROC
893: 
894:     *==========================================================================
895:     * BtnBuscarClick - N/A para popup OPERACIONAL de grid direto


### BO (C:\4c\projeto\app\classes\FPPBO.prg):
*==============================================================================
* FPPBO.prg - Business Object: Desconto por No. de Parcelas
* Tabela: SigOpFpp
* Herda de: BusinessBase
*
* Colunas SigOpFpp (schema.sql):
*   cidchaves  char(20)       - Chave unica PK (gerada por SYS(2015))
*   descs      numeric(5,2)   - % Desconto
*   fpags      char(12)       - Codigo da condicao de pagamento (FK SigOpFp)
*   nparcs     numeric(2,0)   - No. de parcelas
*   parcdes    numeric(1,0)   - Qtd parcelas de desconto (P)
*   valmins    numeric(11,2)  - Valor minimo
*   valmaxs    numeric(11,2)  - Valor maximo
*
* Cursor local de edicao: xFPagi (criado em CarregarDados, usado pelo Form)
* Salvar: DELETE FROM SigOpFpp + re-INSERT linha a linha via SQLEXEC
*==============================================================================

DEFINE CLASS FPPBO AS BusinessBase

    this_cTabela      = "SigOpFpp"
    this_cCampoChave  = "cidchaves"

    *-- Props de SigOpFpp
    this_cFpags       = ""   && fpags char(12)
    this_nNparcs      = 0    && nparcs numeric(2,0)
    this_nDescs       = 0    && descs numeric(5,2)
    this_nValMins     = 0    && valmins numeric(11,2)
    this_nValMaxs     = 0    && valmaxs numeric(11,2)
    this_nParcDes     = 0    && parcdes numeric(1,0)
    this_cCidChaves   = ""   && cidchaves char(20)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpp"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor xFPagi para props do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cFpags     = TratarNulo(fpags,     "C")
            THIS.this_nNparcs    = TratarNulo(nparcs,    "N")
            THIS.this_nDescs     = TratarNulo(Descs,     "N")
            THIS.this_nValMins   = TratarNulo(ValMins,   "N")
            THIS.this_nValMaxs   = TratarNulo(ValMaxs,   "N")
            THIS.this_nParcDes   = TratarNulo(parcDes,   "N")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha individual em SigOpFpp
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cChave

        loc_lSucesso = .F.

        TRY
            loc_cChave           = SYS(2015)
            THIS.this_cCidChaves = loc_cChave

            loc_cSql = "INSERT INTO SigOpFpp " + ;
                       "(cidchaves, fpags, nparcs, descs, valmins, valmaxs, parcdes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNparcs, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDescs,  2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValMins, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValMaxs, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nParcDes, 0) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                MsgErro("Erro ao inserir registro em SigOpFpp.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarDados - carrega registros de SigOpFpp para cursor local xFPagi
    * par_cFpags: codigo da condicao de pagamento (SigOpFp.fpags)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro, loc_cSql

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi")
                USE IN xFPagi
            ENDIF

            SET NULL ON
            CREATE CURSOR xFPagi (;
                fpags     C(12)   NULL, ;
                nparcs    N(2,0)  NULL, ;
                Descs     N(5,2)  NULL, ;
                ValMins   N(11,2) NULL, ;
                ValMaxs   N(11,2) NULL, ;
                parcDes   N(1,0)  NULL, ;
                cidchaves C(20)   NULL  ;
            )
            SET NULL OFF

            loc_cSql = "SELECT fpags, nparcs, descs, valmins, valmaxs, parcdes, cidchaves " + ;
                       "FROM SigOpFpp " + ;
                       "WHERE fpags = " + EscaparSQL(par_cFpags) + " " + ;
                       "ORDER BY nparcs"

            IF SQLEXEC(gnConnHandle, loc_cSql, "xFPagiTemp") > 0
                SELECT xFPagi
                ZAP
                APPEND FROM DBF("xFPagiTemp")
                IF USED("xFPagiTemp")
                    USE IN xFPagiTemp
                ENDIF
            ENDIF

            SELECT xFPagi
            IF RECCOUNT() > 0
                INDEX ON nparcs TAG nparcs
                SET ORDER TO
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao carregar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinha - adiciona nova linha vazia no cursor local xFPagi
    * par_cFpags: codigo da condicao de pagamento para preencher fpags
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinha(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi")
                SELECT xFPagi
                INSERT INTO xFPagi ;
                    (fpags, nparcs, Descs, ValMins, ValMaxs, parcDes, cidchaves) ;
                    VALUES (par_cFpags, 0, 0, 0, 0, 0, "")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao inserir linha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinha - remove linha atual do cursor local xFPagi
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinha()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("xFPagi") AND NOT EOF("xFPagi")
                SELECT xFPagi
                DELETE
                SKIP
                SKIP -1
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao excluir linha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAntesDeSalvar - verifica duplicidade nparcs+descs em xFPagi
    * Retorna .T. se os dados sao validos para gravar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarAntesDeSalvar()
        LOCAL loc_lValido, loc_lDuplic

        loc_lValido = .T.

        IF USED("xFPagi")
            SELECT nparcs, Descs, SUM(1) AS nQtd ;
                FROM xFPagi ;
                WHERE nparcs > 0 AND (Descs > 0 OR parcDes > 0) ;
                GROUP BY nparcs, Descs ;
                HAVING SUM(1) > 1 ;
                INTO CURSOR cursor_4c_DupCheck READWRITE

            loc_lDuplic = (RECCOUNT("cursor_4c_DupCheck") > 0)

            IF USED("cursor_4c_DupCheck")
                USE IN cursor_4c_DupCheck
            ENDIF

            IF loc_lDuplic
                MsgAviso("Dados Inconsistentes. No. de Parcelas/% Desconto em duplicidade!!!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarDados - persiste cursor local xFPagi em SigOpFpp via SQLEXEC
    * par_cFpags: codigo da condicao de pagamento
    * Fluxo: valida -> DELETE FROM SigOpFpp -> re-INSERT linha a linha
    *--------------------------------------------------------------------------
    PROCEDURE SalvarDados(par_cFpags)
        LOCAL loc_lSucesso, loc_oErro, loc_cSql, loc_cChave, loc_lErroInsert

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarAntesDeSalvar()

                *-- Remove todos os registros anteriores desta condicao de pagamento
                loc_cSql = "DELETE FROM SigOpFpp WHERE fpags = " + EscaparSQL(par_cFpags)

                IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                    MsgErro("Erro ao remover registros de SigOpFpp.", "Erro")
                ELSE
                    *-- Re-insere a partir do cursor local xFPagi
                    loc_lErroInsert = .F.

                    IF USED("xFPagi")
                        SELECT xFPagi
                        GO TOP
                        SCAN WHILE !loc_lErroInsert
                            IF !EMPTY(xFPagi.nparcs) AND ;
                               (!EMPTY(xFPagi.Descs) OR !EMPTY(xFPagi.parcDes))

                                loc_cChave = SYS(2015)

                                loc_cSql = "INSERT INTO SigOpFpp " + ;
                                           "(cidchaves, fpags, nparcs, descs, " + ;
                                           " valmins, valmaxs, parcdes) " + ;
                                           "VALUES (" + ;
                                           EscaparSQL(loc_cChave) + ", " + ;
                                           EscaparSQL(xFPagi.fpags) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.nparcs,  0) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.Descs,   2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.ValMins, 2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.ValMaxs, 2) + ", " + ;
                                           FormatarNumeroSQL(xFPagi.parcDes, 0) + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSql) < 1
                                    MsgErro("Erro ao inserir linha em SigOpFpp." + CHR(13) + ;
                                            "Parcelas: " + TRANSFORM(xFPagi.nparcs), "Erro")
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_lErroInsert
                        THIS.RegistrarAuditoria("SALVAR")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao salvar dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSql, loc_oErro

        TRY
            loc_cSql = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, Chave, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cFpags) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSql)
        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

