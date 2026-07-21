# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 301: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 326: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprima.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (849 linhas total):

*-- Linhas 96 a 104:
96: 
97:         TRY
98:             *-- Caption com acentos (via CHR - proibido literal acentuado em .PRG)
99:             THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos"
100: 
101:             THIS.ConfigurarPageFrame()
102:             THIS.ConfigurarCabecalho()
103:             THIS.ConfigurarPaginaLista()
104:             THIS.ConfigurarPaginaDados()

*-- Linhas 143 a 190:
143:         THIS.AddObject("cnt_4c_Sombra", "Container")
144:         loc_oCnt = THIS.cnt_4c_Sombra
145:         WITH loc_oCnt
146:             .Top        = 0
147:             .Left       = 0
148:             .Width      = THIS.Width
149:             .Height     = 80
150:             .BorderWidth = 0
151:             .BackColor  = RGB(100,100,100)
152:             .Visible    = .T.
153: 
154:             .AddObject("lbl_4c_LblSombra", "Label")
155:             WITH .lbl_4c_LblSombra
156:                 .AutoSize      = .F.
157:                 .FontBold      = .T.
158:                 .FontName      = "Tahoma"
159:                 .FontSize      = 18
160:                 .FontUnderline = .F.
161:                 .WordWrap      = .T.
162:                 .Alignment     = 0
163:                 .BackStyle     = 0
164:                 .Caption       = loc_cCaption
165:                 .Height        = 40
166:                 .Left          = 10
167:                 .Top           = 18
168:                 .Width         = THIS.Width
169:                 .ForeColor     = RGB(0,0,0)
170:                 .Visible       = .T.
171:             ENDWITH
172: 
173:             .AddObject("lbl_4c_LblTitulo", "Label")
174:             WITH .lbl_4c_LblTitulo
175:                 .AutoSize      = .F.
176:                 .FontBold      = .T.
177:                 .FontName      = "Tahoma"
178:                 .FontSize      = 18
179:                 .WordWrap      = .T.
180:                 .Alignment     = 0
181:                 .BackStyle     = 0
182:                 .Caption       = loc_cCaption
183:                 .Height        = 46
184:                 .Left          = 10
185:                 .Top           = 17
186:                 .Width         = THIS.Width
187:                 .ForeColor     = RGB(255,255,255)
188:                 .ToolTipText   = "T" + CHR(237) + "tulo do Formul" + CHR(225) + "rio"
189:                 .Visible       = .T.
190:             ENDWITH

*-- Linhas 251 a 260:
251:     PROTECTED PROCEDURE ConfigurarPaginaDados()
252:         THIS.AddObject("obj_4c_Commandgroup3", "Container")
253:         WITH THIS.obj_4c_Commandgroup3
254:             .Top          = 7
255:             .Left         = 612
256:             .Width        = 173
257:             .Height       = 110
258:             .BackStyle    = 0
259:             .BorderWidth  = 1
260:             .SpecialEffect = 1

*-- Linhas 289 a 307:
289:     *==========================================================================
290:     PROTECTED PROCEDURE ConfigurarBotoes()
291:         *-- Botao Processar (equivalente ao btnProcessar fwbtng do legado)
292:         THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
293:         WITH THIS.cmd_4c_BtnProcessar
294:             .Top             = 3
295:             .Left            = 650
296:             .Width           = 75
297:             .Height          = 75
298:             .Caption         = "Processar"
299:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
300:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
301:             .FontName        = "Comic Sans MS"
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .FontSize        = 8
305:             .ForeColor       = RGB(90,90,90)
306:             .BackColor       = RGB(255,255,255)
307:             .Themes          = .T.

*-- Linhas 314 a 332:
314:         ENDWITH
315: 
316:         *-- Botao Encerrar (equivalente ao btnSair fwbtng do legado)
317:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
318:         WITH THIS.cmd_4c_BtnSair
319:             .Top             = 3
320:             .Left            = 725
321:             .Width           = 75
322:             .Height          = 75
323:             .Caption         = "Encerrar"
324:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
325:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
326:             .FontName        = "Comic Sans MS"
327:             .FontBold        = .T.
328:             .FontItalic      = .T.
329:             .FontSize        = 8
330:             .ForeColor       = RGB(90,90,90)
331:             .BackColor       = RGB(255,255,255)
332:             .Themes          = .T.

*-- Linhas 339 a 366:
339:             .Visible         = .T.
340:         ENDWITH
341: 
342:         BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "CmdBtnProcessarClick")
343:         BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "CmdBtnSairClick")
344:     ENDPROC
345: 
346:     *==========================================================================
347:     * ConfigurarCampos - Adiciona campos operacionais: label, textbox diretorio,
348:     * botao browse "...", label tipo e OptionGroup de tipo de importacao
349:     *==========================================================================
350:     PROTECTED PROCEDURE ConfigurarCampos()
351:         *-- Label "Diretorio :"
352:         THIS.AddObject("lbl_4c_Label1", "Label")
353:         WITH THIS.lbl_4c_Label1
354:             .AutoSize  = .T.
355:             .FontBold  = .T.
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .Caption   = "Diret" + CHR(243) + "rio :"
359:             .Height    = 15
360:             .Left      = 156
361:             .Top       = 113
362:             .Width     = 58
363:             .ForeColor = RGB(90,90,90)
364:             .BackStyle = 0
365:             .Visible   = .T.
366:         ENDWITH

*-- Linhas 372 a 416:
372:             .FontSize      = 8
373:             .Value         = ""
374:             .Height        = 21
375:             .Left          = 216
376:             .SpecialEffect = 1
377:             .TabIndex      = 2
378:             .Top           = 110
379:             .Width         = 402
380:             .ForeColor     = RGB(0,0,0)
381:             .Visible       = .T.
382:         ENDWITH
383: 
384:         *-- Botao "..." para navegar e selecionar diretorio
385:         THIS.AddObject("cmd_4c_BtnArquivo", "CommandButton")
386:         WITH THIS.cmd_4c_BtnArquivo
387:             .Top       = 110
388:             .Left      = 622
389:             .Height    = 21
390:             .Width     = 21
391:             .FontName  = "Tahoma"
392:             .FontSize  = 8
393:             .WordWrap  = .T.
394:             .Caption   = "..."
395:             .TabIndex  = 3
396:             .BackColor = RGB(255,255,255)
397:             .Themes    = .F.
398:             .Visible   = .T.
399:         ENDWITH
400: 
401:         *-- Label "Tipo :"
402:         THIS.AddObject("lbl_4c_Label2", "Label")
403:         WITH THIS.lbl_4c_Label2
404:             .AutoSize  = .T.
405:             .FontBold  = .T.
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .Caption   = "Tipo :"
409:             .Height    = 15
410:             .Left      = 182
411:             .Top       = 135
412:             .Width     = 32
413:             .ForeColor = RGB(90,90,90)
414:             .BackStyle = 0
415:             .Visible   = .T.
416:         ENDWITH

*-- Linhas 423 a 483:
423:             .BorderStyle = 0
424:             .Value       = 1
425:             .Height      = 63
426:             .Left        = 216
427:             .Top         = 129
428:             .Width       = 92
429:             .Visible     = .T.
430: 
431:             WITH .Buttons(1)
432:                 .FontBold      = .T.
433:                 .FontUnderline = .F.
434:                 .BackStyle     = 0
435:                 .Caption       = "Produtos"
436:                 .Height        = 15
437:                 .Left          = 5
438:                 .Top           = 5
439:                 .Width         = 69
440:                 .AutoSize      = .T.
441:                 .ForeColor     = RGB(90,90,90)
442:                 .Themes        = .F.
443:             ENDWITH
444: 
445:             WITH .Buttons(2)
446:                 .FontBold      = .T.
447:                 .FontName      = "Tahoma"
448:                 .FontSize      = 8
449:                 .FontUnderline = .F.
450:                 .BackStyle     = 0
451:                 .Caption       = "Auxiliar"
452:                 .Height        = 15
453:                 .Left          = 5
454:                 .Top           = 24
455:                 .Width         = 61
456:                 .AutoSize      = .T.
457:                 .ForeColor     = RGB(90,90,90)
458:                 .Themes        = .F.
459:             ENDWITH
460: 
461:             WITH .Buttons(3)
462:                 .FontBold      = .T.
463:                 .FontName      = "Tahoma"
464:                 .FontSize      = 8
465:                 .FontUnderline = .F.
466:                 .BackStyle     = 0
467:                 .Caption       = "Exportar"
468:                 .Height        = 15
469:                 .Left          = 5
470:                 .Top           = 44
471:                 .Width         = 67
472:                 .AutoSize      = .T.
473:                 .ForeColor     = RGB(90,90,90)
474:                 .Themes        = .F.
475:             ENDWITH
476:         ENDWITH
477: 
478:         BINDEVENT(THIS.cmd_4c_BtnArquivo, "Click",    THIS, "CmdBtnArquivoClick")
479:         BINDEVENT(THIS.txt_4c_Arquivo,    "KeyPress", THIS, "TxtArquivoKeyPress")
480:     ENDPROC
481: 
482:     *==========================================================================
483:     * CmdBtnArquivoClick - Abre dialogo GetDir para selecionar diretorio

*-- Linhas 752 a 761:
752:             THIS.obj_4c_OptTipo.Enabled = loc_lHab
753:         ENDIF
754: 
755:         IF PEMSTATUS(THIS, "cmd_4c_BtnArquivo", 5) AND VARTYPE(THIS.cmd_4c_BtnArquivo) = "O"
756:             THIS.cmd_4c_BtnArquivo.Enabled = loc_lHab
757:         ENDIF
758:     ENDPROC
759: 
760:     *==========================================================================
761:     * LimparCampos - Reseta os controles editaveis para valores default

*-- Linhas 813 a 827:
813:         loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "LISTA")))
814:         loc_lEditavel = (loc_cModo != "VISUALIZAR")
815: 
816:         IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5) AND ;
817:            VARTYPE(THIS.cmd_4c_BtnProcessar) = "O"
818:             THIS.cmd_4c_BtnProcessar.Enabled = loc_lEditavel
819:         ENDIF
820: 
821:         IF PEMSTATUS(THIS, "cmd_4c_BtnSair", 5) AND VARTYPE(THIS.cmd_4c_BtnSair) = "O"
822:             THIS.cmd_4c_BtnSair.Enabled = .T.
823:         ENDIF
824: 
825:         THIS.HabilitarCampos(loc_lEditavel)
826:     ENDPROC
827: 


### BO (C:\4c\projeto\app\classes\sigprimaBO.prg):
*====================================================================
* sigprimaBO.prg
* Business Object: Importacao/Exportacao de Imagens de Produtos
* Tabela principal: sigscjim
* Formulario OPERACIONAL
*====================================================================

DEFINE CLASS sigprimaBO AS BusinessBase

    *-- Tabela e chave (sigscjim)
    this_cTabela      = "sigscjim"
    this_cCampoChave  = "cidchaves"

    *-- Campos da tabela sigscjim
    this_cCidchaves = ""    && char(20) - chave primaria
    this_cCpros     = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_nIdimagem  = 0     && numeric(38,0) - id imagem
    this_cRefforref = ""    && char(50) - referencia do fornecedor

    *-- Parametros de operacao (passados via Init do form)
    this_cDiretorio = ""    && caminho do diretorio de imagens
    this_nTipoOp    = 1     && 1=Produtos, 2=Auxiliar(sigscjim), 3=Exportar
    this_cTipo1     = ""    && modo de execucao: 'A'=automatico, ''=manual

    *-- Resultado do processamento
    this_lSucesso   = .F.   && resultado do ultimo processamento
    this_cMsgFinal  = ""    && mensagem resultado a exibir

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigscjim"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *====================================================================
    * ValidarDados - Valida dados antes de inserir/atualizar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor sigscjim
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_nIdimagem  = TratarNulo(idimagem,  "N")
            THIS.this_cRefforref = TratarNulo(refforref, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidchaves = fUniqueIds()
            loc_cSQL = "INSERT INTO sigscjim " + ;
                       "(cidchaves, cpros, idimagem, refforref) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIdimagem, 0) + ", " + ;
                       EscaparSQL(THIS.this_cRefforref) + ;
                       ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro na tabela sigscjim
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE sigscjim SET " + ;
                       "cpros     = " + EscaparSQL(THIS.this_cCpros)               + ", " + ;
                       "idimagem  = " + FormatarNumeroSQL(THIS.this_nIdimagem, 0)  + ", " + ;
                       "refforref = " + EscaparSQL(THIS.this_cRefforref)           + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em sigscjim."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Processamento - Importa imagens JPG para produtos (SigCdPro) ou
    *                 registros auxiliares (sigscjim)
    * par_cDiretorio - diretorio com as imagens JPG
    * par_nTipo      - 1=Produtos, 2=Auxiliar(sigscjim)
    *====================================================================
    PROCEDURE Processamento(par_cDiretorio, par_nTipo)
        LOCAL loc_lSucesso, loc_cDir, loc_nTip, loc_nArq, loc_oErro
        LOCAL loc_oProgress, loc_nImg, loc_cImg, loc_cPro
        LOCAL loc_cDpro2, loc_cDpro3, loc_cReff, loc_cFig
        LOCAL loc_cSQL, loc_cQuery, loc_cMsg, loc_cDok, loc_cNom
        LOCAL loc_cArq, loc_cAok, loc_nCnt, loc_lVer, loc_lArq
        LOCAL loc_cImagem, loc_cImagem2, loc_cChave, loc_cOrigem
        LOCAL loc_nExiste
        LOCAL ARRAY loc_aArq(1)

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_nTip     = IIF(VARTYPE(par_nTipo) = "N", par_nTipo, 1)

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            loc_nArq = ADIR(loc_aArq, loc_cDir + "*.JPG")

            IF loc_nArq < 1
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Cont" + CHR(233) + "m Nenhuma Imagem do Tipo .JPG!!!", ;
                         "Arquivos Inv" + CHR(225) + "lidos")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Nenhuma imagem .JPG encontrada."
                loc_lSucesso = .F.
            ENDIF

            loc_oProgress = CREATEOBJECT("fwprogressbar", "Processando Imagens...", loc_nArq)
            loc_oProgress.Show()

            loc_lSucesso = .T.

            FOR loc_nImg = 1 TO loc_nArq
                IF !loc_lSucesso
                    EXIT
                ENDIF

                loc_cImg  = ALLTRIM(loc_aArq(loc_nImg, 1))
                loc_lArq  = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")

                loc_cPro   = PADR(SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1), 14)
                loc_cDpro2 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cDpro3 = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)
                loc_cReff  = SUBSTR(loc_cImg, 1, AT(".JPG", UPPER(loc_cImg)) - 1)

                loc_oProgress.SubTitulo.Caption = "Arquivo : " + ALLTRIM(loc_cImg)
                loc_oProgress.Update(.T.)

                IF loc_lArq
                    loc_cFig = loc_cDir + loc_cImg

                    IF FILE(loc_cFig)

                        IF loc_nTip = 2
                            *-- Modo auxiliar: busca em sigscjim por idimagem
                            loc_cQuery = "SELECT * FROM sigscjim WHERE idimagem = " + ;
                                         ALLTRIM(loc_cPro) + " ORDER BY CPros"

                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        loc_cImagem = FILETOSTR(loc_cFig)
                                        loc_cSQL    = "UPDATE sigscjim SET Imagem = ?loc_cImagem " + ;
                                                      "WHERE idimagem = " + ALLTRIM(loc_cPro) + ;
                                                      " AND CPros = " + EscaparSQL(cursor_4c_LocalPro.CPros)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigScjIm!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ELSE
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ENDIF

                                        IF USED("cursor_4c_Upd")
                                            USE IN cursor_4c_Upd
                                        ENDIF
                                    ENDIF
                                ENDSCAN
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF

                        ELSE
                            *-- Modo produtos: busca em SigCdPro por CPros/descricao/referencia

                            *-- Tentativa 1: busca por CPros
                            loc_cQuery = "SELECT * FROM SigCdPro WHERE CPros = " + ;
                                         EscaparSQL(loc_cPro) + " ORDER BY CPros"
                            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                        "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                loc_lSucesso = .F.
                            ENDIF

                            *-- Tentativa 2: busca por dPro2s
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(loc_cDpro2)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 3: busca por dPro2s sem pontos
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE dPro2s = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro2, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 4: busca por reffs (referencia fornecedor)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro WHERE reffs = " + ;
                                             EscaparSQL(ALLTRIM(loc_cReff)) + " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            *-- Tentativa 5: busca por dPro3s (descricao completa)
                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") = 0
                                IF USED("cursor_4c_LocalPro")
                                    USE IN cursor_4c_LocalPro
                                ENDIF
                                loc_cQuery = "SELECT * FROM SigCdPro " + ;
                                             "WHERE CONVERT(VARCHAR(50),dPro3s) = " + ;
                                             EscaparSQL(ALLTRIM(STRTRAN(loc_cDpro3, ".", ""))) + ;
                                             " ORDER BY CPros"
                                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                            "Falha na Conex" + CHR(227) + "o (LocalPro)")
                                    loc_lSucesso = .F.
                                ENDIF
                            ENDIF

                            IF loc_lSucesso AND USED("cursor_4c_LocalPro") AND ;
                               RECCOUNT("cursor_4c_LocalPro") > 0
                                SELECT cursor_4c_LocalPro
                                GO TOP IN cursor_4c_LocalPro
                                SCAN
                                    IF loc_lSucesso
                                        loc_cPro = cursor_4c_LocalPro.CPros

                                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                                        *-- UPDATE SigCdPro com imagem
                                        loc_cImagem2 = FILETOSTR(loc_cFig)
                                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                                   "FigJpgs = ?loc_cImagem2, " + ;
                                                   "DtFilms = GETDATE(), " + ;
                                                   "Datas = GETDATE(), " + ;
                                                   "Flagctabs = 1, " + ;
                                                   "Transps = 0 " + ;
                                                   "WHERE CPros = " + EscaparSQL(loc_cPro)

                                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                                    "Processamento Cancelado!!!")
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                            loc_lSucesso = .F.
                                        ENDIF

                                        IF USED("cursor_4c_UpdPro")
                                            USE IN cursor_4c_UpdPro
                                        ENDIF

                                        *-- UPDATE/INSERT SigCdPrc com dados de auditoria
                                        IF loc_lSucesso
                                            loc_cChave  = fUniqueIds()
                                            loc_cOrigem = LEFT(TTOC(DATETIME()) + " SIGPRIMA", 50)

                                            IF SQLEXEC(gnConnHandle, ;
                                                "SELECT COUNT(1) AS nExiste FROM SigCdPrc " + ;
                                                "WHERE CPros = " + EscaparSQL(loc_cPro), ;
                                                "cursor_4c_ExistePrc") > 0 AND ;
                                               USED("cursor_4c_ExistePrc")
                                                SELECT cursor_4c_ExistePrc
                                                loc_nExiste = NVL(nExiste, 0)
                                                USE IN cursor_4c_ExistePrc
                                            ELSE
                                                loc_nExiste = 0
                                            ENDIF

                                            IF loc_nExiste > 0
                                                loc_cSQL = "UPDATE SigCdPrc SET " + ;
                                                           "DataAlts = GETDATE(), " + ;
                                                           "HoraAlts = " + EscaparSQL(TIME()) + ", " + ;
                                                           "UsuaAlts = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ", " + ;
                                                           "Origem   = " + EscaparSQL(loc_cOrigem) + ;
                                                           " WHERE CPros = " + EscaparSQL(loc_cPro)
                                            ELSE
                                                loc_cSQL = "INSERT INTO SigCdPrc " + ;
                                                           "(cIdChaves, CPros, DataAlts, " + ;
                                                           "HoraAlts, UsuaAlts, Origem) VALUES (" + ;
                                                           EscaparSQL(loc_cChave)                      + ", " + ;
                                                           EscaparSQL(loc_cPro)                        + ", " + ;
                                                           "GETDATE(), "                               + ;
                                                           EscaparSQL(TIME())                          + ", " + ;
                                                           EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))    + ", " + ;
                                                           EscaparSQL(loc_cOrigem)                     + ;
                                                           ")"
                                            ENDIF

                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                                        "vel Atualizar o Arquivo SigCdPrc!!!", ;
                                                        "Processamento Cancelado!!!")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        *-- DELETE FROM SigPrPrt
                                        IF loc_lSucesso
                                            loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + ;
                                                       EscaparSQL(loc_cPro)
                                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                MsgErro("Favor Reinicializar o Processo!!!", ;
                                                        "Falha na Conex" + CHR(227) + "o (SigPrPrt)")
                                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                                loc_lSucesso = .F.
                                            ENDIF
                                        ENDIF

                                        IF loc_lSucesso
                                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                                        ELSE
                                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                        ENDIF
                                    ENDIF
                                ENDSCAN

                                *-- Move arquivo para subpasta OK apos processamento
                                IF loc_lSucesso
                                    loc_cDok = loc_cDir + "OK\"
                                    IF !DIRECTORY(loc_cDok)
                                        MD (loc_cDok)
                                    ENDIF

                                    IF !DIRECTORY(loc_cDok)
                                        MsgAviso("O Diret" + CHR(243) + "rio [" + loc_cDok + ;
                                                 "] N" + CHR(227) + "o Pode Ser Criado!!!", ;
                                                 "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                                        loc_lSucesso = .F.
                                    ELSE
                                        loc_cNom = ALLTRIM(loc_aArq(loc_nImg, 1))
                                        loc_lArq = !(LEFT(loc_aArq(loc_nImg, 5), 1) = "R")
                                        IF loc_lArq
                                            loc_cArq = loc_cDir + loc_cNom
                                            loc_cAok = ALLTRIM(loc_cDok) + "\" + ALLTRIM(loc_cNom)
                                            loc_nCnt = 0
                                            loc_lVer = .T.
                                            DO WHILE loc_lVer
                                                IF !FILE(loc_cAok)
                                                    loc_lVer = .F.
                                                    COPY FILE (loc_cArq) TO (loc_cAok)
                                                    IF FILE(loc_cAok)
                                                        DELETE FILE (loc_cArq)
                                                    ENDIF
                                                ELSE
                                                    loc_nCnt = loc_nCnt + 1
                                                    loc_cAok = loc_cDok + "\" + loc_cNom + "." + ;
                                                               PADL(loc_nCnt, 4, "0")
                                                ENDIF
                                            ENDDO
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_LocalPro")
                                USE IN cursor_4c_LocalPro
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            NEXT

            loc_oProgress.Complete()

            IF !loc_lSucesso
                loc_cMsg = "Os Arquivos N" + CHR(227) + "o Foram Importados!!!"
            ELSE
                loc_cMsg = "Os Arquivos Foram Importados!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

    *====================================================================
    * Exportar - Exporta imagens de produtos para arquivos JPG e
    *            converte para base64 (campo FigJpgs64)
    * par_cDiretorio - diretorio destino para os arquivos exportados
    *====================================================================
    PROCEDURE Exportar(par_cDiretorio)
        LOCAL loc_lSucesso, loc_cDir, loc_cMsg, loc_cQuery, loc_oErro
        LOCAL loc_cPro, loc_cFiltro, loc_cImag, loc_cSQL

        loc_lSucesso = .F.
        loc_cDir     = ADDBS(ALLTRIM(par_cDiretorio))
        loc_cFiltro  = ""

        TRY
            IF EMPTY(loc_cDir)
                MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                         "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Diret" + CHR(243) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Busca grupos de produtos com imagem
            loc_cQuery = "SELECT cgrus, COUNT(1) AS qtd FROM sigcdpro " + ;
                         "WHERE 0=0 " + loc_cFiltro + ;
                         " GROUP BY cgrus ORDER BY 2"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_Grupos") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (Grupos)")
                THIS.this_lSucesso  = .F.
                THIS.this_cMsgFinal = "Falha ao buscar grupos."
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

            SELECT cursor_4c_Grupos
            GO TOP IN cursor_4c_Grupos
            SCAN
                WAIT WINDOW "Atualizando o Grupo " + cursor_4c_Grupos.cgrus NOWAIT

                *-- Busca produtos do grupo
                loc_cQuery = "SELECT * FROM sigcdpro WHERE cgrus = " + ;
                             EscaparSQL(cursor_4c_Grupos.cgrus) + " " + loc_cFiltro
                IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_LocalPro") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Produtos)")
                    loc_lSucesso = .F.
                ENDIF

                IF loc_lSucesso AND USED("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    GO TOP IN cursor_4c_LocalPro

                    SCAN
                        *-- Pula produtos sem imagem
                        IF EMPTY(cursor_4c_LocalPro.FigJpgs)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Pula produtos que ja tem base64
                        IF !EMPTY(cursor_4c_LocalPro.FigJpgs64)
                            SELECT cursor_4c_LocalPro
                            LOOP
                        ENDIF

                        *-- Exporta imagem para arquivo
                        loc_cPro = ALLTRIM(STRTRAN(STRTRAN(STRTRAN( ;
                                   cursor_4c_LocalPro.cpros, "*", "_"), "/", "-"), "\", "-"))
                        STRTOFILE(cursor_4c_LocalPro.FigJpgs, ;
                                  loc_cDir + loc_cPro + ".jpg", .T.)

                        *-- Converte para base64 e atualiza FigJpgs64
                        loc_cImag = STRCONV(cursor_4c_LocalPro.FigJpgs, 13, 1046)

                        loc_cSQL = "UPDATE SigCdPro SET " + ;
                                   "FigJpgs64 = " + EscaparSQL("data:image/jpeg;base64," + loc_cImag) + ", " + ;
                                   "DtFilms   = GETDATE(), " + ;
                                   "Datas     = GETDATE(), " + ;
                                   "Flagctabs = 1, " + ;
                                   "Transps   = 0 " + ;
                                   "WHERE CPros = " + EscaparSQL(cursor_4c_LocalPro.cpros)

                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                        ELSE
                            MsgErro("N" + CHR(227) + "o Foi Poss" + CHR(237) + ;
                                    "vel Atualizar o Arquivo SigCdPro!!!", ;
                                    "Processamento Cancelado!!!")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT cursor_4c_LocalPro
                    ENDSCAN

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                ENDIF

                SELECT cursor_4c_Grupos
            ENDSCAN

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            IF !loc_lSucesso
                loc_cMsg = "N" + CHR(227) + "o houve exporta" + CHR(231) + CHR(227) + "o!!!"
            ELSE
                loc_cMsg = "Exporta" + CHR(231) + CHR(227) + "o executada com sucesso!!!"
            ENDIF

            MsgInfo(loc_cMsg, "Processamento Conclu" + CHR(237) + "do!!!")

            THIS.this_lSucesso  = loc_lSucesso
            THIS.this_cMsgFinal = loc_cMsg

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lSucesso  = .F.
            THIS.this_cMsgFinal = loc_oErro.Message
        ENDTRY

        RETURN THIS.this_lSucesso
    ENDPROC

ENDDEFINE

