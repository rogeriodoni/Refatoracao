# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 262: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 286: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 309: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDif.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (990 linhas total):

*-- Linhas 97 a 105:
97:         loc_lSucesso   = .F.
98:         loc_lContinuar = .T.
99:         TRY
100:             THIS.Caption = "Diferen" + CHR(231) + "as Encontradas"
101: 
102:             IF TYPE("gc_4c_CaminhoIcones") = "U"
103:                 gc_4c_CaminhoIcones = ""
104:             ENDIF
105:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 122 a 131:
122:                 THIS.ConfigurarPageFrame()
123: 
124:                 *-- Sincroniza labels de titulo com caption do form
125:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
126:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
127: 
128:                 THIS.Visible = .T.
129:                 loc_lSucesso = .T.
130:             ENDIF
131:         CATCH TO loc_oErro

*-- Linhas 168 a 208:
168:         loc_nLarguraForm = THIS.Width
169:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
170:         WITH THIS.cnt_4c_Cabecalho
171:             .Top         = 0
172:             .Left        = 0
173:             .Width       = loc_nLarguraForm
174:             .Height      = 80
175:             .BackStyle   = 1
176:             .BackColor   = RGB(100, 100, 100)
177:             .BorderWidth = 0
178:             .Visible     = .T.
179: 
180:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
181:             .AddObject("lbl_4c_Sombra", "Label")
182:             WITH .lbl_4c_Sombra
183:                 .Top       = 22
184:                 .Left      = 22
185:                 .Width     = loc_nLarguraForm
186:                 .Height    = 30
187:                 .Caption   = "Diferen" + CHR(231) + "as Encontradas"
188:                 .FontName  = "Tahoma"
189:                 .FontSize  = 14
190:                 .FontBold  = .T.
191:                 .ForeColor = RGB(0, 0, 0)
192:                 .BackStyle = 0
193:                 .Visible   = .T.
194:             ENDWITH
195: 
196:             *-- Titulo em branco (sobre a sombra)
197:             .AddObject("lbl_4c_Titulo", "Label")
198:             WITH .lbl_4c_Titulo
199:                 .Top       = 20
200:                 .Left      = 20
201:                 .Width     = loc_nLarguraForm
202:                 .Height    = 30
203:                 .Caption   = "Diferen" + CHR(231) + "as Encontradas"
204:                 .FontName  = "Tahoma"
205:                 .FontSize  = 14
206:                 .FontBold  = .T.
207:                 .ForeColor = RGB(255, 255, 255)
208:                 .BackStyle = 0

*-- Linhas 222 a 248:
222:     PROTECTED PROCEDURE ConfigurarBotoes()
223:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
224:         WITH THIS.cmg_4c_Botoes
225:             .Top           = 0
226:             .Left          = 529
227:             .Width         = 273
228:             .Height        = 80
229:             .ButtonCount   = 4
230:             .BackStyle     = 0
231:             .BorderStyle   = 0
232:             .BorderColor   = RGB(136, 189, 188)
233:             .SpecialEffect = 1
234:             .Themes        = .F.
235:             .Visible       = .T.
236: 
237:             *-- Visualizar: exibe relatorio em preview na tela
238:             WITH .Buttons(1)
239:                 .Top             = 5
240:                 .Left            = 5
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .Caption         = "Visualizar"
244:                 .FontBold        = .T.
245:                 .FontItalic      = .T.
246:                 .BackColor       = RGB(255, 255, 255)
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 256 a 268:
256: 
257:             *-- Imprimir: envia relatorio com dialogo de selecao de impressora
258:             WITH .Buttons(2)
259:                 .Top             = 5
260:                 .Left            = 71
261:                 .Width           = 65
262:                 .Height          = 70
263:                 .Caption         = "Imprimir"
264:                 .FontName        = "Comic Sans MS"
265:                 .FontBold        = .T.
266:                 .FontItalic      = .T.
267:                 .FontSize        = 8
268:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 280 a 292:
280:             *   Original: BTNREPORT.DOCEXCEL -> Procedure "documento"
281:             *   -> REPORT FORM SigReDif To Printer NoConsole
282:             WITH .Buttons(3)
283:                 .Top             = 5
284:                 .Left            = 137
285:                 .Width           = 65
286:                 .Height          = 70
287:                 .Caption         = "Documento"
288:                 .FontName        = "Comic Sans MS"
289:                 .FontBold        = .T.
290:                 .FontItalic      = .T.
291:                 .FontSize        = 8
292:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 302 a 315:
302: 
303:             *-- Encerrar: fecha o form (Cancel=.T. ativa com ESC)
304:             WITH .Buttons(4)
305:                 .Top             = 5
306:                 .Left            = 203
307:                 .Width           = 65
308:                 .Height          = 70
309:                 .Caption         = "Encerrar"
310:                 .Cancel          = .T.
311:                 .FontName        = "Comic Sans MS"
312:                 .FontBold        = .T.
313:                 .FontItalic      = .T.
314:                 .FontSize        = 8
315:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 340 a 349:
340:     PROTECTED PROCEDURE ConfigurarPaginaLista()
341:         THIS.AddObject("grd_4c_Dados", "Grid")
342:         WITH THIS.grd_4c_Dados
343:             .Top               = 168
344:             .Left              = 72
345:             .Width             = 668
346:             .Height            = 345
347:             .ColumnCount       = 14
348:             .FontName          = "Verdana"
349:             .FontSize          = 8

*-- Linhas 365 a 391:
365:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridAposLinhaColChange")
366: 
367:         *-- Label "Historico:" (espelha Label1 do legado)
368:         THIS.AddObject("lbl_4c_Historico", "Label")
369:         WITH THIS.lbl_4c_Historico
370:             .Top       = 525
371:             .Left      = 72
372:             .Width     = 58
373:             .Height    = 15
374:             .Caption   = "Hist" + CHR(243) + "rico: "
375:             .FontName  = "Tahoma"
376:             .FontSize  = 8
377:             .ForeColor = RGB(90, 90, 90)
378:             .BackStyle = 0
379:             .Visible   = .T.
380:         ENDWITH
381: 
382:         *-- TextBox de historico (somente leitura - espelha Text1 WHEN=.F. do legado)
383:         THIS.AddObject("txt_4c_Historico", "TextBox")
384:         WITH THIS.txt_4c_Historico
385:             .Top      = 521
386:             .Left     = 140
387:             .Width    = 500
388:             .Height   = 23
389:             .Value    = ""
390:             .ReadOnly = .T.
391:             .Enabled  = .F.

*-- Linhas 428 a 449:
428:                     .Column14.ControlSource = "crGrid.Transacaos"
429: 
430:                     *-- Redefine headers: RecordSource reseta captions (FORMCOR licao #2)
431:                     .Column1.Header1.Caption  = "Ano"
432:                     .Column2.Header1.Caption  = "Data"
433:                     .Column3.Header1.Caption  = "Conta"
434:                     .Column4.Header1.Caption  = "D" + CHR(233) + "bito"
435:                     .Column5.Header1.Caption  = "Cr" + CHR(233) + "dito"
436:                     .Column6.Header1.Caption  = "Documento"
437:                     .Column7.Header1.Caption  = "Cont."
438:                     .Column8.Header1.Caption  = "Seq."
439:                     .Column9.Header1.Caption  = "Numes"
440:                     .Column10.Header1.Caption = "Data"
441:                     .Column11.Header1.Caption = "Valor"
442:                     .Column12.Header1.Caption = "C. Custo"
443:                     .Column13.Header1.Caption = "Emp."
444:                     .Column14.Header1.Caption = "Transa" + CHR(231) + CHR(227) + "o"
445: 
446:                     *-- ForeColor dos headers: cols 1-10 cinza, cols 11-14 azul (igual original)
447:                     .Column1.Header1.ForeColor  = RGB(90, 90, 90)
448:                     .Column2.Header1.ForeColor  = RGB(90, 90, 90)
449:                     .Column3.Header1.ForeColor  = RGB(90, 90, 90)


### BO (C:\4c\projeto\app\classes\SigReDifBO.prg):
*==============================================================================
* SIGREDIFBO.PRG
* Business Object para Relatorio de Diferencas (SigReDif)
*
* Herda de RelatorioBase
* Exibe diferencas entre movimentacoes contabeis
* Recebe DataSessionId do form chamador para acessar cursores movaux/dif2
*==============================================================================

DEFINE CLASS SigReDifBO AS RelatorioBase

    *-- Sessao de dados do form chamador (DataSessionId)
    this_nDataSessionId = 0

    *-- Flag para exportacao PDF (lacpdf do legado)
    this_lAcPdf         = .F.

    *-- Cursor com os dados preparados para o grid
    this_cCursorDados   = "crGrid"

    *-- Mensagem de erro
    this_cMensagemErro  = ""

    *-- Propriedades mapeadas da linha atual do crGrid
    this_nAnoFis        = 0
    this_cDatas         = ""
    this_cContas        = ""
    this_cDebs          = ""
    this_cCreds         = ""
    this_cDocto         = ""
    this_cEmpCont       = ""
    this_nNumSeq        = 0
    this_nNums          = 0
    this_dData          = {}
    this_cValor         = ""
    this_cCecus         = ""
    this_cEmps          = ""
    this_cTransacaos    = ""
    this_cHists         = ""
    this_nDeb1s         = 0
    this_nCred1s        = 0

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                THIS.this_cCursorDados = "crGrid"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Cria cursor crGrid a partir de movaux/dif2
    * Muda para sessao this_nDataSessionId onde movaux e dif2 existem,
    * executa SELECT, formata valores e posiciona no primeiro registro.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nSessaoOriginal, loc_nContagem
        loc_lSucesso = .F.
        loc_nSessaoOriginal = SET("Datasession")
        TRY
            *-- Muda para sessao do form chamador onde existem movaux e dif2
            IF THIS.this_nDataSessionId > 0
                SET DATASESSION TO (THIS.this_nDataSessionId)
            ENDIF

            *-- Valida existencia das tabelas de origem
            IF !USED("movaux") OR !USED("dif2")
                THIS.this_cMensagemErro = "Cursores 'movaux' e 'dif2' n" + CHR(227) + ;
                                          "o est" + CHR(227) + "o dispon" + CHR(237) + ;
                                          "veis na sess" + CHR(227) + "o de dados."
                MsgErro(THIS.this_cMensagemErro, "Erro")
                EXIT
            ENDIF

            *-- Fecha cursor anterior se existir
            IF USED("crGrid")
                SELECT crGrid
                USE
            ENDIF

            *-- Cursor com os mesmos dados do Cursor Diferenca
            SELECT *, ;
                   99999999.99 AS Deb1s, ;
                   99999999.99 AS Cred1s ;
            FROM movaux ;
            WHERE Transacaos IN (SELECT Transacaos FROM dif2) ;
            INTO CURSOR crGrid READWRITE

            *-- Verifica se ha registros para processar
            SELECT crGrid
            loc_nContagem = RECCOUNT("crGrid")

            IF loc_nContagem > 0
                *-- Formata debito e credito (centavos para formato moeda)
                REPLACE ALL Debs  WITH TRANSFORM(VAL(Debs)/100,  "@z 9,999,999.99") IN crGrid
                REPLACE ALL Creds WITH TRANSFORM(VAL(Creds)/100, "@z 9,999,999.99") IN crGrid

                *-- Formata valor total e numero do documento
                REPLACE ALL Valor WITH TRANSFORM(VAL(Valor), "@z 9,999,999.99") IN crGrid
                REPLACE ALL Docto WITH TRANSFORM(VAL(Docto), "@z 9999999999")   IN crGrid

                *-- Valores numericos para uso no relatorio FRX (remove separadores de milhar)
                REPLACE ALL Deb1s  WITH VAL(STRTRAN(Debs,  ",", "")) IN crGrid
                REPLACE ALL Cred1s WITH VAL(STRTRAN(Creds, ",", "")) IN crGrid

                SELECT crGrid
                LOCATE
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Restaura sessao de dados original (fora do TRY/CATCH)
        IF loc_nSessaoOriginal > 0 AND loc_nSessaoOriginal != SET("Datasession")
            SET DATASESSION TO (loc_nSessaoOriginal)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados da linha atual do crGrid para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nAnoFis     = TratarNulo(AnoFis,     "N")
                THIS.this_cDatas      = TratarNulo(Datas,      "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cDebs       = TratarNulo(Debs,       "C")
                THIS.this_cCreds      = TratarNulo(Creds,      "C")
                THIS.this_cDocto      = TratarNulo(Docto,      "C")
                THIS.this_cEmpCont    = TratarNulo(EmpCont,    "C")
                THIS.this_nNumSeq     = TratarNulo(NumSeq,     "N")
                THIS.this_nNums       = TratarNulo(Nums,       "N")
                THIS.this_dData       = TratarNulo(Data,       "D")
                THIS.this_cValor      = TratarNulo(Valor,      "C")
                THIS.this_cCecus      = TratarNulo(Cecus,      "C")
                THIS.this_cEmps       = TratarNulo(Emps,       "C")
                THIS.this_cTransacaos = TratarNulo(Transacaos, "C")
                THIS.this_cHists      = TratarNulo(Hists,      "C")
                THIS.this_nDeb1s      = TratarNulo(Deb1s,      "N")
                THIS.this_nCred1s     = TratarNulo(Cred1s,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel para relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cCaminhoFrx
        loc_lSucesso = .F.
        TRY
            loc_cCaminhoFrx = gc_4c_CaminhoReports + "RelSigReDif.frx"
            IF FILE(loc_cCaminhoFrx)
                REPORT FORM (loc_cCaminhoFrx) PREVIEW NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado:" + CHR(13) + loc_cCaminhoFrx, "Aviso")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cCaminhoFrx
        loc_lSucesso = .F.
        TRY
            loc_cCaminhoFrx = gc_4c_CaminhoReports + "RelSigReDif.frx"
            IF FILE(loc_cCaminhoFrx)
                REPORT FORM (loc_cCaminhoFrx) TO PRINTER PROMPT NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado:" + CHR(13) + loc_cCaminhoFrx, "Aviso")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarDocumento - Imprime relatorio direto na impressora padrao
    *--------------------------------------------------------------------------
    PROCEDURE GerarDocumento()
        LOCAL loc_lSucesso, loc_cCaminhoFrx
        loc_lSucesso = .F.
        TRY
            loc_cCaminhoFrx = gc_4c_CaminhoReports + "RelSigReDif.frx"
            IF FILE(loc_cCaminhoFrx)
                REPORT FORM (loc_cCaminhoFrx) TO PRINTER NOCONSOLE
            ELSE
                MsgAviso("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                         "o encontrado:" + CHR(13) + loc_cCaminhoFrx, "Aviso")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

