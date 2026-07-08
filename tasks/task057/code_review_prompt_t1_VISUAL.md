# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECND.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1358 linhas total):

*-- Linhas 51 a 59:
51:         loc_lContinuar = .T.
52: 
53:         TRY
54:             THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
55:                            CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
56: 
57:             IF TYPE("gc_4c_CaminhoIcones") = "U"
58:                 gc_4c_CaminhoIcones = ""
59:             ENDIF

*-- Linhas 83 a 92:
83:                 *-- Container "Aguarde!!!" oculto para progresso durante geracao (Fase 5)
84:                 THIS.ConfigurarPaginaDados()
85: 
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
88: 
89:                 *-- Inicializa campos de filtro com valores padrao (Fase 5)
90:                 THIS.LimparCampos()
91:                 THIS.Visible = .T.
92:                 loc_lSucesso = .T.

*-- Linhas 111 a 152:
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH THIS.cnt_4c_Cabecalho
114:             .Top         = 0
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackStyle   = 1
119:             .BackColor   = RGB(100, 100, 100)
120:             .BorderWidth = 0
121:             .Visible     = .T.
122: 
123:             *-- Sombra (deslocada 2px para baixo/direita - efeito 3D do texto branco)
124:             .AddObject("lbl_4c_Sombra", "Label")
125:             WITH .lbl_4c_Sombra
126:                 .Top       = 22
127:                 .Left      = 22
128:                 .Width     = THIS.Width
129:                 .Height    = 30
130:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
131:                              CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
132:                 .FontName  = "Tahoma"
133:                 .FontSize  = 14
134:                 .FontBold  = .T.
135:                 .ForeColor = RGB(0, 0, 0)
136:                 .BackStyle = 0
137:                 .Visible   = .T.
138:             ENDWITH
139: 
140:             *-- Titulo em branco (sobre a sombra)
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .Top       = 20
144:                 .Left      = 20
145:                 .Width     = THIS.Width
146:                 .Height    = 30
147:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Lan" + ;
148:                              CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
149:                 .FontName  = "Tahoma"
150:                 .FontSize  = 14
151:                 .FontBold  = .T.
152:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 158 a 192:
158: 
159:     *--------------------------------------------------------------------------
160:     * ConfigurarBotoes - CommandGroup de relatorio (equivalente a btnReport)
161:     *   Original: btnReport.Left=525, Top=3, Height=80 aprox.
162:     *   Padrao canonico frmrelatorio: Left=529, Width=273, Height=80.
163:     *   Botoes: Visualiza(Left=6), Imprime(Left=72), DocExcel(Left=138), Sair(Left=204).
164:     *   BINDEVENTs dos Buttons sao vinculados em InicializarForm nas Fases 7-8.
165:     *--------------------------------------------------------------------------
166:     PROTECTED PROCEDURE ConfigurarBotoes()
167:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
168:         WITH THIS.cmg_4c_Botoes
169:             .Top           = 0
170:             .Left          = 529
171:             .Width         = 273
172:             .Height        = 80
173:             .ButtonCount   = 4
174:             .BackStyle     = 0
175:             .BorderStyle   = 0
176:             .BorderColor   = RGB(136, 189, 188)
177:             .SpecialEffect = 1
178:             .Themes        = .F.
179:             .Visible       = .T.
180: 
181:             *-- Visualizar (preview em tela - equivalente a Visualiza no legado)
182:             WITH .Buttons(1)
183:                 .Top             = 5
184:                 .Left            = 5
185:                 .Width           = 65
186:                 .Height          = 70
187:                 .Caption         = "Visualizar"
188:                 .FontBold        = .T.
189:                 .FontItalic      = .T.
190:                 .BackColor       = RGB(255, 255, 255)
191:                 .ForeColor       = RGB(90, 90, 90)
192:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 200 a 214:
200: 
201:             *-- Imprimir (impressora - equivalente a Imprime no legado)
202:             WITH .Buttons(2)
203:                 .Top             = 5
204:                 .Left            = 71
205:                 .Width           = 65
206:                 .Height          = 70
207:                 .Caption         = "Imprimir"
208:                 .FontName        = "Comic Sans MS"
209:                 .FontBold        = .T.
210:                 .FontItalic      = .T.
211:                 .FontSize        = 8
212:                 .BackColor       = RGB(255, 255, 255)
213:                 .ForeColor       = RGB(90, 90, 90)
214:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 222 a 236:
222: 
223:             *-- Excel (exportar dados - equivalente a DocExcel no legado)
224:             WITH .Buttons(3)
225:                 .Top             = 5
226:                 .Left            = 137
227:                 .Width           = 65
228:                 .Height          = 70
229:                 .Caption         = "Excel"
230:                 .FontName        = "Comic Sans MS"
231:                 .FontBold        = .T.
232:                 .FontItalic      = .T.
233:                 .FontSize        = 8
234:                 .BackColor       = RGB(255, 255, 255)
235:                 .ForeColor       = RGB(90, 90, 90)
236:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 244 a 259:
244: 
245:             *-- Encerrar (fechar form via ESC - equivalente a Sair no legado)
246:             WITH .Buttons(4)
247:                 .Top             = 5
248:                 .Left            = 203
249:                 .Width           = 65
250:                 .Height          = 70
251:                 .Caption         = "Encerrar"
252:                 .Cancel          = .T.
253:                 .FontName        = "Comic Sans MS"
254:                 .FontBold        = .T.
255:                 .FontItalic      = .T.
256:                 .FontSize        = 8
257:                 .BackColor       = RGB(255, 255, 255)
258:                 .ForeColor       = RGB(90, 90, 90)
259:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 292 a 307:
292:         loc_oPgf.PageCount = 1
293: 
294:         *-- Posicionamento: logo abaixo do cabecalho (85px) ate o fim do form
295:         loc_oPgf.Top    = 85
296:         loc_oPgf.Left   = -1
297:         loc_oPgf.Width  = THIS.Width + 2
298:         loc_oPgf.Height = THIS.Height - 85
299:         loc_oPgf.Tabs   = .F.
300: 
301:         *-- Configurar Page1 (FORA de qualquer WITH para evitar conflitos de escopo)
302:         loc_oPgf.Page1.Caption   = "Filtros"
303:         loc_oPgf.Page1.FontName  = "Tahoma"
304:         loc_oPgf.Page1.FontSize  = 8
305:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
306:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
307:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 325 a 392:
325:         loc_oPag1.AddObject("cnt_4c_Local", "Container")
326:         loc_oCnt = loc_oPag1.cnt_4c_Local
327:         WITH loc_oCnt
328:             .Top         = 27
329:             .Left        = 168
330:             .Width       = 491
331:             .Height      = 112
332:             .BackStyle   = 0
333:             .BorderWidth = 0
334:             .Visible     = .T.
335:         ENDWITH
336: 
337:         *-- Say2: label "Data Referencia :" (original: Top=8, Left=18)
338:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
339:         WITH loc_oCnt.lbl_4c_Label2
340:             .Caption   = "Data Refer" + CHR(234) + "ncia :"
341:             .Top       = 8
342:             .Left      = 18
343:             .Width     = 87
344:             .AutoSize  = .T.
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .ForeColor = RGB(90, 90, 90)
348:             .BackStyle = 0
349:             .Visible   = .T.
350:         ENDWITH
351: 
352:         *-- Say1: label "Grupo :" (original: Top=34, Left=67)
353:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
354:         WITH loc_oCnt.lbl_4c_Label1
355:             .Caption   = "Grupo :"
356:             .Top       = 34
357:             .Left      = 67
358:             .Width     = 38
359:             .AutoSize  = .T.
360:             .FontName  = "Tahoma"
361:             .FontSize  = 8
362:             .ForeColor = RGB(90, 90, 90)
363:             .BackStyle = 0
364:             .Visible   = .T.
365:         ENDWITH
366: 
367:         *-- lbl_estoque: label "Conta :" (original: Top=62, Left=67)
368:         loc_oCnt.AddObject("lbl_4c_Lbl_estoque", "Label")
369:         WITH loc_oCnt.lbl_4c_Lbl_estoque
370:             .Caption   = "Conta :"
371:             .Top       = 62
372:             .Left      = 67
373:             .Width     = 38
374:             .AutoSize  = .T.
375:             .FontName  = "Tahoma"
376:             .FontSize  = 8
377:             .ForeColor = RGB(90, 90, 90)
378:             .BackStyle = 0
379:             .Visible   = .T.
380:         ENDWITH
381: 
382:         *-- Say3: label "Moeda :" (original: Top=87, Left=64)
383:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
384:         WITH loc_oCnt.lbl_4c_Label3
385:             .Caption   = "Moeda :"
386:             .Top       = 87
387:             .Left      = 64
388:             .Width     = 41
389:             .AutoSize  = .T.
390:             .FontName  = "Tahoma"
391:             .FontSize  = 8
392:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 399 a 408:
399:         *-- getDtInicial: Data de Referencia (Top=5, Left=109 - fweditdata)
400:         loc_oCnt.AddObject("txt_4c_DtInicial", "TextBox")
401:         WITH loc_oCnt.txt_4c_DtInicial
402:             .Top         = 5
403:             .Left        = 109
404:             .Width       = 80
405:             .Height      = 25
406:             .Value       = {}
407:             .Format      = "E"
408:             .InputMask   = "99/99/9999"

*-- Linhas 420 a 429:
420:         *-- getGrupo: codigo do grupo (Top=30, Left=109, Width=80)
421:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
422:         WITH loc_oCnt.txt_4c_Grupo
423:             .Top         = 30
424:             .Left        = 109
425:             .Width       = 80
426:             .Height      = 25
427:             .Value       = ""
428:             .MaxLength   = 10
429:             .FontName    = "Tahoma"

*-- Linhas 440 a 449:
440:         *-- getDGrupo: descricao do grupo (Top=30, Left=191, Width=150)
441:         loc_oCnt.AddObject("txt_4c_DGrupo", "TextBox")
442:         WITH loc_oCnt.txt_4c_DGrupo
443:             .Top         = 30
444:             .Left        = 191
445:             .Width       = 150
446:             .Height      = 25
447:             .Value       = ""
448:             .MaxLength   = 20
449:             .FontName    = "Tahoma"

*-- Linhas 460 a 469:
460:         *-- getConta: codigo da conta (Top=57, Left=109, Width=80)
461:         loc_oCnt.AddObject("txt_4c_Conta", "TextBox")
462:         WITH loc_oCnt.txt_4c_Conta
463:             .Top         = 57
464:             .Left        = 109
465:             .Width       = 80
466:             .Height      = 25
467:             .Value       = ""
468:             .MaxLength   = 10
469:             .FontName    = "Tahoma"

*-- Linhas 480 a 489:
480:         *-- getDConta: descricao da conta (Top=57, Left=191, Width=298)
481:         loc_oCnt.AddObject("txt_4c_DConta", "TextBox")
482:         WITH loc_oCnt.txt_4c_DConta
483:             .Top         = 57
484:             .Left        = 191
485:             .Width       = 298
486:             .Height      = 25
487:             .Value       = ""
488:             .MaxLength   = 40
489:             .FontName    = "Tahoma"

*-- Linhas 500 a 509:
500:         *-- getMoeda: codigo da moeda (Top=84, Left=109, Width=31)
501:         loc_oCnt.AddObject("txt_4c_Moeda", "TextBox")
502:         WITH loc_oCnt.txt_4c_Moeda
503:             .Top         = 84
504:             .Left        = 109
505:             .Width       = 31
506:             .Height      = 25
507:             .Value       = ""
508:             .MaxLength   = 3
509:             .FontName    = "Tahoma"

*-- Linhas 520 a 529:
520:         *-- getDMoeda: descricao da moeda (Top=84, Left=142, Width=115)
521:         loc_oCnt.AddObject("txt_4c_DMoeda", "TextBox")
522:         WITH loc_oCnt.txt_4c_DMoeda
523:             .Top         = 84
524:             .Left        = 142
525:             .Width       = 115
526:             .Height      = 25
527:             .Value       = ""
528:             .MaxLength   = 15
529:             .FontName    = "Tahoma"

*-- Linhas 556 a 577:
556:         THIS.AddObject("cnt_4c_Mensagem", "Container")
557:         WITH THIS.cnt_4c_Mensagem
558:             *-- Centralizado sobre a area de filtros, oculto ate ser necessario
559:             .Top         = 100
560:             .Left        = 134
561:             .Width       = 473
562:             .Height      = 56
563:             .BackStyle   = 1
564:             .BackColor   = RGB(255, 255, 224)
565:             .BorderWidth = 1
566:             .Visible     = .F.
567: 
568:             .AddObject("lbl_4c_LblMensagem", "Label")
569:             WITH .lbl_4c_LblMensagem
570:                 .Caption   = "Aguarde!!!"
571:                 .Top       = 18
572:                 .Left      = 20
573:                 .Width     = 445
574:                 .Height    = 22
575:                 .FontName  = "Tahoma"
576:                 .FontSize  = 10
577:                 .FontBold  = .T.


### BO (C:\4c\projeto\app\classes\SIGRECNDBO.prg):
*==============================================================================
* SIGRECNDBO.PRG
* Business Object para Relatorio: Posicao de Lancamentos Nao Conciliados
*
* Herda de RelatorioBase
* Tabela principal: SigMvCcr
* Relatorio FRX: SigReCnd.frx
*
* Filtros:
*   - Data de Referencia  (getDtInicial)
*   - Grupo               (getGrupo / getDGrupo  - C(10)/C(20))
*   - Conta               (getConta / getDConta  - C(10)/C(40))
*   - Moeda               (getMoeda / getDMoeda  - C(3)/C(15) - SigCdMoe.CMoes/DMoes)
*==============================================================================

DEFINE CLASS SIGRECNDBO AS RelatorioBase

    *-- Filtro: data de referencia
    this_dDtInicial     = {}

    *-- Filtro: grupo (Grupos em SigMvCcr, C(10))
    this_cGrupos        = ""
    this_cDGrupos       = ""

    *-- Filtro: conta (Contas em SigMvCcr, C(10))
    this_cContas        = ""
    this_cDContas       = ""

    *-- Filtro: moeda (Moedas em SigMvCcr, C(3))
    this_cMoedas        = ""
    this_cDMoedas       = ""

    *-- Nome do cursor de saida populado por PrepararDados()
    this_cCursorDados   = "TmpHist"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de lancamentos nao conciliados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursor TmpHist com lancamentos nao conciliados
    * Replica logica do PROCEDURE processamento do legado SIGRECND
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cGru, loc_cCon, loc_cMoe, loc_cWhereConta
        LOCAL loc_cCabEmpresa, loc_cTitulo, loc_cSubTitulo
        LOCAL loc_cCab, loc_nSal, loc_nVal, loc_nCt1, loc_nCt2, loc_lcDes
        LOCAL loc_oErro

        *-- Validacoes fora do TRY (podem usar RETURN diretamente)
        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data de Refer" + CHR(234) + "ncia inv" + CHR(225) + "lida"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cGrupos)
            THIS.this_cMensagemErro = "Grupo inv" + CHR(225) + "lido"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cMoedas)
            THIS.this_cMensagemErro = "Moeda inv" + CHR(225) + "lida"
            RETURN .F.
        ENDIF

        *-- Padronizar filtros (igual ao legado com PADR(,10))
        loc_cGru = PADR(ALLTRIM(THIS.this_cGrupos), 10)
        loc_cCon = PADR(ALLTRIM(THIS.this_cContas), 10)
        loc_cMoe = ALLTRIM(THIS.this_cMoedas)

        loc_lSucesso = .F.

        TRY
            *-- Cabecalho da empresa
            loc_cCabEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cSQL = "SELECT TOP 1 Razas FROM SigCdEmp " + ;
                       "WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cCabEmpresa = go_4c_Sistema.cCodEmpresa + ;
                                      " - " + ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta subtitulo do relatorio
            loc_cTitulo    = "Posi" + CHR(231) + CHR(227) + "o de Lan" + CHR(231) + ;
                             "amentos N" + CHR(227) + "o Conciliados"
            loc_cSubTitulo = "Data Refer" + CHR(234) + "ncia : " + DTOC(THIS.this_dDtInicial) + ;
                             " - Grupo : " + ALLTRIM(loc_cGru) + ;
                             " - Conta : " + IIF(EMPTY(loc_cCon), "Todas", ALLTRIM(loc_cCon))

            *-- Cursor de cabecalho para o relatorio
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), SubTitulo C(80), Moeda1 C(80))
            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Moeda1) ;
                VALUES (loc_cCabEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cMoe)

            *-- Cursor principal TmpHist (igual estrutura do legado)
            IF USED("TmpHist")
                USE IN TmpHist
            ENDIF
            CREATE CURSOR TmpHist ;
                (Audits L(1), Datas D(8), Grupos C(10), Contas C(10), RClis C(40), ;
                 Saldo1 N(12,2), Opers C(1), Hists C(40), Hist2s C(40), Emps C(3), ;
                 Debitos N(12,2), Creditos N(12,2), Docus C(10), cIdChaves C(20))
            INDEX ON Grupos + Contas + cIdChaves TAG ContData

            *-- Monta clausula WHERE para conta (opcional)
            IF !EMPTY(THIS.this_cContas)
                loc_cWhereConta = " AND Contas = " + EscaparSQL(loc_cCon)
            ELSE
                loc_cWhereConta = ""
            ENDIF

            *-- Query principal em SigMvCcr
            loc_cSQL = "SELECT Grupos, Contas, cIdChaves, CAST(Datas AS DATE) AS Datas," + ;
                       " Opers, Valors, Moedas, Docus, Emps, DtAudits, Hists, Hist2s " + ;
                       " FROM SigMvCcr" + ;
                       " WHERE Grupos = " + EscaparSQL(loc_cGru) + ;
                       loc_cWhereConta + ;
                       " AND Datas <= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                       " AND (DataConcs IS NULL OR DataConcs > " + ;
                       FormatarDataSQL(THIS.this_dDtInicial) + ")" + ;
                       " ORDER BY Grupos, Contas, cIdChaves, Datas, Opers, Valors," + ;
                       " Docus, Emps, DtAudits"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcrDados")
            IF loc_nResult > 0
                *-- Processa registros calculando saldo acumulado e conversao de moeda
                loc_cCab = ""
                loc_nSal = 0

                SELECT cursor_4c_CcrDados
                SCAN
                    *-- Detecta quebra de grupo/conta para resetar saldo
                    IF (loc_cCab != cursor_4c_CcrDados.Grupos + cursor_4c_CcrDados.Contas)
                        loc_cCab = cursor_4c_CcrDados.Grupos + cursor_4c_CcrDados.Contas
                        loc_nSal = 0
                    ENDIF

                    *-- Busca descricao do cliente/conta em SigCdCli
                    loc_lcDes = ""
                    loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli " + ;
                               "WHERE IClis = " + EscaparSQL(ALLTRIM(cursor_4c_CcrDados.Contas))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CcrCli")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CcrCli
                        IF !EOF()
                            loc_lcDes = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_CcrCli
                    ENDIF
                    SELECT cursor_4c_CcrDados

                    *-- Converte valor para moeda alvo se necessario
                    loc_nVal = cursor_4c_CcrDados.Valors
                    IF ALLTRIM(cursor_4c_CcrDados.Moedas) != ALLTRIM(loc_cMoe)
                        loc_nCt1 = THIS.BuscarCotacao(ALLTRIM(cursor_4c_CcrDados.Moedas), ;
                                                       CTOD(DTOC(cursor_4c_CcrDados.Datas)))
                        loc_nCt2 = THIS.BuscarCotacao(loc_cMoe, ;
                                                       CTOD(DTOC(cursor_4c_CcrDados.Datas)))
                        IF loc_nCt2 != 0
                            loc_nVal = (cursor_4c_CcrDados.Valors * loc_nCt1) / loc_nCt2
                        ENDIF
                    ENDIF

                    *-- Acumula saldo: C=credito(+), D=debito(-)
                    loc_nSal = loc_nSal + ;
                               (loc_nVal * IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "C", 1, -1))

                    *-- Insere linha processada no TmpHist
                    SELECT TmpHist
                    INSERT INTO TmpHist ;
                        (Audits, Datas, Grupos, Contas, RClis, Saldo1, Opers, ;
                         Hists, Hist2s, Emps, Debitos, Creditos, Docus, cIdChaves) ;
                        VALUES (!EMPTY(cursor_4c_CcrDados.DtAudits), ;
                                CTOD(DTOC(cursor_4c_CcrDados.Datas)), ;
                                cursor_4c_CcrDados.Grupos, ;
                                cursor_4c_CcrDados.Contas, ;
                                loc_lcDes, ;
                                loc_nSal, ;
                                cursor_4c_CcrDados.Opers, ;
                                ALLTRIM(NVL(cursor_4c_CcrDados.Hists, "")), ;
                                ALLTRIM(NVL(cursor_4c_CcrDados.Hist2s, "")), ;
                                cursor_4c_CcrDados.Emps, ;
                                IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "D", loc_nVal, 0), ;
                                IIF(ALLTRIM(cursor_4c_CcrDados.Opers) = "C", loc_nVal, 0), ;
                                cursor_4c_CcrDados.Docus, ;
                                cursor_4c_CcrDados.cIdChaves)
                    SELECT cursor_4c_CcrDados
                ENDSCAN

                USE IN cursor_4c_CcrDados

                *-- Posiciona TmpHist ordenado pelo indice
                SELECT TmpHist
                SET ORDER TO ContData
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar dados de SigMvCcr"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio direto na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) TO PRINT PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + "SigReCnd.frx"
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao da moeda para a data especificada
    * par_cMoeda: codigo da moeda (SigCdCot.cmoes)
    * par_dData:  data de referencia
    * Retorna: valor numerico da cotacao (1.0 se nao encontrada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cSQL, loc_nResult, loc_oErro
        loc_nCotacao = 1

        IF EMPTY(par_cMoeda) OR VARTYPE(par_dData) != "D" OR EMPTY(par_dData)
            RETURN 1
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
                       "WHERE cmoes = " + EscaparSQL(par_cMoeda) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cotacao")
            IF loc_nResult > 0
                SELECT cursor_4c_Cotacao
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1)
                    IF loc_nCotacao = 0
                        loc_nCotacao = 1
                    ENDIF
                ENDIF
                USE IN cursor_4c_Cotacao
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nCotacao
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores dos FILTROS do relatorio a partir de
    * um cursor (util para restaurar "ultimo filtro usado").
    *
    * Nao carrega dados de SigMvCcr - reports nao tem registro de entidade.
    * Cada campo eh aplicado somente se existir no cursor (TYPE() check),
    * permitindo evolucao do schema do cursor sem quebrar a chamada.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                    THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel: " + TRANSFORM(par_cAliasCursor)
                    EXIT
                ENDIF

                loc_cAlias = ALLTRIM(par_cAliasCursor)
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                    EXIT
                ENDIF

                *-- Data de Referencia
                IF TYPE(loc_cAlias + ".dt_inicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".dt_inicial")
                ENDIF

                *-- Grupo
                IF TYPE(loc_cAlias + ".cd_grupo") = "C"
                    THIS.this_cGrupos = ALLTRIM(EVALUATE(loc_cAlias + ".cd_grupo"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_grupo") = "C"
                    THIS.this_cDGrupos = ALLTRIM(EVALUATE(loc_cAlias + ".ds_grupo"))
                ENDIF

                *-- Conta
                IF TYPE(loc_cAlias + ".cd_conta") = "C"
                    THIS.this_cContas = ALLTRIM(EVALUATE(loc_cAlias + ".cd_conta"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_conta") = "C"
                    THIS.this_cDContas = ALLTRIM(EVALUATE(loc_cAlias + ".ds_conta"))
                ENDIF

                *-- Moeda
                IF TYPE(loc_cAlias + ".cd_moeda") = "C"
                    THIS.this_cMoedas = ALLTRIM(EVALUATE(loc_cAlias + ".cd_moeda"))
                ENDIF
                IF TYPE(loc_cAlias + ".ds_moeda") = "C"
                    THIS.this_cDMoedas = ALLTRIM(EVALUATE(loc_cAlias + ".ds_moeda"))
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: caso o BO seja usado por engano como CRUD, retorna
    * erro explicito ao inves de corromper o banco. O form legado SIGRECND
    * nao tinha botao "Incluir" - apenas Imprimir/Visualizar/Cancelar.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de Lan" + CHR(231) + "amentos N" + CHR(227) + ;
            "o Conciliados n" + CHR(227) + "o grava registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorios nao persistem dados.
    *
    * Override defensivo: simetrico a Inserir(). Reports nao modificam SigMvCcr;
    * apenas extraem dados via SELECT em PrepararDados() para gerar o TmpHist.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rio de Lan" + CHR(231) + "amentos N" + CHR(227) + ;
            "o Conciliados n" + CHR(227) + "o altera registros." + CHR(13) + ;
            "Use PrepararDados() seguido de Imprimir() ou Visualizar()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria de entidade.
    * Retorna composicao dos filtros usados como "identidade" da execucao.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = DTOC(THIS.this_dDtInicial)
        ENDIF
        IF !EMPTY(THIS.this_cGrupos)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cGrupos)
        ENDIF
        IF !EMPTY(THIS.this_cContas)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cContas)
        ENDIF
        IF !EMPTY(THIS.this_cMoedas)
            loc_cChave = loc_cChave + "|" + ALLTRIM(THIS.this_cMoedas)
        ENDIF

        RETURN loc_cChave
    ENDPROC

ENDDEFINE

