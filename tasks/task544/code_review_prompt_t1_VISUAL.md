# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [ALINHAMENTO] Botao 'cmd_4c_Encerrar' tem Top=1 mas grupo usa Top=0 (diferenca de 1px)
- [FONTNAME-ERRADO] Linha 411: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 434: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 480: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormTPG.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (902 linhas total):

*-- Linhas 6 a 26:
6: *
7: * Layout do legado (single-page, sem abas):
8: *   cntSombra (cabecalho escuro)      -> cnt_4c_Cabecalho
9: *   Grid1 (Emps/TpTrans/Tps editaveis) -> grd_4c_Dados
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

*-- Linhas 134 a 143:
134:             ELSE
135:                 THIS.ConfigurarPageFrame()
136: 
137:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
138:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
139: 
140:                 THIS.ConfigurarPaginaLista()
141:                 THIS.BindEventos()
142: 
143:                 *-- Pula carga SQL em modo de validacao de UI (sem conexao)

*-- Linhas 175 a 222:
175:             *-- Cabecalho escuro (cntSombra do legado: Top=-2, Left=-2, W=800, H=80)
176:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
177:             WITH THIS.cnt_4c_Cabecalho
178:                 .Top         = -2
179:                 .Left        = -2
180:                 .Width       = THIS.Width
181:                 .Height      = 80
182:                 .BackStyle   = 1
183:                 .BackColor   = RGB(100, 100, 100)
184:                 .BorderWidth = 0
185:                 .Visible     = .T.
186:             ENDWITH
187: 
188:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
189:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
190:                 .FontBold  = .T.
191:                 .FontName  = "Tahoma"
192:                 .FontSize  = 18
193:                 .WordWrap  = .T.
194:                 .Alignment = 0
195:                 .BackStyle = 0
196:                 .AutoSize  = .F.
197:                 .Caption   = ""
198:                 .Height    = 40
199:                 .Left      = 10
200:                 .Top       = 18
201:                 .Width     = THIS.Width - 20
202:                 .ForeColor = RGB(0, 0, 0)
203:             ENDWITH
204: 
205:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
206:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
207:                 .FontBold  = .T.
208:                 .FontName  = "Tahoma"
209:                 .FontSize  = 18
210:                 .WordWrap  = .T.
211:                 .Alignment = 0
212:                 .BackStyle = 0
213:                 .AutoSize  = .F.
214:                 .Caption   = ""
215:                 .Height    = 46
216:                 .Left      = 10
217:                 .Top       = 17
218:                 .Width     = THIS.Width - 20
219:                 .ForeColor = RGB(255, 255, 255)
220:             ENDWITH
221: 
222:         CATCH TO loc_oErro

*-- Linhas 270 a 279:
270:         loc_oGrid = THIS.grd_4c_Dados
271: 
272:         WITH loc_oGrid
273:             .Top           = 96
274:             .Left          = 201
275:             .Width         = 233
276:             .Height        = 308
277:             .ColumnCount   = 3
278:             .FontName      = "Tahoma"
279:             .FontSize      = 8

*-- Linhas 295 a 303:
295:             .Width     = 56
296:             .ForeColor = RGB(90, 90, 90)
297:         ENDWITH
298:         loc_oCol.Header1.Caption   = "Empresa"
299:         loc_oCol.Header1.FontName  = "Tahoma"
300:         loc_oCol.Header1.FontSize  = 8
301:         loc_oCol.Header1.ForeColor = RGB(90, 90, 90)
302:         loc_oCol.Text1.FontName    = "Tahoma"
303:         loc_oCol.Text1.FontSize    = 8

*-- Linhas 315 a 323:
315:             .Width     = 89
316:             .ForeColor = RGB(90, 90, 90)
317:         ENDWITH
318:         loc_oCol.Header1.Caption   = "Tipo de Transp."
319:         loc_oCol.Header1.FontName  = "Tahoma"
320:         loc_oCol.Header1.FontSize  = 8
321:         loc_oCol.Header1.ForeColor = RGB(90, 90, 90)
322:         loc_oCol.Text1.FontName    = "Tahoma"
323:         loc_oCol.Text1.FontSize    = 8

*-- Linhas 335 a 343:
335:             .Width     = 56
336:             .ForeColor = RGB(90, 90, 90)
337:         ENDWITH
338:         loc_oCol.Header1.Caption   = "Tipo (T/R)"
339:         loc_oCol.Header1.FontName  = "Tahoma"
340:         loc_oCol.Header1.FontSize  = 8
341:         loc_oCol.Header1.ForeColor = RGB(90, 90, 90)
342:         loc_oCol.Text1.FontName    = "Tahoma"
343:         loc_oCol.Text1.FontSize    = 8

*-- Linhas 368 a 486:
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
382:     * Posicoes EXATAS do legado: cmdinserir Left=366/Top=2, cmdexcluir
383:     * Left=441/Top=2, ambos filhos diretos de SIGCDTPG (sem container la;
384:     * agrupados aqui num container transparente so por organizacao interna)
385:     *==========================================================================
386:     PROTECTED PROCEDURE ConfigurarBotoesCrud()
387:         LOCAL loc_oCnt
388: 
389:         THIS.AddObject("cnt_4c_Botoes", "Container")
390:         loc_oCnt = THIS.cnt_4c_Botoes
391:         WITH loc_oCnt
392:             .Top         = 2
393:             .Left        =  542
394:             .Width       = 150
395:             .Height      = 75
396:             .BackStyle   = 0
397:             .BorderWidth = 0
398:             .Visible     = .T.
399:         ENDWITH
400: 
401:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
402:         WITH loc_oCnt.cmd_4c_Incluir
403:             .Top            = 0
404:             .Left           = 0
405:             .Width          = 75
406:             .Height         = 75
407:             .Caption        = "\<Incluir"
408:             .Picture        = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
409:             .FontBold       = .T.
410:             .FontItalic     = .T.
411:             .FontName       = "Comic Sans MS"
412:             .FontSize       = 8
413:             .ForeColor      = RGB(90, 90, 90)
414:             .BackColor      = RGB(255, 255, 255)
415:             .Themes         = .F.
416:             .SpecialEffect  = 0
417:             .PicturePosition = 13
418:             .MousePointer   = 15
419:             .WordWrap       = .T.
420:             .AutoSize       = .F.
421:             .Visible        = .T.
422:         ENDWITH
423: 
424:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
425:         WITH loc_oCnt.cmd_4c_Excluir
426:             .Top            = 0
427:             .Left = 230
428:             .Width          = 75
429:             .Height         = 75
430:             .Caption        = "\<Excluir"
431:             .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
432:             .FontBold       = .T.
433:             .FontItalic     = .T.
434:             .FontName       = "Comic Sans MS"
435:             .FontSize       = 8
436:             .ForeColor      = RGB(90, 90, 90)
437:             .BackColor      = RGB(255, 255, 255)
438:             .Themes         = .F.
439:             .SpecialEffect  = 0
440:             .PicturePosition = 13
441:             .MousePointer   = 15
442:             .WordWrap       = .T.
443:             .AutoSize       = .F.
444:             .Visible        = .T.
445:         ENDWITH
446:     ENDPROC
447: 
448:     *==========================================================================
449:     * ConfigurarBotaoEncerrar - Commandgroup1(Command3) do legado ->
450:     * cnt_4c_Saida.cmd_4c_Encerrar. Posicoes EXATAS do legado (Left=511,
451:     * W=90/H=110 + botao Left=5,W=75,H=75) - NAO eh o padrao canonico
452:     * Left=917 do CLAUDE.md #10, porque esse padrao vale so para forms CRUD
453:     * (frmcadastro, Width=1000); este eh OPERACIONAL flat com Width=592
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
456:         LOCAL loc_oCnt
457: 
458:         THIS.AddObject("cnt_4c_Saida", "Container")
459:         loc_oCnt = THIS.cnt_4c_Saida
460:         WITH loc_oCnt
461:             .Top         = 1
462:             .Left        = 917
463:             .Width       = 90
464:             .Height      = 110
465:             .BackStyle   = 0
466:             .BorderWidth = 0
467:             .Visible     = .T.
468:         ENDWITH
469: 
470:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
471:         WITH loc_oCnt.cmd_4c_Encerrar
472:             .Top             = 1
473:             .Left            = 5
474:             .Width           = 75
475:             .Height          = 75
476:             .Caption         = "Encerrar"
477:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
478:             .FontBold        = .T.
479:             .FontItalic      = .T.
480:             .FontName        = "Comic Sans MS"
481:             .FontSize        = 8
482:             .ForeColor       = RGB(90, 90, 90)
483:             .BackColor       = RGB(255, 255, 255)
484:             .Themes          = .F.
485:             .SpecialEffect   = 0
486:             .PicturePosition = 13

*-- Linhas 497 a 517:
497:     * regra #3 - BINDEVENT exige metodo publico)
498:     *==========================================================================
499:     PROTECTED PROCEDURE BindEventos()
500:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
501:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
502:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
503: 
504:         *-- Lookups/validacao das 3 colunas editaveis do grid (Fase 6)
505:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "Col1EmpsKeyPress")
506:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "Col2TpTransKeyPress")
507:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "KeyPress", THIS, "Col3TpsKeyPress")
508:     ENDPROC
509: 
510:     *==========================================================================
511:     * Col1EmpsKeyPress - Column1.Text1 (Emps) KeyPress. Equivalente ao Valid
512:     * legado: fAcessoEmpresa(Usuar,'C',...) (funcao nao portada - lesson
513:     * feedback_facessoempresa_nao_portada) foi substituida por: F4 sempre
514:     * abre o lookup de Empresa; Enter/Tab valida existencia em SigCdEmp e,
515:     * se nao achar, abre o mesmo lookup. Ao final roda a checagem de
516:     * duplicidade Emps+TpTrans+Tps (igual nos 3 Valid do legado).
517:     *==========================================================================


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

