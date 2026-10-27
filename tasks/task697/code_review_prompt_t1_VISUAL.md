# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-HEADER] Header Caption 'Grupo Dest' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, Lote, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Dest' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, Lote, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo Orig' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, Lote, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Orig' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, Lote, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operacao' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, Lote, Operação. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpChc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (727 linhas total):

*-- Linhas 74 a 82:
74:     PROCEDURE Init()
75:         LPARAMETERS par_oParentForm, par_cNums
76: 
77:         THIS.Caption = "Hist" + CHR(243) + "rico da Carteira"
78: 
79:         IF VARTYPE(par_oParentForm) = "O"
80:             THIS.this_oParentForm = par_oParentForm
81:         ENDIF
82: 

*-- Linhas 124 a 133:
124: 
125:                 THIS.ConfigurarPageFrame()
126: 
127:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
128:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
129: 
130:                 THIS.CarregarLista()
131: 
132:                 THIS.TornarControlesVisiveis(THIS)
133: 

*-- Linhas 168 a 222:
168:         THIS.AddObject("cnt_4c_Sombra", "Container")
169:         loc_oCab = THIS.cnt_4c_Sombra
170:         WITH loc_oCab
171:             .Top         = 0
172:             .Left        = 0
173:             .Width       = THIS.Width
174:             .Height      = 80
175:             .BackColor   = RGB(100, 100, 100)
176:             .BackStyle   = 1
177:             .BorderWidth = 0
178:         ENDWITH
179: 
180:         *-- FontSize 18 TRANSCRITO do dump (SIGOPCHC.cntSombra.lblSombra/
181:         *-- lblTitulo declaram FontSize = 18). O 16 da tabela canonica da regra
182:         *-- #11 vale para a faixa INJETADA nas Pages de form CRUD, nao para o
183:         *-- cntSombra que este OPERACIONAL transcreve do proprio SCX - 18 eh o
184:         *-- valor dominante nos demais forms operacionais migrados.
185:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
186:         WITH loc_oCab.lbl_4c_LblSombra
187:             .AutoSize      = .F.
188:             .Width         = loc_oCab.Width - 20
189:             .Height        = 40
190:             .Top           = 18
191:             .Left          = 10
192:             .FontName      = "Tahoma"
193:             .FontSize      = 18
194:             .FontBold      = .T.
195:             .FontUnderline = .F.
196:             .Alignment     = 0
197:             .BackStyle     = 0
198:             .WordWrap      = .T.
199:             .ForeColor     = RGB(0, 0, 0)
200:             .Caption       = THIS.Caption
201:         ENDWITH
202: 
203:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
204:         WITH loc_oCab.lbl_4c_LblTitulo
205:             .AutoSize      = .F.
206:             .Width         = loc_oCab.Width - 20
207:             .Height        = 46
208:             .Top           = 17
209:             .Left          = 10
210:             .FontName      = "Tahoma"
211:             .FontSize      = 18
212:             .FontBold      = .T.
213:             .Alignment     = 0
214:             .BackStyle     = 0
215:             .WordWrap      = .T.
216:             .ForeColor     = RGB(255, 255, 255)
217:             .Caption       = THIS.Caption
218:         ENDWITH
219:     ENDPROC
220: 
221:     *--------------------------------------------------------------------------
222:     * ConfigurarGrid - cria grd_4c_Dados (equivalente a GrdHistCart do

*-- Linhas 252 a 261:
252:         THIS.AddObject("grd_4c_Dados", "Grid")
253:         loc_oGrid = THIS.grd_4c_Dados
254:         WITH loc_oGrid
255:             .Top                = 96
256:             .Left               = 66
257:             .Width              = 643
258:             .Height             = 112
259:             .ColumnCount        = 7
260:             .RecordSource       = "cursor_4c_Historico"
261:             .ReadOnly           = .T.

*-- Linhas 289 a 303:
289:         loc_oGrid.Column6.Width = 66
290:         loc_oGrid.Column7.Width = 110
291: 
292:         loc_oGrid.Column1.Header1.Caption = "Data"
293:         loc_oGrid.Column2.Header1.Caption = "Grupo Dest"
294:         loc_oGrid.Column3.Header1.Caption = "Conta Dest"
295:         loc_oGrid.Column4.Header1.Caption = "Grupo Orig"
296:         loc_oGrid.Column5.Header1.Caption = "Conta Orig"
297:         loc_oGrid.Column6.Header1.Caption = "Lote"
298:         loc_oGrid.Column7.Header1.Caption = "Operacao"
299: 
300:         *-- Equivalente ao For I=1 To .ColumnCount do legado: trava
301:         *-- Movable/Resizable e alinha o Header a direita em TODAS as colunas
302:         FOR loc_nCol = 1 TO loc_oGrid.ColumnCount
303:             loc_oGrid.Columns(loc_nCol).Movable          = .F.

*-- Linhas 319 a 338:
319:     PROTECTED PROCEDURE ConfigurarShapeDecorativo()
320:         THIS.AddObject("shp_4c_Shape1", "Shape")
321:         WITH THIS.shp_4c_Shape1
322:             .Top         = 36
323:             .Left        = 670
324:             .Width       = 90
325:             .Height      = 110
326:             .BackStyle   = 0
327:             .BorderStyle = 0
328:             .BorderColor = RGB(136, 189, 188)
329:         ENDWITH
330:     ENDPROC
331: 
332:     *--------------------------------------------------------------------------
333:     * ConfigurarCampoTaxa - cria lbl_4c_Label1 (Say1) e txt_4c_Taxa
334:     * (Get_taxa), o UNICO campo de entrada do dialogo (os 7 Column*.Text1 da
335:     * grade tem When -> .f. no legado, ou seja nao sao digitaveis).
336:     *
337:     * Format/InputMask TRANSCRITOS do dump (regra #49): Get_taxa declara
338:     * Format = "R" + InputMask = "999.99", que eh o que limita a digitacao a

*-- Linhas 353 a 381:
353:     * tecla), que mantem THIS.this_nTaxa e o BO sincronizados com o .Value.
354:     *--------------------------------------------------------------------------
355:     PROTECTED PROCEDURE ConfigurarCampoTaxa()
356:         THIS.AddObject("lbl_4c_Label1", "Label")
357:         WITH THIS.lbl_4c_Label1
358:             .Top       = 233
359:             .Left      = 464
360:             .Width     = 80
361:             .Height    = 15
362:             .AutoSize  = .F.
363:             .Alignment = 0
364:             .BackStyle = 0
365:             .FontName  = "Tahoma"
366:             .FontSize  = 8
367:             .FontBold  = .F.
368:             .ForeColor = RGB(90, 90, 90)
369:             .Caption   = "Taxa a.m. (%) :"
370:             .TabIndex  = 5
371:         ENDWITH
372: 
373:         THIS.AddObject("txt_4c_Taxa", "TextBox")
374:         WITH THIS.txt_4c_Taxa
375:             .Top           = 229
376:             .Left          = 546
377:             .Width         = 66
378:             .Height        = 23
379:             .Value         = 0
380:             .Format        = "R"
381:             .InputMask     = "999.99"

*-- Linhas 489 a 508:
489:     *--------------------------------------------------------------------------
490:     * ConfigurarBotoesAcao - cria os dois CommandButton reais do dialogo
491:     * (equivalente a btnOK/Fwbtng1 do legado), standalone (sem CommandGroup),
492:     * exatamente como no SCX (layout.json). btnOK.Left=701 + Width=75 fecha
493:     * em 776, exatamente Form.Width - confirma a Width canonica 75 (o SCX
494:     * nao declara Width/Height, herdados da classe fwbtng).
495:     *--------------------------------------------------------------------------
496:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
497:         THIS.AddObject("cmd_4c_BtnOK", "CommandButton")
498:         WITH THIS.cmd_4c_BtnOK
499:             .Top             = 3
500:             .Left            = 701
501:             .Width           = 75
502:             .Height          = 75
503:             .Caption         = "Encerrar"
504:             *-- Cancel = .T. transcrito do dump: com TitleBar = 0 e
505:             *-- ControlBox = .F. o ESC eh a unica saida de teclado do dialogo.
506:             *-- DIVERGENCIA DELIBERADA, declarada: o dump traz Cancel = .T.
507:             *-- TAMBEM em Fwbtng1 ("Baixa Cheque") - sao dois, e em VFP9 so UM
508:             *-- controle pode ser o Cancel, entao no legado quem acaba com ele

*-- Linhas 530 a 557:
530: 
531:         *-- "Baixa Cheque" (Fwbtng1 do legado) - dimensoes explicitas no dump
532:         *-- (80x46, sem Picture declarado no SCX).
533:         THIS.AddObject("cmd_4c_Fwbtng1", "CommandButton")
534:         WITH THIS.cmd_4c_Fwbtng1
535:             .Top           = 216
536:             .Left          = 630
537:             .Width         = 80
538:             .Height        = 46
539:             .Caption       = "Baixa Cheque"
540:             .FontName      = "Tahoma"
541:             .FontBold      = .T.
542:             .FontItalic    = .T.
543:             .FontSize      = 8
544:             .ForeColor     = RGB(90, 90, 90)
545:             .BackColor     = RGB(255, 255, 255)
546:             .SpecialEffect = 0
547:             .WordWrap      = .T.
548:             .TabIndex      = 3
549:         ENDWITH
550: 
551:         BINDEVENT(THIS.cmd_4c_BtnOK, "Click", THIS, "BtnOKClick")
552:         BINDEVENT(THIS.cmd_4c_Fwbtng1, "Click", THIS, "BtnBaixaChequeClick")
553:     ENDPROC
554: 
555:     *--------------------------------------------------------------------------
556:     * CarregarLista - popula cursor_4c_Historico (via BO.Buscar) com o
557:     * historico de carteira do cheque corrente (THIS.this_cNums) e repinta o


### BO (C:\4c\projeto\app\classes\SigOpChcBO.prg):
*==============================================================================
* SigOpChcBO.prg
*
* Business Object para SigOpChc (Historico da Carteira)
* Dialogo OPERACIONAL chamado pelo Cadastro de Cheques (FormCheque/SigCdChe)
* para exibir o historico de movimentos de carteira (SigCcChm + SigCqLcm) de
* um cheque especifico, e permitir gerar a baixa automatica de um cheque
* devolvido (via SigCdOpt).
*
* Tabelas: SigCcChm (historico), SigCqLcm (lote - origem do codigo da
*          operacao), SigCdOpt (parametros da operacao, usado na baixa)
*==============================================================================

DEFINE CLASS SigOpChcBO AS BusinessBase

    *-- Chave do cheque cujo historico de carteira esta sendo exibido
    *-- (equivalente a CrSigChe.Nums no legado, recebido do form pai)
    this_cNums = ""

    *-- Taxa de juros a.m. (%) usada na baixa automatica do cheque devolvido
    *-- (equivalente a lnTaxa/Get_taxa no legado)
    this_nTaxa = 0

    *-- Nome do cursor populado com o historico (SigCcChm JOIN SigCqLcm)
    *-- que alimenta o grid de historico da tela
    this_cCursorHistorico = "cursor_4c_Historico"

    *-- Codigo da operacao do registro de historico corrente
    *-- (equivalente a crSigccchm.codigos no legado)
    this_cOperacaoCodigo = ""

    *-- Flag "Devolvido" (S/N) da operacao corrente (SigCdOpt.devolvidos)
    this_cDevolvidoFlag = ""

    *-- Codigo da operacao que EXECUTA a baixa automatica do cheque devolvido.
    *-- CUIDADO com o nome da coluna: o valor eh SigCdOpt.Operacaos da linha
    *-- cujo SigCdOpt.Opants aponta para a operacao CORRENTE - ou seja, a
    *-- operacao SUCESSORA (a que desfaz), nao a anterior. Eh o que o legado
    *-- passa ao SigCdChe (crSigcdOpt.operacaos, apos "Locate for opants =
    *-- crSigccchm.codigos"). Chamar isto de "operacao anterior" - como a
    *-- migracao fazia - inverte o sentido e sai errado na tela.
    this_cOperacaoBaixa = ""

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCcChm"
        THIS.this_cCampoChave = "nums"

        THIS.this_cNums = ""
        THIS.this_nTaxa = 0
        THIS.this_cCursorHistorico = "cursor_4c_Historico"
        THIS.this_cOperacaoCodigo = ""
        THIS.this_cDevolvidoFlag = ""
        THIS.this_cOperacaoBaixa = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Buscar - Carrega o historico de carteira (SigCcChm JOIN SigCqLcm) do
    * cheque identificado por par_cNums, populando THIS.this_cCursorHistorico
    *
    * Equivalente literal ao legado (SIGOPCHC.Init):
    *   Select b.codigos, a.* From SigCcChm a, sigcqlcm b
    *   Where Nums = ']+CrSigChe.Nums+[' and a.numlotes = b.numlotes Order By DtSis
    *==========================================================================
    PROCEDURE Buscar(par_cNums)
        LOCAL loc_cSQL, loc_nResultado, loc_cCursorTmp

        IF EMPTY(par_cNums)
            par_cNums = THIS.this_cNums
        ENDIF

        IF EMPTY(par_cNums)
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero do cheque n" + CHR(227) + "o informado"
            RETURN .F.
        ENDIF

        THIS.this_cNums = par_cNums

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        loc_cCursorTmp = THIS.this_cCursorHistorico + "Tmp"

        IF USED(loc_cCursorTmp)
            USE IN (loc_cCursorTmp)
        ENDIF

        loc_cSQL = "SELECT b.Codigos, a.* " + ;
                   "FROM SigCcChm a, SigCqLcm b " + ;
                   "WHERE a.Nums = " + EscaparSQL(par_cNums) + " " + ;
                   "AND a.NumLotes = b.NumLotes " + ;
                   "ORDER BY a.DtSis"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao buscar hist" + CHR(243) + "rico da carteira" + CHR(13) + CapturarErroSQL()
            RETURN .F.
        ENDIF

        *-- Cursor temporario (somente-leitura) -> cursor final READWRITE,
        *-- preservando o binding do Grid quando ja existir (regra Erro179/#21a)
        IF USED(THIS.this_cCursorHistorico)
            SELECT (THIS.this_cCursorHistorico)
            ZAP
            APPEND FROM DBF(loc_cCursorTmp)
        ELSE
            SELECT * FROM (loc_cCursorTmp) INTO CURSOR (THIS.this_cCursorHistorico) READWRITE
        ENDIF

        IF USED(loc_cCursorTmp)
            USE IN (loc_cCursorTmp)
        ENDIF

        IF USED(THIS.this_cCursorHistorico)
            SELECT (THIS.this_cCursorHistorico)
            GO TOP
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega THIS.this_cOperacaoCodigo/this_cNums a partir
    * da linha corrente do cursor de historico (par_cAliasCursor), usado antes
    * de VerificarBaixaAutomatica() para saber qual linha o usuario selecionou
    * no grid (equivalente ao legado referenciar crSigccchm.codigos direto)
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        *-- SO a operacao (equivalente a crSigccchm.codigos do legado). O
        *-- numero do cheque NAO se le daqui: o cursor da grade eh o
        *-- cursor-molde de 7 campos criado em ConfigurarGrid (Dtsis/Grucarts/
        *-- Concarts/Grupos/Contas/Numlotes/Codigos), e Buscar() o repopula
        *-- com ZAP + APPEND FROM DBF(), que casa por NOME - logo a coluna
        *-- Nums do SELECT (a.* de SigCcChm) nunca entra nele e ler Nums aqui
        *-- estourava "Variable NUMS is not found" em CADA clique de "Baixa
        *-- Cheque". O legado tambem nao le o numero do historico: ele usa
        *-- CrSigChe.Nums, o cursor do form PAI - aqui o equivalente eh
        *-- THIS.this_cNums, que o Form passa no Init e Buscar() preserva.
        THIS.this_cOperacaoCodigo = TratarNulo(Codigos, "C")

        RETURN .T.
    ENDPROC

    *==========================================================================
    * VerificarBaixaAutomatica - Verifica se a operacao informada (tipicamente
    * THIS.this_cOperacaoCodigo, carregada por CarregarDoCursor) representa um
    * cheque devolvido e, em caso positivo, localiza a operacao que EXECUTA a
    * baixa automatica - a linha de SigCdOpt cujo Opants aponta para a operacao
    * corrente -, guardando o Operacaos DELA em THIS.this_cOperacaoBaixa.
    *
    * Equivalente literal ao legado (SIGOPCHC.Fwbtng1.Click):
    *   Select crSigcdOpt
    *   Locate for operacaos = crSigccchm.codigos
    *   If Found()
    *       If crSigcdOpt.devolvidos = 'S'
    *           Select crSigcdOpt
    *           Locate for opants = crSigccchm.codigos
    *           If Found() ... (abre SigCdChe com crSigcdOpt.operacaos)
    *
    * NAO leva PROTECTED: o Form chama este metodo de fora ao clicar no botao
    * "Baixa Cheque" (regra #51 - metodo chamado de fora do BO nunca eh
    * PROTECTED em nenhum nivel da heranca).
    *==========================================================================
    FUNCTION VerificarBaixaAutomatica(par_cCodigoOperacao)
        LOCAL loc_cSQL, loc_nResultado, loc_lPodeBaixar

        loc_lPodeBaixar = .F.
        THIS.this_cDevolvidoFlag = ""
        THIS.this_cOperacaoBaixa = ""

        IF EMPTY(par_cCodigoOperacao)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        *-- Equivalente a: Locate for operacaos = crSigccchm.codigos
        loc_cSQL = "SELECT Devolvidos FROM SigCdOpt WHERE Operacaos = " + EscaparSQL(par_cCodigoOperacao)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistOpt")

        IF loc_nResultado > 0 AND USED("cursor_4c_HistOpt")
            SELECT cursor_4c_HistOpt
            IF !EOF()
                THIS.this_cDevolvidoFlag = TratarNulo(Devolvidos, "C")
            ENDIF
        ENDIF

        IF USED("cursor_4c_HistOpt")
            USE IN cursor_4c_HistOpt
        ENDIF

        *-- Equivalente a: If crSigcdOpt.devolvidos = 'S'
        IF UPPER(ALLTRIM(THIS.this_cDevolvidoFlag)) == "S"
            *-- Equivalente a: Locate for opants = crSigccchm.codigos
            loc_cSQL = "SELECT Operacaos FROM SigCdOpt WHERE Opants = " + EscaparSQL(par_cCodigoOperacao)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistOptAnt")

            IF loc_nResultado > 0 AND USED("cursor_4c_HistOptAnt")
                SELECT cursor_4c_HistOptAnt
                IF !EOF()
                    THIS.this_cOperacaoBaixa = TratarNulo(Operacaos, "C")
                    loc_lPodeBaixar = !EMPTY(THIS.this_cOperacaoBaixa)
                ENDIF
            ENDIF

            IF USED("cursor_4c_HistOptAnt")
                USE IN cursor_4c_HistOptAnt
            ENDIF
        ENDIF

        RETURN loc_lPodeBaixar
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Chave do dialogo eh o numero do cheque (this_cNums),
    * usado por RegistrarAuditoria caso venha a ser chamado
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cNums
    ENDPROC

    *-- Este BO atende um dialogo OPERACIONAL de CONSULTA (Historico da
    *-- Carteira): o legado apenas EXIBE o historico de SigCcChm/SigCqLcm e,
    *-- quando a operacao corrente eh um cheque devolvido, aciona a baixa
    *-- automatica abrindo outro formulario (SigCdChe) - nao ha INSERT/UPDATE/
    *-- DELETE proprios deste dialogo sobre SigCcChm. O comportamento padrao
    *-- herdado de BusinessBase para Inserir/Atualizar/ExecutarExclusao
    *-- (recusar a operacao) ja eh o correto aqui, por isso nao sao
    *-- sobrescritos.

ENDDEFINE

