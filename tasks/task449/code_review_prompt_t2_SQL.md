# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CARQICONES, BARRAPICT

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
	lcQuery = [select carqicones,marqicones,']+Space(128)+[' as ctmpicones from SigSyIco order by 1]  &&Tras Dados da Tabela
		Select ('crTmpcdico')
		.Column1.ControlSource = 'crTmpcdIco.carqicones'
	If Not Seek(JustFname(LOWER(m.lcArqIcone)),'crTmpcdIco','carqicones')  &&Caso nao seja encontrado no Banco de Dados
	    Update crTmpcdIco set carqicones=JustFname(LOWER(m.lcArqIcone)), marqicones=FILETOSTR(m.lcArqIcone ) where carqicones=JustFname(m.lcArqIcone)  &&Atualiza tabela	
		m.lnErro1 = Iif(ThisForm.podatamgr.Update('crTmpcdico'),1,-1)
	Select crTmpcdIco
	Delete from crTmpcdico where carqicones=m.registro
		m.lnErro1 = Iif(ThisForm.podatamgr.Update('crTmpcdico'),1,-1)
	Select crTmpcdIco

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormICO.prg) - TRECHOS RELEVANTES PARA PASS SQL (825 linhas total):

*-- Linhas 68 a 86:
68:                 IF USED("crTmpcdico")
69:                     THIS.grd_4c_Dados.ColumnCount              = 1
70:                     THIS.grd_4c_Dados.RecordSource             = "crTmpcdico"
71:                     THIS.grd_4c_Dados.Column1.ControlSource    = "crTmpcdico.carqicones"
72:                     THIS.grd_4c_Dados.Column1.Header1.Caption  = CHR(205) + "cones"
73:                     THIS.grd_4c_Dados.Visible = .T.
74:                     THIS.grd_4c_Dados.Refresh()
75:                     THIS.AtualizarPreview()
76:                     THIS.grd_4c_Dados.SetFocus()
77:                 ENDIF
78:             ENDIF
79: 
80:             THIS.LockScreen = .F.
81:             loc_lSucesso = .T.
82:         CATCH TO loc_oErro
83:             THIS.LockScreen = .F.
84:             MsgErro(loc_oErro.Message + CHR(13) + ;
85:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
86:                 "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 183 a 201:
183:             .ReadOnly          = .T.
184:             .AllowHeaderSizing = .F.
185:             .AllowRowSizing    = .F.
186:             .DeleteMark        = .F.
187:             .RecordMark        = .F.
188:             .ScrollBars        = 2
189:             .HeaderHeight      = 15
190:             .RowHeight         = 15
191: 
192:             .FontName = "Courier New"
193:             .SetAll("FontName",    "Verdana",           "Header")
194:             .SetAll("FontName",    "Courier New",       "TextBox")
195:             .FontSize = 9
196:             .SetAll("FontSize",    8,                   "Header")
197:             .SetAll("FontSize",    9,                   "TextBox")
198:             .SetAll("Format",      "K",                 "Column")
199:             .SetAll("Format",      "K",                 "TextBox")
200:             .SetAll("Movable",     .F.,                 "Column")
201:             .SetAll("ReadOnly",    .T.,                 "Column")

*-- Linhas 323 a 341:
323:         loc_cArquivo = ""
324:         loc_cNomeArq = ""
325:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
326:             SELECT crTmpcdico
327:             loc_cArquivo = ALLTRIM(crTmpcdico.ctmpicones)
328:             loc_cNomeArq = ALLTRIM(crTmpcdico.carqicones)
329:         ENDIF
330:         IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
331:             THIS.img_4c_Icone.Picture = loc_cArquivo
332:             THIS.img_4c_Icone.Visible = .T.
333:         ELSE
334:             THIS.img_4c_Icone.Visible = .F.
335:         ENDIF
336:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
337:             THIS.lbl_4c_NomeIcone.Caption = loc_cNomeArq
338:         ENDIF
339:     ENDPROC
340: 
341:     *--------------------------------------------------------------------------

*-- Linhas 388 a 430:
388:             loc_lExiste = USED("crTmpcdico") AND SEEK(loc_cNomeArq, "crTmpcdico", "carqicones")
389: 
390:             IF !loc_lExiste
391:                 SELECT crTmpcdico
392:                 APPEND BLANK
393:             ELSE
394:                 SELECT crTmpcdico
395:             ENDIF
396: 
397:             REPLACE carqicones WITH loc_cNomeArq
398:             REPLACE marqicones WITH FILETOSTR(loc_cArqIcone)
399:             REPLACE ctmpicones WITH loc_cArqTemp
400: 
401:             LOCAL loc_nBytes
402:             loc_nBytes = STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)
403: 
404:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeArq
405:             THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
406: 
407:             LOCAL loc_lSucesso
408:             IF !loc_lExiste
409:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir()
410:             ELSE
411:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
412:             ENDIF
413: 
414:             THIS.grd_4c_Dados.Refresh()
415:             SELECT crTmpcdico
416:             GO TOP
417:             LOCATE FOR carqicones == loc_cNomeArq
418:             THIS.AtualizarPreview()
419:             THIS.Refresh()
420:             THIS.LockScreen = .F.
421:             THIS.grd_4c_Dados.SetFocus()
422:         CATCH TO loc_oErro
423:             THIS.LockScreen = .F.
424:             MsgErro(loc_oErro.Message + CHR(13) + ;
425:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
426:                 "Procedure: " + loc_oErro.Procedure, ;
427:                 "Erro ao Incluir " + CHR(205) + "cone")
428:         ENDTRY
429:     ENDPROC
430: 

*-- Linhas 438 a 456:
438:                 RETURN
439:             ENDIF
440: 
441:             SELECT crTmpcdico
442:             LOCAL loc_cRegistro
443:             loc_cRegistro = ALLTRIM(crTmpcdico.carqicones)
444: 
445:             IF EMPTY(loc_cRegistro)
446:                 RETURN
447:             ENDIF
448: 
449:             IF !MsgConfirma("Tem certeza que deseja Excluir?", "Excluir")
450:                 RETURN
451:             ENDIF
452: 
453:             THIS.LockScreen = .T.
454: 
455:             IF THIS.this_oBusinessObject.VerificarUsoIcone(loc_cRegistro)
456:                 MsgAviso("Existem " + CHR(237) + "tens cadastrados que est" + CHR(227) + ;

*-- Linhas 462 a 482:
462: 
463:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cRegistro
464:             IF THIS.this_oBusinessObject.Excluir()
465:                 DELETE FROM crTmpcdico WHERE ALLTRIM(carqicones) = loc_cRegistro
466:                 THIS.grd_4c_Dados.Refresh()
467:                 SELECT crTmpcdico
468:                 GO TOP
469:                 LOCATE FOR carqicones > loc_cRegistro
470:                 IF EOF()
471:                     GO BOTTOM
472:                 ENDIF
473:                 THIS.AtualizarPreview()
474:                 THIS.Refresh()
475:                 THIS.grd_4c_Dados.SetFocus()
476:             ENDIF
477: 
478:             THIS.LockScreen = .F.
479:         CATCH TO loc_oErro
480:             THIS.LockScreen = .F.
481:             MsgErro(loc_oErro.Message + CHR(13) + ;
482:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 508 a 526:
508:                 RETURN
509:             ENDIF
510: 
511:             SELECT crTmpcdico
512:             LOCAL loc_cNomeAtual
513:             loc_cNomeAtual = ALLTRIM(crTmpcdico.carqicones)
514: 
515:             IF EMPTY(loc_cNomeAtual)
516:                 MsgAviso("Selecione um " + CHR(237) + "cone na lista para alterar.", "Aviso")
517:                 RETURN
518:             ENDIF
519: 
520:             loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")
521: 
522:             IF EMPTY(loc_cArqIcone)
523:                 RETURN
524:             ENDIF
525: 
526:             IF !FILE(loc_cArqIcone)

*-- Linhas 540 a 571:
540:             loc_cArqTemp  = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
541:             loc_mConteudo = FILETOSTR(loc_cArqIcone)
542: 
543:             SELECT crTmpcdico
544:             REPLACE marqicones WITH loc_mConteudo
545:             REPLACE ctmpicones WITH loc_cArqTemp
546: 
547:             STRTOFILE(loc_mConteudo, loc_cArqTemp)
548: 
549:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeAtual
550:             THIS.this_oBusinessObject.this_cMarqIcones = loc_mConteudo
551: 
552:             LOCAL loc_lSucesso
553:             loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
554: 
555:             THIS.grd_4c_Dados.Refresh()
556:             SELECT crTmpcdico
557:             LOCATE FOR ALLTRIM(carqicones) == loc_cNomeAtual
558:             THIS.AtualizarPreview()
559:             THIS.Refresh()
560:             THIS.LockScreen = .F.
561:             THIS.grd_4c_Dados.SetFocus()
562:         CATCH TO loc_oErro
563:             THIS.LockScreen = .F.
564:             MsgErro(loc_oErro.Message + CHR(13) + ;
565:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
566:                 "Procedure: " + loc_oErro.Procedure, ;
567:                 "Erro ao Alterar " + CHR(205) + "cone")
568:         ENDTRY
569:     ENDPROC
570: 
571:     *--------------------------------------------------------------------------

*-- Linhas 583 a 601:
583:                 RETURN
584:             ENDIF
585: 
586:             SELECT crTmpcdico
587:             LOCAL loc_cNome
588:             loc_cNome = ALLTRIM(crTmpcdico.carqicones)
589: 
590:             IF EMPTY(loc_cNome)
591:                 MsgAviso("Selecione um " + CHR(237) + "cone na lista para visualizar.", "Aviso")
592:                 RETURN
593:             ENDIF
594: 
595:             *-- Se o arquivo temporario foi removido, regenerar a partir do MEMO
596:             LOCAL loc_cArqTemp
597:             loc_cArqTemp = ALLTRIM(crTmpcdico.ctmpicones)
598:             IF EMPTY(loc_cArqTemp) OR !FILE(loc_cArqTemp)
599:                 loc_cArqTemp = ADDBS(SYS(2023)) + "ArqIcone" + SYS(2015) + ".ico"
600:                 IF !EMPTY(crTmpcdico.marqicones)
601:                     STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)

*-- Linhas 686 a 704:
686:             IF USED("crTmpcdico")
687:                 THIS.grd_4c_Dados.ColumnCount             = 1
688:                 THIS.grd_4c_Dados.RecordSource            = "crTmpcdico"
689:                 THIS.grd_4c_Dados.Column1.ControlSource   = "crTmpcdico.carqicones"
690:                 THIS.grd_4c_Dados.Column1.Header1.Caption = CHR(205) + "cones"
691:                 THIS.grd_4c_Dados.Visible = .T.
692:                 THIS.grd_4c_Dados.Refresh()
693:                 THIS.AtualizarPreview()
694:                 THIS.HabilitarCampos()
695:             ENDIF
696:             THIS.LockScreen = .F.
697:         CATCH TO loc_oErro
698:             THIS.LockScreen = .F.
699:             MsgErro(loc_oErro.Message + CHR(13) + ;
700:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
701:                 "Procedure: " + loc_oErro.Procedure, ;
702:                 "Erro ao Carregar Lista")
703:         ENDTRY
704:     ENDPROC

*-- Linhas 724 a 756:
724:     PROCEDURE BtnCancelarClick()
725:         THIS.LimparCampos()
726:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
727:             SELECT crTmpcdico
728:             GO TOP
729:             THIS.AtualizarPreview()
730:         ENDIF
731:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
732:             THIS.grd_4c_Dados.SetFocus()
733:         ENDIF
734:     ENDPROC
735: 
736:     *--------------------------------------------------------------------------
737:     * FormParaBO - Sincroniza o registro selecionado no grid com o BO
738:     *--------------------------------------------------------------------------
739:     PROCEDURE FormParaBO()
740:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
741:             SELECT crTmpcdico
742:             THIS.this_oBusinessObject.this_cCarqIcones = ALLTRIM(crTmpcdico.carqicones)
743:             THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
744:             IF TYPE("crTmpcdico.ctmpicones") != "U"
745:                 THIS.this_oBusinessObject.this_cCtmpIcones = ALLTRIM(crTmpcdico.ctmpicones)
746:             ENDIF
747:         ENDIF
748:     ENDPROC
749: 
750:     *--------------------------------------------------------------------------
751:     * BOParaForm - Sincroniza o BO com a area de preview e label de nome
752:     *--------------------------------------------------------------------------
753:     PROCEDURE BOParaForm()
754:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
755:             THIS.lbl_4c_NomeIcone.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cCarqIcones)
756:         ENDIF


### BO (C:\4c\projeto\app\classes\ICOBO.prg):
*==============================================================================
* ICOBO.prg - Business Object: Cadastro de Icones (SigSyIco)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS ICOBO AS BusinessBase

    *-- Cursor de dados exibido no grid
    this_cCursorDados   = "crTmpcdico"

    *-- Nome do arquivo de icone selecionado/atual
    this_cCarqIcones    = ""

    *-- Conteudo binario do icone (MEMO)
    this_cMarqIcones    = ""

    *-- Caminho temporario do arquivo extraido para exibicao
    this_cCtmpIcones    = ""

    *-- Diretorio temporario usado para extracao dos icones
    this_cDirTemp       = ""

    *-- Indica se os icones ja foram carregados no cursor
    this_lCarregado     = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela      = "SigSyIco"
        THIS.this_cCampoChave  = "carqicones"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave primaria atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCarqIcones)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCarqIcones = TratarNulo(carqicones, "C")
            THIS.this_cMarqIcones = NVL(marqicones, "")
            IF TYPE("ctmpicones") != "U"
                THIS.this_cCtmpIcones = ALLTRIM(ctmpicones)
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarIcones - Carrega todos os icones do SQL Server para crTmpcdico
    *   par_cDirTemp: diretorio temporario para extrair arquivos de icone
    *--------------------------------------------------------------------------
    FUNCTION CarregarIcones(par_cDirTemp)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_cDirTemp = ADDBS(par_cDirTemp)

            *-- Fechar cursores anteriores
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            IF USED("crTmpcdico")
                USE IN crTmpcdico
            ENDIF

            *-- Criar cursor principal com estrutura identica ao legado
            SET NULL ON
            CREATE CURSOR crTmpcdico ( ;
                carqicones  C(128) NULL, ;
                marqicones  M NULL, ;
                ctmpicones  C(255) NULL ;
            )
            SET NULL OFF

            *-- Carregar dados do SQL Server
            LOCAL loc_cSQL
            loc_cSQL = "SELECT carqicones, marqicones FROM SigSyIco ORDER BY carqicones"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpcdico_Temp")
            IF loc_nResult > 0
                *-- Declarar variaveis do SCAN antes do loop
                LOCAL loc_cNome, loc_cArqTemp, loc_nTam
                loc_cNome    = ""
                loc_cArqTemp = ""
                loc_nTam     = 0

                IF USED("crTmpcdico_Temp") AND RECCOUNT("crTmpcdico_Temp") > 0
                    SELECT crTmpcdico_Temp
                    SCAN
                        loc_cNome    = ALLTRIM(crTmpcdico_Temp.carqicones)
                        loc_cArqTemp = ""

                        *-- Extrair conteudo binario para arquivo temporario
                        IF !EMPTY(crTmpcdico_Temp.marqicones)
                            loc_cArqTemp = THIS.this_cDirTemp + "ArqIcone" + SYS(2015) + ".ico"
                            loc_nTam = STRTOFILE(crTmpcdico_Temp.marqicones, loc_cArqTemp)
                            IF loc_nTam > 0
                                loc_cArqTemp = LOWER(loc_cArqTemp)
                            ELSE
                                loc_cArqTemp = ""
                            ENDIF
                        ENDIF

                        *-- Popular cursor principal
                        SELECT crTmpcdico
                        APPEND BLANK
                        REPLACE carqicones WITH loc_cNome
                        REPLACE marqicones WITH crTmpcdico_Temp.marqicones
                        REPLACE ctmpicones WITH loc_cArqTemp
                        SELECT crTmpcdico_Temp
                    ENDSCAN
                ENDIF

                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF

                *-- Indexar e posicionar no inicio
                SELECT crTmpcdico
                INDEX ON carqicones TAG carqicones
                SET ORDER TO carqicones IN crTmpcdico
                GO TOP IN crTmpcdico

                THIS.this_lCarregado = .T.
                loc_lResultado = .T.
            ELSE
                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao carregar " + CHR(237) + "cones: " + loc_aErros[1,2], "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar " + CHR(205) + "cones")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo icone no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "INSERT INTO SigSyIco (carqicones, marqicones) VALUES (?loc_cNome, ?loc_mConteudo)"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao inserir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Inserir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza icone existente no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "UPDATE SigSyIco SET marqicones = ?loc_mConteudo WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao atualizar " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Atualizar " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui icone do SQL Server (chamado por Excluir())
    *   Requer this_cCarqIcones populado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_cSQL
            loc_cSQL = "DELETE FROM SigSyIco WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao excluir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Excluir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Excluir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoIcone - Verifica se icone esta referenciado em SigCdPrg.barrapict
    *   par_cNomeIcone: nome do arquivo (carqicones)
    *   Retorna .T. se em uso (nao pode excluir)
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoIcone(par_cNomeIcone)
        LOCAL loc_lEmUso, loc_oErro
        loc_lEmUso = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(par_cNomeIcone)

            LOCAL loc_cSQL
            loc_cSQL = "SELECT COUNT(*) AS nQtd FROM SigCdPrg WHERE barrapict = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVerificaUsoIco")
            IF loc_nResult > 0
                IF USED("crVerificaUsoIco")
                    loc_lEmUso = (NVL(crVerificaUsoIco.nQtd, 0) > 0)
                    USE IN crVerificaUsoIco
                ENDIF
            ELSE
                IF USED("crVerificaUsoIco")
                    USE IN crVerificaUsoIco
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("crVerificaUsoIco")
                USE IN crVerificaUsoIco
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Verificar Uso do " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lEmUso
    ENDFUNC

ENDDEFINE

