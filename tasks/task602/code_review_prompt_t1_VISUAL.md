# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (961 linhas total):

*-- Linhas 21 a 31:
21: *   Fase 3:   Formsigprema.prg - estrutura base (heranca, Init, InicializarForm,
22: *             ConfigurarCabecalho, TornarControlesVisiveis, Destroy)
23: *   Fase 4:   Grid grd_4c_Dados (5 colunas: Checks/Contas/Rclis/Emails/
24: *             EmpDopNums), botoes standalone cmd_4c_SelTudo/cmd_4c_Apaga
25: *             (legado SelTudo/apaga - nao ha container no SCX original),
26: *             cmg_4c_Encerrar (legado Commandgroup1/btnSair), cmd_4c_EnviarEmail
27: *             (legado btnEmail) e shp_4c_Decoracao (legado Shape1). CarregarDados
28: *             (BO.BuscarDadosProcessamento) e todos os handlers (ordenacao por
29: *             coluna, toggle de Checks, Marcar/Desmarcar Todos, Encerrar e envio
30: *             de e-mail via BO.EnviarEmailSelecionados) ja ligados nesta fase -
31: *             o BO ja tinha tudo pronto desde a Fase 1/2.

*-- Linhas 146 a 154:
146: *                 Fase 7 corrigiu em CmgEncerrarClick. Passou a
147: *                 BtnProcessarEmailClick, fiel ao Caption do form
148: *                 ("Processamento e Geracao de Email") e ao que o metodo faz,
149: *                 sem renomear o CONTROLE (cmd_4c_EnviarEmail) nem os
150: *                 metodos do BO (EnviarEmail/EnviarEmailSelecionados), que
151: *                 seguem descrevendo o meio de entrega.
152: *               BtnCancelarClick - NAO SE APLICA. Nao ha Page2/modo de
153: *                 edicao para cancelar - a unica saida da tela e' o
154: *                 Encerrar (BtnEncerrarClick), igual ao legado.

*-- Linhas 330 a 381:
330:     *--------------------------------------------------------------------------
331:     PROTECTED PROCEDURE ConfigurarCabecalho()
332:         LOCAL loc_oErro
333: 
334:         TRY
335:             THIS.AddObject("cnt_4c_Sombra", "Container")
336:             WITH THIS.cnt_4c_Sombra
337:                 .Top         = 0
338:                 .Left        = 0
339:                 .Width       = THIS.Width
340:                 .Height      = 80
341:                 .BackColor   = RGB(100, 100, 100)
342:                 .BackStyle   = 1
343:                 .BorderWidth = 0
344: 
345:                 .AddObject("lbl_4c_Sombra", "Label")
346:                 WITH .lbl_4c_Sombra
347:                     .Top       = 18
348:                     .Left      = 10
349:                     .Width     = THIS.Width
350:                     .Height    = 40
351:                     .FontBold  = .T.
352:                     .FontName  = "Tahoma"
353:                     .FontSize  = 18
354:                     .AutoSize  = .F.
355:                     .BackStyle = 0
356:                     .WordWrap  = .T.
357:                     .Alignment = 0
358:                     .ForeColor = RGB(0, 0, 0)
359:                     .Caption   = THIS.Caption
360:                 ENDWITH
361: 
362:                 .AddObject("lbl_4c_Titulo", "Label")
363:                 WITH .lbl_4c_Titulo
364:                     .Top       = 17
365:                     .Left      = 10
366:                     .Width     = THIS.Width
367:                     .Height    = 46
368:                     .FontBold  = .T.
369:                     .FontName  = "Tahoma"
370:                     .FontSize  = 18
371:                     .AutoSize  = .F.
372:                     .BackStyle = 0
373:                     .WordWrap  = .T.
374:                     .Alignment = 0
375:                     .ForeColor = RGB(255, 255, 255)
376:                     .Caption   = THIS.Caption
377:                 ENDWITH
378: 
379:                 .Visible = .T.
380:             ENDWITH
381:         CATCH TO loc_oErro

*-- Linhas 403 a 412:
403:             loc_oGrid = THIS.grd_4c_Dados
404: 
405:             WITH loc_oGrid
406:                 .Top        = 126
407:                 .Left       = 3
408:                 .Width      = 993
409:                 .Height     = 469
410:                 .FontName   = "Verdana"
411:                 .FontSize   = 8
412:                 .RowHeight  = 18

*-- Linhas 429 a 442:
429:                 .Column4.ControlSource = "cursor_4c_Dados.Emails"
430:                 .Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"
431: 
432:                 *-- Coluna de selecao (equivalente ao Column6/fwcheckbox1 legado) -
433:                 *-- AddObject + CurrentControl OBRIGATORIAMENTE antes do ControlSource
434:                 *-- (CLAUDE.md regra #18)
435:                 .Column1.AddObject("chk_4c_Checks", "CheckBox")
436:                 WITH .Column1.chk_4c_Checks
437:                     .Caption   = ""
438:                     .Alignment = 0
439:                     .Value     = 0
440:                     .BackStyle = 0
441:                     .Visible   = .T.
442:                 ENDWITH

*-- Linhas 457 a 482:
457:                 .Column4.ReadOnly = .F.
458:                 .Column5.ReadOnly = .T.
459: 
460:                 .Column1.Header1.Caption = ""
461: 
462:                 .Column2.Header1.Caption   = "Conta"
463:                 .Column2.Header1.Alignment = 2
464:                 .Column2.Header1.FontName  = "Tahoma"
465:                 .Column2.Header1.FontSize  = 8
466: 
467:                 .Column3.Header1.Caption   = "Nome"
468:                 .Column3.Header1.Alignment = 2
469:                 .Column3.Header1.FontName  = "Tahoma"
470:                 .Column3.Header1.FontSize  = 8
471: 
472:                 .Column4.Header1.Caption   = "Email"
473:                 .Column4.Header1.Alignment = 2
474:                 .Column4.Header1.FontName  = "Tahoma"
475:                 .Column4.Header1.FontSize  = 8
476: 
477:                 .Column5.Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
478:                 .Column5.Header1.FontName = "Tahoma"
479:                 .Column5.Header1.FontSize = 8
480: 
481:                 .Visible = .T.
482:             ENDWITH

*-- Linhas 528 a 538:
528:     ENDPROC
529: 
530:     *--------------------------------------------------------------------------
531:     * ChkChecksInteractiveChange - Grava o novo estado do checkbox no cursor de
532:     * trabalho. Transcricao literal do "Replace Checks With this.Value in
533:     * crLocalTotal" do PROCEDURE InteractiveChange legado (Column6.fwcheckbox1).
534:     * PUBLIC (sem PROTECTED) - metodo alvo de BINDEVENT (CLAUDE.md regra #3).
535:     *--------------------------------------------------------------------------
536:     PROCEDURE ChkChecksInteractiveChange()
537:         LOCAL loc_oChk
538: 

*-- Linhas 725 a 836:
725:             *-- Shape decorativo em torno do bloco Encerrar/Enviar Email (Shape1)
726:             THIS.AddObject("shp_4c_Decoracao", "Shape")
727:             WITH THIS.shp_4c_Decoracao
728:                 .Top           = 7
729:                 .Left          = 804
730:                 .Width         = 90
731:                 .Height        = 110
732:                 .BackStyle     = 0
733:                 .BorderStyle   = 0
734:                 .BorderWidth   = 1
735:                 .SpecialEffect = 1
736:                 .BorderColor   = RGB(136, 189, 188)
737:                 .Visible       = .T.
738:             ENDWITH
739: 
740:             *-- Enviar Email (legado btnEmail)
741:             THIS.AddObject("cmd_4c_EnviarEmail", "CommandButton")
742:             WITH THIS.cmd_4c_EnviarEmail
743:                 .Top             = 3
744:                 .Left            = 850
745:                 .Width           = 75
746:                 .Height          = 75
747:                 .FontBold        = .T.
748:                 .FontItalic      = .T.
749:                 .FontName        = "Comic Sans MS"
750:                 .FontSize        = 8
751:                 .Caption         = "Enviar Email"
752:                 .ToolTipText     = "Enviar Email"
753:                 .ForeColor       = RGB(90, 90, 90)
754:                 .BackColor       = RGB(255, 255, 255)
755:                 .Picture         = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
756:                 .Themes          = .T.
757:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
758:                 .Visible         = .T.
759:             ENDWITH
760:             BINDEVENT(THIS.cmd_4c_EnviarEmail, "Click", THIS, "BtnProcessarEmailClick")
761: 
762:             *-- Marcar Todos (legado SelTudo)
763:             THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
764:             WITH THIS.cmd_4c_SelTudo
765:                 .Top             = 84
766:                 .Left            = 4
767:                 .Width           = 40
768:                 .Height          = 40
769:                 .FontName        = "Verdana"
770:                 .FontSize        = 8
771:                 .WordWrap        = .T.
772:                 .Caption         = ""
773:                 .TabStop         = .F.
774:                 .ToolTipText     = "Marcar Todos"
775:                 .ForeColor       = RGB(36, 84, 155)
776:                 .BackColor       = RGB(255, 255, 255)
777:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
778:                 .Themes          = .T.
779:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
780:                 .Visible         = .T.
781:             ENDWITH
782:             BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
783: 
784:             *-- Desmarcar Todos (legado apaga)
785:             THIS.AddObject("cmd_4c_Apaga", "CommandButton")
786:             WITH THIS.cmd_4c_Apaga
787:                 .Top             = 84
788:                 .Left            = 43
789:                 .Width           = 40
790:                 .Height          = 40
791:                 .FontName        = "Verdana"
792:                 .FontSize        = 8
793:                 .WordWrap        = .T.
794:                 .Caption         = ""
795:                 .TabStop         = .F.
796:                 .ToolTipText     = "Desmarcar Todos"
797:                 .ForeColor       = RGB(36, 84, 155)
798:                 .BackColor       = RGB(255, 255, 255)
799:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
800:                 .Themes          = .T.
801:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
802:                 .Visible         = .T.
803:             ENDWITH
804:             BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
805: 
806:             *-- Encerrar (legado Commandgroup1/btnSair)
807:             THIS.AddObject("cmg_4c_Encerrar", "CommandGroup")
808:             WITH THIS.cmg_4c_Encerrar
809:                 .Top           = -2
810:                 .Left          = 920
811:                 .Width         = 85
812:                 .Height        = 85
813:                 .ButtonCount   = 1
814:                 .BackStyle     = 0
815:                 .BorderStyle   = 0
816:                 .SpecialEffect = 1
817:                 .BorderColor   = RGB(136, 189, 188)
818:                 .Themes        = .F.
819: 
820:                 WITH .Buttons(1)
821:                     .Top         = 5
822:                     .Left        = 5
823:                     .Width       = 75
824:                     .Height      = 75
825:                     .FontBold    = .T.
826:                     .FontItalic  = .T.
827:                     .FontName    = "Comic Sans MS"
828:                     .FontSize    = 8
829:                     .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
830:                     .Cancel      = .T.
831:                     .Caption     = "Encerrar"
832:                     .ToolTipText = "[Esc] Encerrar"
833:                     .ForeColor   = RGB(90, 90, 90)
834:                     .BackColor   = RGB(255, 255, 255)
835:                     .Themes      = .F.
836:                 ENDWITH


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* SIGPREMABO.PRG
* Business Object do formulario Formsigprema (Processamento e Geracao de Email)
* Responsabilidade: montar a lista de e-mails a enviar (movimentos
* de SigMvCab cruzados com SigCdCli e com os contatos padrao de SigCdPam),
* gerar o PDF do documento (via ImpDocto) e disparar o envio (via CDO.Message)
* usando os dados de conta de e-mail cadastrados em SigCdEmp.
*
* SIGPREMA nao tem uma unica tabela/CRUD associada no legado: o Init monta um
* cursor de trabalho (crLocalTotal) a partir de VARIAS consultas (SigMvCab +
* SigCdCli + SigCdPam), e os botoes da tela operam sobre esse cursor em lote.
* Por isso this_cTabela e this_cCampoChave permanecem vazios - nao ha um
* unico registro/PK sendo editado, e sim uma lista de linhas selecionaveis
* identificadas pela chave posicional EmpDopNums (Emps char(3) + Dopes
* char(20) + Str(Numes,6) = 29 chars - ver regra da chave posicional,
* CLAUDE.md Erro177: NUNCA aplicar ALLTRIM nas partes ao montar/comparar essa
* chave, so na chave inteira ja montada).
*
* BO SOMENTE-LEITURA - POR QUE NAO HA Inserir() / Atualizar() PROPRIOS
* --------------------------------------------------------------------
* Varredura do dump legado (tasks\task602\sigprema_form_codigo_fonte.txt):
* o form NAO grava em tabela nenhuma do SQL Server. Os unicos Insert Into /
* Replace do legado (linhas 829, 870, 1004, 1115, 1133) tem por destino o
* CURSOR LOCAL crLocalTotal; todo acesso remoto eh de LEITURA (SqlExecute
* com Select, e cursorquery). SigOpLog aparece so dentro do
* "not in (select Transacaos from sigoplog ...)" do Init - eh lido, nunca
* escrito por este form.
*
* Portanto Inserir(), Atualizar() e ExecutarExclusao() NAO sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase (recusar a operacao
* e reportar pelo ExibirFalha do Salvar) ja eh o correto para esta tela, e
* escrever INSERT/UPDATE inventado violaria o PILAR 2 e a regra #22 do
* CLAUDE.md (lista de colunas tirada do schema, nunca adivinhada).
*
* O unico ponto do legado que PARECE gravar eh
* "fGravarLog('T', Thisform.Name, [], lcEdn)" (linha 1085). O de-para dos
* argumentos com dbo.SigOpLog nao foi confirmado - o fonte legado de
* fGravarLog nao veio no acervo - entao a chamada segue pelo wrapper
* no-op projeto\app\utils\fgravarlog.prg (mesma decisao documentada la).
* Ver RegistrarLogEnvio() no fim deste arquivo.
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Parametros recebidos pelo Init do form legado (prDopes, pAuto)
    this_cDopes         = ""    && prDopes - EmpDopNums usado para filtrar um unico movimento (vazio = processa todos os movimentos do dia ainda nao enviados)
    this_lAutomatico    = .F.   && pAuto - .T. quando a tela eh chamada em modo automatico (dispara o envio e fecha sozinha)
    this_cEmpresa       = ""    && Thisform.lcEmp - Substr(prDopes,1,3), codigo da empresa do movimento filtrado
    this_nTempo         = 5000  && Thisform.ntempo - timeout (ms) usado nos MessageBox/Wait Window do legado
    this_cEscolha       = ""    && Thisform.pcEscolha
    this_cArquivoEmail  = ""    && Thisform.pcArqEmail - caminho do PDF gerado para anexar ao e-mail

    *-- Intervalo de datas usado para buscar os movimentos do dia (pDti/pDtf)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Campos da linha corrente do cursor de trabalho crLocalTotal
    this_nChecks        = 0     && Checks N(1) - .T./1 quando a linha esta marcada para envio
    this_cGrupos        = ""    && grupos C(10)
    this_cContas        = ""    && Contas C(10) - codigo do cliente (SigCdCli.Iclis)
    this_cRclis         = ""    && Rclis C(50) - razao social/nome do cliente (ver CREATE CURSOR em BuscarDadosProcessamento)
    this_cEmails        = ""    && emails C(50)
    this_cMensagens     = ""    && mensagems M (memo)
    this_cEmpDopNums    = ""    && EmpDopNums C(29) - chave posicional Emps(3)+Dopes(20)+Str(Numes,6)
    this_cPrioridade    = ""    && prioridade C(15) - "NORMAL" por padrao

    *-- Dados da conta de e-mail da empresa (SigCdEmp), usados para disparar o envio
    this_cRemetente     = ""    && TmpEmpMail.PadEmails
    this_cServidorSmtp  = ""    && TmpEmpMail.PadServs
    this_cSenhaSmtp     = ""    && TmpEmpMail.PadSenhas
    this_nPortaSmtp     = 0     && TmpEmpMail.PadPortas

    *-- Parametros de um envio individual de e-mail (equivalentes ao PROCEDURE memail do legado)
    this_cDestinatario  = ""    && tcTo
    this_cCopia         = ""    && tcCC
    this_cAssunto       = ""    && tcAssunto
    this_cCorpo         = ""    && tcCorpo
    this_cAnexo         = ""    && tcAnexo

    *-- Alias do cursor de trabalho com a lista de e-mails a enviar
    *-- (equivalente a crLocalTotal do legado)
    this_cCursorDados   = "cursor_4c_Dados"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPREMA nao tem tabela/PK unica associada (ver cabecalho do arquivo)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SIGPREMA nao tem PK unica (ver cabecalho do
    * arquivo); devolve a chave posicional EmpDopNums da linha corrente do
    * cursor de trabalho, que eh o mais proximo de uma "identidade" que este
    * BO tem. RegistrarAuditoria() da base ja aborta sozinha quando a chave
    * vem vazia, entao nao ha auditoria indevida por causa disso.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNums - Monta a chave posicional EmpDopNums char(29) =
    * Emps char(3) + Dopes char(20) + Str(Numes,6).
    *
    * CLAUDE.md Erro177: a chave eh POSICIONAL - NUNCA aplicar ALLTRIM nas
    * PARTES antes de concatenar (o padding faz parte da chave e o SELECT
    * que compara essa chave passa a devolver ZERO linhas em silencio). So a
    * chave INTEIRA, ja montada, pode levar ALLTRIM com seguranca.
    *--------------------------------------------------------------------------
    PROCEDURE MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
        RETURN PADR(par_cEmps, 3) + PADR(par_cDopes, 20) + STR(par_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades this_* a partir da linha
    * corrente do cursor de trabalho (this_cCursorDados / cursor_4c_Dados)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nChecks     = NVL(Checks, 0)
                THIS.this_cGrupos     = TratarNulo(Grupos, "")
                THIS.this_cContas     = TratarNulo(Contas, "")
                THIS.this_cRclis      = TratarNulo(Rclis, "")
                THIS.this_cEmails     = TratarNulo(Emails, "")
                THIS.this_cMensagens  = TratarNulo(Mensagens, "")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "")
                THIS.this_cPrioridade = TratarNulo(Prioridade, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDadosProcessamento - Monta this_cCursorDados (cursor_4c_Dados,
    * equivalente a crLocalTotal do legado) com a lista de e-mails a enviar.
    *
    * par_cDopes vazio -> processa TODOS os movimentos do dia ainda nao
    *   registrados em SigOpLog para o programa SIGPREMA (equivalente ao
    *   "Empty(prDopes)" do Init legado).
    * par_cDopes = EmpDopNums completo (29 chars) -> processa so aquele
    *   movimento (equivalente ao Else do Init legado).
    *
    * Retorna .T. se o carregamento foi bem-sucedido.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDadosProcessamento(par_cDopes)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_cDopesLimpo
        LOCAL loc_nChecksPam, loc_cGruposPam, loc_cContasPam, loc_cRclisPam, loc_cEmailsPam

        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            THIS.this_cDopes = TratarNulo(par_cDopes, "")
            loc_cDopesLimpo  = ALLTRIM(THIS.this_cDopes)

            IF !EMPTY(loc_cDopesLimpo)
                THIS.this_cEmpresa = SUBSTR(loc_cDopesLimpo, 1, 3)
            ENDIF

            *-- Janela do dia corrente (equivalente a pDti/pDtf do legado)
            THIS.this_dDataInicial = DATETIME()
            THIS.this_dDataFinal   = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

            *-- Recria o cursor de trabalho (equivalente ao Create Cursor crLocalTotal)
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorDados) ;
                (Checks N(1) NULL, Grupos C(10) NULL, Contas C(10) NULL, ;
                 Rclis C(50) NULL, Emails C(50) NULL, Mensagens M NULL, ;
                 EmpDopNums C(29) NULL, Prioridade C(15) NULL)
            SET NULL OFF

            INDEX ON Contas TAG Contas
            INDEX ON Rclis  TAG Rclis
            INDEX ON Emails TAG Emails

            *-- Cabecalho dos movimentos (SigMvCab + SigCdCli)
            IF USED("cursor_4c_TmpMvCab")
                USE IN cursor_4c_TmpMvCab
            ENDIF

            IF EMPTY(loc_cDopesLimpo)
                loc_cSQL = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Emails, b.Grupos, b.Iclis " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                           "WHERE a.Datatrans BETWEEN " + FormatarDataSQL(THIS.this_dDataInicial) + ;
                           " AND " + FormatarDataSQL(THIS.this_dDataFinal) + " " + ;
                           "AND a.EmpDopNums NOT IN (SELECT Transacaos FROM SigOpLog WHERE Progs = 'SIGPREMA') " + ;
                           "ORDER BY a.EmpDopNums"
            ELSE
                loc_cSQL = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, b.Rclis, b.Emails, b.Grupos, b.Iclis " + ;
                           "FROM SigMvCab a " + ;
                           "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                           "WHERE a.EmpDopNums = " + EscaparSQL(loc_cDopesLimpo)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMvCab") < 1
                MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (TmpMvCab).", "Erro")
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                *-- Grava os dados no cursor de trabalho para envio dos e-mails
                SELECT cursor_4c_TmpMvCab
                GO TOP
                SCAN
                    INSERT INTO (THIS.this_cCursorDados) ;
                        (Checks, Grupos, Contas, Rclis, Emails, Prioridade, EmpDopNums) ;
                        VALUES ;
                        (cursor_4c_TmpMvCab.Checks, cursor_4c_TmpMvCab.Grupos, ;
                         cursor_4c_TmpMvCab.Iclis, cursor_4c_TmpMvCab.Rclis, ;
                         cursor_4c_TmpMvCab.Emails, "NORMAL", cursor_4c_TmpMvCab.EmpDopNums)
                ENDSCAN

                *-- Contas do grupo parametrizado em SigCdPam (grpadats)
                IF USED("cursor_4c_LocalPAM")
                    USE IN cursor_4c_LocalPAM
                ENDIF

                loc_cSQL = "SELECT 0 AS Checks, c.Grupos, c.Iclis AS Contas, c.Rclis, c.Emails, '' AS Prioridade " + ;
                           "FROM SigCdPam p " + ;
                           "INNER JOIN SigCdCli c ON c.Grupos = p.Grpadats"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPAM") < 1
                    MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                            "Falha na conex" + CHR(227) + "o (SigCdPam).", "Erro")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Adiciona os destinatarios do grupo parametrizado, filtrando
                *-- por Job quando o cliente tem restricao em SigClJob, e sem
                *-- duplicar quem ja foi inserido a partir do movimento
                SELECT cursor_4c_LocalPAM
                SCAN
                    IF USED("cursor_4c_TmpClJob")
                        USE IN cursor_4c_TmpClJob
                    ENDIF

                    loc_cSQL = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_LocalPAM.Contas))

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpClJob") < 1
                        MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                                "Falha na conex" + CHR(227) + "o (TmpClJob).", "Erro")
                        loc_lAbortar = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_TmpClJob
                    GO TOP
                    IF !EOF()
                        LOCATE FOR ALLTRIM(Jobs) = ALLTRIM(cursor_4c_TmpMvCab.Jobs)
                        IF EOF()
                            SELECT cursor_4c_LocalPAM
                            LOOP
                        ENDIF
                    ENDIF

                    loc_nChecksPam = cursor_4c_LocalPAM.Checks
                    loc_cGruposPam = ""
                    loc_cContasPam = ALLTRIM(cursor_4c_LocalPAM.Contas)
                    loc_cRclisPam  = ALLTRIM(cursor_4c_LocalPAM.Rclis)
                    loc_cEmailsPam = ALLTRIM(cursor_4c_LocalPAM.Emails)

                    SELECT (THIS.this_cCursorDados)
                    LOCATE FOR ALLTRIM(Contas) = loc_cContasPam AND ALLTRIM(Rclis) = loc_cRclisPam
                    IF EOF()
                        INSERT INTO (THIS.this_cCursorDados) ;
                            (Checks, Grupos, Contas, Rclis, Emails, EmpDopNums, Prioridade) ;
                            VALUES ;
                            (loc_nChecksPam, loc_cGruposPam, loc_cContasPam, loc_cRclisPam, ;
                             loc_cEmailsPam, THIS.this_cDopes, "NORMAL")
                    ENDIF

                    SELECT cursor_4c_LocalPAM
                ENDSCAN
            ENDIF

            IF !loc_lAbortar
                *-- Ordena por nome, igual ao legado (column3.header1.Click no Init)
                THIS.OrdenarPorColuna("Rclis")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.BuscarDadosProcessamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todas as linhas do cursor de trabalho (Checks = 1),
    * equivalente ao botao SelTudo do legado
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
            REPLACE ALL Checks WITH 1
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todas as linhas do cursor de trabalho
    * (Checks = 0), equivalente ao botao apaga (Desmarcar Todos) do legado
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
            REPLACE ALL Checks WITH 0
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OrdenarPorColuna - Reordena o cursor de trabalho pelo TAG solicitado,
    * equivalente ao Click dos headers de coluna do grid legado.
    * par_cTag: "Contas" | "Rclis" | "Emails"
    *--------------------------------------------------------------------------
    PROCEDURE OrdenarPorColuna(par_cTag)
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            DO CASE
            CASE UPPER(ALLTRIM(par_cTag)) = "CONTAS"
                SET ORDER TO TAG Contas
            CASE UPPER(ALLTRIM(par_cTag)) = "RCLIS"
                SET ORDER TO TAG Rclis
            CASE UPPER(ALLTRIM(par_cTag)) = "EMAILS"
                SET ORDER TO TAG Emails
            ENDCASE
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDadosContaEmail - Busca a conta de e-mail (SMTP) parametrizada
    * para a empresa em SigCdEmp e popula this_cRemetente/this_cServidorSmtp/
    * this_cSenhaSmtp/this_nPortaSmtp (equivalente a consulta a TmpEmpMail no
    * PROCEDURE Click do btnEmail legado). par_cCodEmpresa deve vir de
    * go_4c_Sistema.cCodEmpresa - NUNCA da legada _Empr.
    *--------------------------------------------------------------------------
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, PadPortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodEmpresa))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                MsgErro("Favor reinicializar o processo!!!" + CHR(13) + ;
                        "Falha na conex" + CHR(227) + "o (TmpEmpMail).", "Erro")
            ELSE
                SELECT cursor_4c_TmpEmpMail
                GO TOP
                IF !EOF()
                    THIS.this_cRemetente    = LOWER(ALLTRIM(TratarNulo(PadEmails, "")))
                    THIS.this_cServidorSmtp = LOWER(ALLTRIM(TratarNulo(PadServs, "")))
                    THIS.this_cSenhaSmtp    = ALLTRIM(TratarNulo(PadSenhas, ""))
                    THIS.this_nPortaSmtp    = NVL(PadPortas, 0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.ObterDadosContaEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Dispara o envio via CDO.Message (SMTP).
    *
    * DE ONDE VEM ESTE CORPO: o btnEmail.Click legado (linha 1079) chama a
    * funcao GLOBAL EnviaEmail(...), que NAO veio no acervo (nao esta em
    * Framework\sigacess.PRG nem em lugar nenhum do dump). O que veio foi o
    * PROCEDURE memail do proprio SCX (linha 695) - mesma rotina CDO, com a
    * ordem dos argumentos diferente - e memail nunca eh chamado no legado
    * (a unica outra mencao, linha 1163, esta comentada). Este metodo eh a
    * transcricao do corpo de memail, que eh a melhor evidencia disponivel
    * do que EnviaEmail faz.
    *
    * Por isso NAO se cria wrapper utils\enviaemail.prg (regra #27 do
    * CLAUDE.md): a chamada mora no codigo do FORM, que estamos migrando -
    * ela eh substituida por este metodo, nao redirecionada.
    *
    * De-para dos argumentos, conferido contra a chamada legada
    * EnviaEmail(lcReceptor, lcTxtMensagem, lcAssunto, lcArqAnexo, lcFrom,
    *            lcReceptorCopia, lcServer, lcSenha, lnPorta):
    *   lcReceptor      -> par_cPara        lcFrom   -> par_cRemetente
    *   lcReceptorCopia -> par_cCopia       lcServer -> par_cServidor
    *   lcAssunto       -> par_cAssunto     lcSenha  -> par_cSenha
    *   lcTxtMensagem   -> par_cCorpo       lnPorta  -> par_nPorta
    *   lcArqAnexo      -> par_cAnexo
    *
    * Retorna .T. se o e-mail foi enviado com sucesso.
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cPara, par_cCopia, par_cAssunto, par_cCorpo, ;
                          par_cAnexo, par_cRemetente, par_cServidor, ;
                          par_cSenha, par_nPorta)
        LOCAL loc_lOk, loc_lEnvioOk, loc_oEmail

        loc_lOk      = .F.
        loc_lEnvioOk = .T.

        TRY
            IF TYPE('CREATEOBJECT("CDO.Message")') != "O"
                MsgAviso("Problemas para instanciar o objeto CDO.Message.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_oEmail = CREATEOBJECT("CDO.Message")

                WITH loc_oEmail.Configuration.Fields
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")            = 2
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")            = LOWER(par_cServidor)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")        = IIF(par_nPorta = 0, 25, par_nPorta)
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")      = 1
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")          = LOWER(par_cRemetente)
                    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")          = par_cSenha
                    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")            = IIF(par_nPorta = 465, 1, 0)
                    .Update()
                ENDWITH

                WITH loc_oEmail
                    .To       = LOWER(par_cPara)
                    .Cc       = LOWER(NVL(par_cCopia, ""))
                    .From     = LOWER(par_cRemetente)
                    .Subject  = ALLTRIM(par_cAssunto)
                    .TextBody = ALLTRIM(par_cCorpo)

                    IF !EMPTY(par_cAnexo)
                        IF FILE(par_cAnexo)
                            .AddAttachment(par_cAnexo)
                        ELSE
                            loc_lEnvioOk = .F.
                            MsgAviso("N" + CHR(227) + "o foi encontrado o arquivo:" + CHR(13) + ;
                                     par_cAnexo + CHR(13) + "para ser anexado.", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF

                    IF loc_lEnvioOk
                        TRY
                            .Send()
                            loc_lOk = .T.
                        CATCH TO loc_oErroEnvio
                            *-- O legado NAO fica calado aqui: o Catch do
                            *-- PROCEDURE memail avisa com
                            *-- Wait Window "Dados do e-mail invalidos." TimeOut 5.
                            *-- Transcrito como WAIT WINDOW ... TIMEOUT 5 para
                            *-- manter o aviso sem travar o envio em lote (o
                            *-- SCAN do chamador continua nos demais
                            *-- destinatarios), e CLAUDE.md #9 (CATCH nunca
                            *-- silencioso) fica atendido.
                            WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
                            loc_lOk = .F.
                        ENDTRY
                    ENDIF
                ENDWITH

                loc_oEmail = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.EnviarEmail")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLogEnvio - Registra o envio do movimento no log do sistema.
    *
    * fGravarLog (utils\fgravarlog.prg) eh um WRAPPER NO-OP INTENCIONAL: o
    * de-para real dos argumentos com SigOpLog nao foi confirmado contra o
    * fonte legado (ver cabecalho do proprio wrapper) - gravar direto em
    * SigOpLog com um de-para adivinhado seria a exata invencao que a regra
    * #17 do CLAUDE.md proibe. O legado tambem descarta o retorno da chamada
    * (`fGravarLog('T', Thisform.Name, [], lcEdn)` sem `=`), entao manter o
    * no-op aqui reproduz o comportamento observavel (o envio nao fica
    * marcado como processado em SigOpLog, igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLogEnvio(par_cEmpDopNums)
        RETURN fGravarLog("T", "Formsigprema", "", par_cEmpDopNums)
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmailSelecionados - Envia o e-mail para os destinatarios marcados
    * (Checks = 1) em this_cCursorDados, equivalente ao PROCEDURE Click do
    * btnEmail legado. A conta de envio vem de go_4c_Sistema.cCodEmpresa
    * (equivalente a _Empr legada - CLAUDE.md: NUNCA usar _EMPR).
    *
    * this_cArquivoEmail deve ser preenchido pelo chamador (Form) ANTES de
    * chamar este metodo, com o caminho do PDF a anexar, quando aplicavel -
    * a geracao do anexo (equivalente ao ImpDocto do legado, que aciona os
    * relatorios SigPrIdc/SigReIfx/SigOpIgm) depende de rotinas de impressao
    * do legado fora do escopo desta migracao e fica a cargo do Form.
    *
    * Reproduz o comportamento do legado de enviar UM e-mail POR
    * destinatario marcado (o destinatario principal fica fixo no primeiro
    * marcado e os demais entram como copia, cumulativamente) - nao eh um
    * envio unico em lote.
    *
    * Retorna .T. se o ULTIMO envio realizado teve sucesso (mesmo criterio
    * do llOk do legado, que eh reiniciado a cada iteracao do Scan).
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmailSelecionados()
        LOCAL loc_lOk, loc_cReceptor, loc_cReceptorCopia
        LOCAL loc_cAssunto, loc_cTxtMensagem, loc_cArqAnexo, loc_cEdn

        loc_lOk = .F.

        TRY
            IF !USED(THIS.this_cCursorDados)
                MsgAviso("Nenhum dado carregado para envio.", "Processamento de Email")
            ELSE
                IF !THIS.ObterDadosContaEmail(go_4c_Sistema.cCodEmpresa)
                    *-- erro ja exibido em ObterDadosContaEmail
                ELSE
                    IF USED("cursor_4c_Selecionados")
                        USE IN cursor_4c_Selecionados
                    ENDIF

                    SELECT * FROM (THIS.this_cCursorDados) WHERE Checks = 1 ;
                        INTO CURSOR cursor_4c_Selecionados READWRITE

                    SELECT cursor_4c_Selecionados

                    IF RECCOUNT() = 0
                        MsgAviso("Nenhum destinat" + CHR(225) + "rio selecionado." + CHR(13) + ;
                                 "Marque ao menos um e-mail para envio.", "Processamento de Email")
                    ELSE
                        loc_cReceptor      = ""
                        loc_cReceptorCopia = ""
                        loc_cAssunto       = ""
                        loc_cTxtMensagem   = ""

                        SELECT cursor_4c_Selecionados
                        SCAN
                            IF EMPTY(ALLTRIM(TratarNulo(cursor_4c_Selecionados.Emails, "")))
                                LOOP
                            ENDIF

                            loc_cEdn = cursor_4c_Selecionados.EmpDopNums

                            *-- Transcricao literal do legado: quem vira
                            *-- destinatario PRINCIPAL eh o registro de
                            *-- RECNO() = 1, nao "o primeiro com e-mail
                            *-- preenchido". A diferenca aparece quando a 1a
                            *-- linha marcada esta sem e-mail: o LOOP acima a
                            *-- descarta ANTES deste teste, entao nenhuma
                            *-- linha assume o To e o envio sai com
                            *-- destinatario vazio (as demais entram como
                            *-- copia). Comportamento do legado - NAO
                            *-- "corrigir" aqui (CLAUDE.md #17: transcrever,
                            *-- nunca reescrever a regra do legado).
                            IF RECNO() = 1
                                loc_cReceptor    = ALLTRIM(cursor_4c_Selecionados.Emails)
                                loc_cTxtMensagem = TratarNulo(cursor_4c_Selecionados.Mensagens, "")
                                loc_cAssunto     = ""
                            ELSE
                                IF !EMPTY(ALLTRIM(cursor_4c_Selecionados.Emails))
                                    loc_cReceptorCopia = loc_cReceptorCopia + ;
                                        IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
                                        ALLTRIM(cursor_4c_Selecionados.Emails)
                                ENDIF
                            ENDIF

                            loc_cArqAnexo = THIS.this_cArquivoEmail

                            WAIT WINDOW CHR(13) + "Aguarde... gerando EMAIL" NOWAIT NOCLEAR

                            loc_lOk = THIS.EnviarEmail(loc_cReceptor, loc_cReceptorCopia, ;
                                loc_cAssunto, loc_cTxtMensagem, loc_cArqAnexo, ;
                                THIS.this_cRemetente, THIS.this_cServidorSmtp, ;
                                THIS.this_cSenhaSmtp, THIS.this_nPortaSmtp)

                            WAIT CLEAR

                            IF loc_lOk
                                THIS.RegistrarLogEnvio(loc_cEdn)
                            ENDIF

                            SELECT cursor_4c_Selecionados
                        ENDSCAN
                    ENDIF

                    IF USED("cursor_4c_Selecionados")
                        USE IN cursor_4c_Selecionados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigpremaBO.EnviarEmailSelecionados")
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores de trabalho abertos por este BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_TmpMvCab")
            USE IN cursor_4c_TmpMvCab
        ENDIF
        IF USED("cursor_4c_LocalPAM")
            USE IN cursor_4c_LocalPAM
        ENDIF
        IF USED("cursor_4c_TmpClJob")
            USE IN cursor_4c_TmpClJob
        ENDIF
        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF
        IF USED("cursor_4c_Selecionados")
            USE IN cursor_4c_Selecionados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

