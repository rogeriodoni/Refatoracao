# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Ok' (parent: SIGPDM13): Left original=725 vs migrado 'cmd_4c_Ok' Left=906 (diff=181px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM13.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (717 linhas total):

*-- Linhas 92 a 100:
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarPageFrame()
94:         *-- Caption sem literais acentuados (CHR(231)=c-cedilha, CHR(227)=a-til)
95:         THIS.Caption = "Checagem de Devolu" + CHR(231) + CHR(227) + "o de Pedras"
96: 
97:         *-- Imagem de fundo do framework
98:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
99: 
100:         *-- Form modal sempre ao topo (WindowType=1 modal, AlwaysOnTop=.T.)

*-- Linhas 118 a 169:
118:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCnt = THIS.cnt_4c_Cabecalho
120:         WITH loc_oCnt
121:             .Top         = 0
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackStyle   = 1
126:             .BackColor   = RGB(100,100,100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         *-- lblSombra: sombra preta deslocada (ForeColor preto)
132:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
133:         WITH loc_oCnt.lbl_4c_LblSombra
134:             .Top           = 18
135:             .Left          = 10
136:             .Width         = 969
137:             .Height        = 40
138:             .FontName      = "Tahoma"
139:             .FontSize      = 18
140:             .FontBold      = .T.
141:             .FontUnderline = .F.
142:             .WordWrap      = .T.
143:             .Alignment     = 0
144:             .BackStyle     = 0
145:             .ForeColor     = RGB(0,0,0)
146:             .Caption       = loc_cCaption
147:             .Visible       = .T.
148:         ENDWITH
149: 
150:         *-- lblTitulo: titulo branco principal
151:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
152:         WITH loc_oCnt.lbl_4c_LblTitulo
153:             .Top       = 17
154:             .Left      = 10
155:             .Width     = 969
156:             .Height    = 46
157:             .FontName  = "Tahoma"
158:             .FontSize  = 18
159:             .FontBold  = .T.
160:             .WordWrap  = .T.
161:             .Alignment = 0
162:             .BackStyle = 0
163:             .ForeColor = RGB(255,255,255)
164:             .Caption   = loc_cCaption
165:             .Visible   = .T.
166:         ENDWITH
167:     ENDPROC
168: 
169:     *--------------------------------------------------------------------------

*-- Linhas 211 a 244:
211:         THIS.AddObject("cnt_4c_Operacao", "Container")
212:         loc_oCnt = THIS.cnt_4c_Operacao
213:         WITH loc_oCnt
214:             .Top         = 94
215:             .Left        = 75
216:             .Width       = 465
217:             .Height      = 40
218:             .BackStyle   = 0
219:             .BorderWidth = 0
220:             .Visible     = .T.
221:         ENDWITH
222: 
223:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
224:         WITH loc_oCnt.lbl_4c_Label1
225:             .Top      = 12
226:             .Left     = 10
227:             .AutoSize = .T.
228:             .BackStyle = 0
229:             .FontName = "Tahoma"
230:             .FontSize = 8
231:             .Caption  = "Movimenta" + CHR(231) + CHR(227) + "o :"
232:             .Visible  = .T.
233:         ENDWITH
234: 
235:         *-- Empresa do envelope (GetEmpresa do legado)
236:         loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
237:         WITH loc_oCnt.txt_4c_Empresa
238:             .Top               = 8
239:             .Left              = 130
240:             .Width             = 45
241:             .Height            = 23
242:             .ReadOnly          = .T.
243:             .FontName          = "Tahoma"
244:             .FontSize          = 8

*-- Linhas 251 a 260:
251:         *-- Codigo da operacao (GetOperacao do legado)
252:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
253:         WITH loc_oCnt.txt_4c_Operacao
254:             .Top               = 8
255:             .Left              = 178
256:             .Width             = 195
257:             .Height            = 23
258:             .ReadOnly          = .T.
259:             .FontName          = "Tahoma"
260:             .FontSize          = 8

*-- Linhas 267 a 276:
267:         *-- Numero do envelope (GetCodigo do legado)
268:         loc_oCnt.AddObject("txt_4c_Codigo", "TextBox")
269:         WITH loc_oCnt.txt_4c_Codigo
270:             .Top               = 8
271:             .Left              = 375
272:             .Width             = 101
273:             .Height            = 23
274:             .ReadOnly          = .T.
275:             .Format            = "L"
276:             .InputMask         = "9999999999"

*-- Linhas 286 a 336:
286:     *--------------------------------------------------------------------------
287:     * ConfigurarBotaoOK - Botao OK que fecha o form
288:     * Origem: SIGPDM13.Ok (Top=3, Left=725->906, Width=75, Height=75)
289:     *--------------------------------------------------------------------------
290:     PROTECTED PROCEDURE ConfigurarBotaoOK()
291:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
292:         WITH THIS.cmd_4c_Ok
293:             .Top             = 3
294:             .Left            = 906
295:             .Width           = 75
296:             .Height          = 75
297:             .Caption         = "OK"
298:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
299:             .FontName        = "Tahoma"
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .FontSize        = 8
303:             .ForeColor       = RGB(90,90,90)
304:             .BackColor       = RGB(255,255,255)
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .PicturePosition = 13
308:             .MousePointer    = 15
309:             .WordWrap        = .T.
310:             .Visible         = .T.
311:         ENDWITH
312: 
313:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOKClick")
314:     ENDPROC
315: 
316:     *--------------------------------------------------------------------------
317:     * ConfigurarGrid - Grid 4 colunas: Movimentacao|Componente|TpMaterial|Qtd
318:     * Origem: SIGPDM13.Grade (Top=132, Left=67->84, Width=673->841, Height=426)
319:     * Ordem visual: EmpDnPs | Cmats | TpOps | Qtds
320:     * Todas as colunas read-only (form de checagem/consulta)
321:     *--------------------------------------------------------------------------
322:     PROTECTED PROCEDURE ConfigurarGrid()
323:         LOCAL loc_oGrd
324: 
325:         THIS.AddObject("grd_4c_Dados", "Grid")
326:         loc_oGrd = THIS.grd_4c_Dados
327:         loc_oGrd.ColumnCount = 4
328: 
329:         WITH loc_oGrd
330:             .Top           = 132
331:             .Left          = 84
332:             .Width         = 841
333:             .Height        = 426
334:             .RecordMark    = .F.
335:             .DeleteMark    = .F.
336:             .GridLineColor = RGB(238,238,238)

*-- Linhas 346 a 354:
346:             .Resizable          = .F.
347:             .ReadOnly           = .T.
348:             .FontName           = "Courier New"
349:             .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
350:             .Header1.FontName   = "Tahoma"
351:             .Header1.FontSize   = 8
352:             .Header1.Alignment  = 2
353:             .Header1.ForeColor  = RGB(0,0,0)
354:             .Text1.FontName     = "Courier New"

*-- Linhas 367 a 375:
367:             .Movable            = .F.
368:             .Resizable          = .F.
369:             .ReadOnly           = .T.
370:             .Header1.Caption    = "Componente"
371:             .Header1.FontName   = "Tahoma"
372:             .Header1.FontSize   = 8
373:             .Header1.Alignment  = 2
374:             .Header1.ForeColor  = RGB(0,0,0)
375:             .Text1.BorderStyle  = 0

*-- Linhas 385 a 393:
385:             .Movable            = .F.
386:             .Resizable          = .F.
387:             .ReadOnly           = .T.
388:             .Header1.Caption    = "Tipo de Material"
389:             .Header1.FontName   = "Tahoma"
390:             .Header1.FontSize   = 8
391:             .Header1.Alignment  = 2
392:             .Header1.ForeColor  = RGB(0,0,0)
393:             .Text1.BorderStyle  = 0

*-- Linhas 405 a 413:
405:             .Movable            = .F.
406:             .Resizable          = .F.
407:             .ReadOnly           = .T.
408:             .Header1.Caption    = "Quantidade"
409:             .Header1.FontName   = "Tahoma"
410:             .Header1.FontSize   = 8
411:             .Header1.Alignment  = 2
412:             .Header1.ForeColor  = RGB(0,0,0)
413:             .Text1.BorderStyle  = 0

*-- Linhas 425 a 434:
425:     PROTECTED PROCEDURE ConfigurarTotalizador()
426:         THIS.AddObject("txt_4c_TotalQtds", "TextBox")
427:         WITH THIS.txt_4c_TotalQtds
428:             .Top       = 566
429:             .Left      = 745
430:             .Width     = 155
431:             .Height    = 21
432:             .InputMask = "9999"
433:             .MaxLength = 4
434:             .ReadOnly  = .T.

*-- Linhas 474 a 485:
474:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.Qtds"
475: 
476:                 *-- Reconfigurar headers obrigatoriamente apos RecordSource
477:                 loc_oGrd.Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
478:                 loc_oGrd.Column2.Header1.Caption = "Componente"
479:                 loc_oGrd.Column3.Header1.Caption = "Tipo de Material"
480:                 loc_oGrd.Column4.Header1.Caption = "Quantidade"
481: 
482:                 THIS.txt_4c_TotalQtds.Value = THIS.this_oBusinessObject.this_nTotalQtds
483: 
484:                 loc_oGrd.Refresh()
485:                 loc_lSucesso = .T.

*-- Linhas 521 a 530:
521:     PROTECTED PROCEDURE ConfigurarShape1()
522:         THIS.AddObject("shp_4c_Shape1", "Shape")
523:         WITH THIS.shp_4c_Shape1
524:             .Top         = 7
525:             .Left        = 874
526:             .Width       = 113
527:             .Height      = 110
528:             .BackStyle   = 0
529:             .BorderStyle = 0
530:             .BorderColor = RGB(136,189,188)


### BO (C:\4c\projeto\app\classes\SigPdM13BO.prg):
*==============================================================================
* SigPdM13BO.prg - Business Object para Checagem de Devolucao de Pedras
* Origem: SIGPDM13.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigPdM13BO AS BusinessBase

    *-- Configuracao da tabela principal
    this_cTabela      = "SigCdNei"
    this_cCampoChave  = "Nenvs"

    *-- Parametro de entrada: numero do envelope
    this_nNenvs       = 0

    *-- Informacoes do envelope (container Operacao)
    this_nNumps       = 0         && Numero do envelope
    this_cEmps        = ""        && Empresa
    this_cDopps       = ""        && Codigo da operacao

    *-- Campos da linha corrente do cursor (SigCdNei)
    this_cEmpDnPs     = ""        && Empresa/deposito da movimentacao
    this_cCmats       = ""        && Componente/material
    this_nQtds        = 0         && Quantidade
    this_cTpOps       = ""        && Tipo de operacao

    *-- Totalizador: SUM(Qtds) apos carregar cursor
    this_nTotalQtds   = 0

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdNei")
        THIS.this_cTabela     = "SigCdNei"
        THIS.this_cCampoChave = "Nenvs"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNenvs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades da linha corrente de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
                THIS.this_cCmats   = TratarNulo(Cmats,   "C")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cTpOps   = TratarNulo(TpOps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega informacoes do envelope para o container
    * par_nNenvs: numero do envelope
    * Cria cursor_4c_Operacao com numps, emps, dopps para ControlSource
    *--------------------------------------------------------------------------
    FUNCTION CarregarOperacao(par_nNenvs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            *-- Valores default: envelope passado, campos vazios
            THIS.this_nNumps = par_nNenvs
            THIS.this_cEmps  = ""
            THIS.this_cDopps = ""

            loc_cSQL = "SELECT TOP 1 numps, emps, dopps " + ;
                       "FROM SigCdNei " + ;
                       "WHERE Nenvs = " + TRANSFORM(par_nNenvs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacaoTemp")

            IF loc_nResultado >= 1 AND RECCOUNT("cursor_4c_OperacaoTemp") > 0
                SELECT cursor_4c_OperacaoTemp
                GO TOP
                THIS.this_nNumps = TratarNulo(numps, "N")
                THIS.this_cEmps  = TratarNulo(emps,  "C")
                THIS.this_cDopps = TratarNulo(dopps, "C")
            ENDIF

            IF USED("cursor_4c_OperacaoTemp")
                USE IN cursor_4c_OperacaoTemp
            ENDIF

            *-- Recriar cursor de bind para container Operacao
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Operacao (numps N(10,0) NULL, emps C(3) NULL, dopps C(20) NULL)
            SET NULL OFF

            SELECT cursor_4c_Operacao
            APPEND BLANK
            REPLACE numps WITH THIS.this_nNumps
            REPLACE emps  WITH THIS.this_cEmps
            REPLACE dopps WITH THIS.this_cDopps
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDados - Executa UNION ALL do legado e popula cursor_4c_Dados
    * Replica exata da query de SIGPDM13.Init:
    *   - Para devolucao: SepPedras=1, ChkDests<>4, tipo com chkDevs='S'
    *   - Ja devolvidos: ChkDests=4, Qtds negativo
    * par_nNenvs: numero do envelope
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_nNenvs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            THIS.this_nNenvs     = par_nNenvs
            THIS.this_nTotalQtds = 0

            *-- Protecao uncommitted changes no cursor do grid
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT a.EmpDnPs, a.Cmats, a.Qtds, a.TpOps " + ;
                       "FROM SigCdNei a, SigCdOpd b, SigOpOpt c " + ;
                       "WHERE a.Nenvs = " + TRANSFORM(par_nNenvs) + ;
                       " AND a.Dopps = b.Dopps AND b.SepPedras = 1" + ;
                       " AND b.ChkDests <> 4" + ;
                       " AND a.TpOps = c.Cods AND c.chkDevs = 'S'" + ;
                       " UNION ALL" + ;
                       " SELECT a.EmpDnPs, a.Cmats, (a.Qtds * -1) AS Qtds, a.TpOps" + ;
                       " FROM SigCdNei a, SigCdOpd b" + ;
                       " WHERE a.Nenvs = " + TRANSFORM(par_nNenvs) + ;
                       " AND a.Dopps = b.Dopps AND b.ChkDests = 4" + ;
                       " ORDER BY a.Cmats"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado < 1
                MsgErro("Falha ao carregar dados de devolu" + CHR(231) + CHR(227) + "o de pedras.", "Erro")
            ELSE
                *-- Calcular total (replica: Sum Qtds to _Total do legado)
                SELECT cursor_4c_DadosTemp
                SUM Qtds TO THIS.this_nTotalQtds
                GO TOP

                *-- Criar cursor definitivo com estrutura identica ao temporario
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (EmpDnPs C(33) NULL, Cmats C(14) NULL, Qtds N(9,3) NULL, TpOps C(15) NULL)
                SET NULL OFF

                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_DadosTemp")
                GO TOP

                USE IN cursor_4c_DadosTemp

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNei com os campos disponiveis na linha corrente
    * Form SIGPDM13 eh OPERACIONAL/consulta - este metodo existe para paridade
    * com BusinessBase e eventuais chamadas de processo de checagem.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdNei " + ;
                       "(Nenvs, numps, emps, dopps, EmpDnPs, Cmats, Qtds, TpOps) " + ;
                       "VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nNenvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps)   + ", " + ;
                       EscaparSQL(THIS.this_cEmps)           + ", " + ;
                       EscaparSQL(THIS.this_cDopps)          + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnPs)        + ", " + ;
                       EscaparSQL(THIS.this_cCmats)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)    + ", " + ;
                       EscaparSQL(THIS.this_cTpOps)          + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao inserir registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNei dos campos da linha corrente
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNei SET " + ;
                       "Qtds   = " + FormatarNumeroSQL(THIS.this_nQtds)  + ", " + ;
                       "TpOps  = " + EscaparSQL(THIS.this_cTpOps)        + ", " + ;
                       "numps  = " + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       "emps   = " + EscaparSQL(THIS.this_cEmps)         + ", " + ;
                       "dopps  = " + EscaparSQL(THIS.this_cDopps)        + " " + ;
                       "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nNenvs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdNei filtrado pela chave corrente
    * PROTECTED conforme padrao BusinessBase (chamado via Excluir() publico)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdNei " + ;
                       "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nNenvs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao excluir registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigCdNei") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nNenvs)) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       THIS.FormatarDatetimeSQL(DATETIME()) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para CONVERT SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDatetimeSQL(par_dtVal)
        LOCAL loc_cDate, loc_cTime
        loc_cDate = PADL(TRANSFORM(YEAR(par_dtVal)),   4, "0") + "-" + ;
                    PADL(TRANSFORM(MONTH(par_dtVal)),  2, "0") + "-" + ;
                    PADL(TRANSFORM(DAY(par_dtVal)),    2, "0")
        loc_cTime = PADL(TRANSFORM(HOUR(par_dtVal)),   2, "0") + ":" + ;
                    PADL(TRANSFORM(MINUTE(par_dtVal)), 2, "0") + ":" + ;
                    PADL(TRANSFORM(SEC(par_dtVal)),    2, "0")
        RETURN "CONVERT(DATETIME, '" + loc_cDate + " " + loc_cTime + "', 120)"
    ENDPROC

ENDDEFINE

