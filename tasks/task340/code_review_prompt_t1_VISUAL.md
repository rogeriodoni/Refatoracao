# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [GRID-HEADER] Header Caption 'Referência SKU' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: SKU ID, Nome SKU, SKU Ativo, Referencia SKU. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRVTX.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (947 linhas total):

*-- Linhas 89 a 99:
89: 
90:             *-- Titulo do formulario (CHR: Importacao = Importa+231+227+o)
91:             loc_cTitulo = "Importa" + CHR(231) + CHR(227) + "o de SKUs (VTX)"
92:             THIS.Caption = loc_cTitulo
93:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = loc_cTitulo
94:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = loc_cTitulo
95: 
96:             *-- BINDEVENT para KeyPress no nivel do form (ESC fecha)
97:             BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")
98: 
99:             *-- Conecta grade ao cursor vazio inicial

*-- Linhas 116 a 160:
116:         loc_oCab = THIS.cnt_4c_Cabecalho
117: 
118:         WITH loc_oCab
119:             .Top         = 0
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:         ENDWITH
127: 
128:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oCab.lbl_4c_Sombra
130:             .AutoSize   = .F.
131:             .FontName   = "Tahoma"
132:             .FontSize   = 18
133:             .FontBold   = .T.
134:             .WordWrap   = .T.
135:             .BackStyle  = 0
136:             .Caption    = ""
137:             .Height     = 40
138:             .Left       = 10
139:             .Top        = 18
140:             .Width      = THIS.Width - 20
141:             .ForeColor  = RGB(0, 0, 0)
142:         ENDWITH
143: 
144:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oCab.lbl_4c_Titulo
146:             .AutoSize   = .F.
147:             .FontName   = "Tahoma"
148:             .FontSize   = 18
149:             .FontBold   = .T.
150:             .WordWrap   = .T.
151:             .BackStyle  = 0
152:             .Caption    = ""
153:             .Height     = 46
154:             .Left       = 10
155:             .Top        = 17
156:             .Width      = THIS.Width - 20
157:             .ForeColor  = RGB(255, 255, 255)
158:         ENDWITH
159:     ENDPROC
160: 

*-- Linhas 174 a 212:
174:             .SpecialEffect = 1
175:             .BorderColor   = RGB(136, 189, 188)
176:             .Height        = 85
177:             .Left          = 840
178:             .Top           = -2
179:             .Width         = 160
180:             WITH .Buttons(1)
181:                 .Top        = 5
182:                 .Left       = 5
183:                 .Height     = 75
184:                 .Width      = 75
185:                 .FontBold   = .T.
186:                 .FontItalic = .T.
187:                 .FontName   = "Tahoma"
188:                 .FontSize   = 8
189:                 .WordWrap   = .T.
190:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
191:                 .Caption    = "\<Salvar"
192:                 .ForeColor  = RGB(90, 90, 90)
193:                 .BackColor  = RGB(255, 255, 255)
194:                 .Themes     = .F.
195:             ENDWITH
196:             WITH .Buttons(2)
197:                 .Top        = 5
198:                 .Left       = 80
199:                 .Height     = 75
200:                 .Width      = 75
201:                 .FontBold   = .T.
202:                 .FontItalic = .T.
203:                 .FontName   = "Tahoma"
204:                 .FontSize   = 8
205:                 .WordWrap   = .T.
206:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
207:                 .Caption    = "Encerrar"
208:                 .ForeColor  = RGB(90, 90, 90)
209:                 .BackColor  = RGB(255, 255, 255)
210:                 .Themes     = .F.
211:             ENDWITH
212:         ENDWITH

*-- Linhas 251 a 343:
251:         *-- Shape decorativo ao redor da area de selecao de planilha
252:         THIS.AddObject("shp_4c_Shape1", "Shape")
253:         WITH THIS.shp_4c_Shape1
254:             .Top           = 82
255:             .Left          = 38
256:             .Width         = 632
257:             .Height        = 52
258:             .Curvature     = 0
259:             .SpecialEffect = 1
260:             .FillStyle     = 1
261:             .BackStyle     = 0
262:             .BorderStyle   = 0
263:             .BorderColor   = RGB(136, 189, 188)
264:         ENDWITH
265: 
266:         *-- Label "Planilha:" (Say4 legado: top=84, left=133)
267:         THIS.AddObject("lbl_4c_Label4", "Label")
268:         WITH THIS.lbl_4c_Label4
269:             .Top       = 87
270:             .Left      = 166
271:             .Width     = 61
272:             .Height    = 15
273:             .Caption   = "Planilha:"
274:             .FontName  = "Tahoma"
275:             .FontSize  = 8
276:             .FontBold  = .T.
277:             .BackStyle = 0
278:             .ForeColor = RGB(90, 90, 90)
279:             .AutoSize  = .T.
280:         ENDWITH
281: 
282:         *-- TextBox para caminho da planilha (GetPlanilha legado: top=101, left=133, w=336)
283:         THIS.AddObject("txt_4c_Planilha", "TextBox")
284:         WITH THIS.txt_4c_Planilha
285:             .Top         = 105
286:             .Left        = 166
287:             .Width       = 420
288:             .Height      = 23
289:             .Value       = ""
290:             .FontName    = "Tahoma"
291:             .FontSize    = 8
292:             .ReadOnly    = .T.
293:             .BackColor   = RGB(255, 255, 255)
294:             .ForeColor   = RGB(90, 90, 90)
295:             .BorderStyle = 1
296:         ENDWITH
297: 
298:         *-- Botao para selecionar arquivo (cmdgetp legado: top=86, left=471, w=65, h=44)
299:         THIS.AddObject("cmd_4c_GetPlanilha", "CommandButton")
300:         loc_oBtn = THIS.cmd_4c_GetPlanilha
301:         WITH loc_oBtn
302:             .Top             = 89
303:             .Left            = 589
304:             .Width           = 81
305:             .Height          = 44
306:             .Caption         = ""
307:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
308:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
309:             .FontName        = "Verdana"
310:             .FontSize        = 8
311:             .Themes          = .T.
312:             .BackColor       = RGB(255, 255, 255)
313:             .ForeColor       = RGB(36, 84, 155)
314:             .ToolTipText     = "Selecionar planilha Excel"
315:             .MousePointer    = 15
316:         ENDWITH
317: 
318:         *-- Vincula evento do botao de selecao de arquivo (integracao area Dados)
319:         BINDEVENT(THIS.cmd_4c_GetPlanilha, "Click", THIS, "CmdGetPlanilhaClick")
320:     ENDPROC
321: 
322:     *==========================================================================
323:     PROTECTED PROCEDURE ConfigurarPaginaLista()
324:     *-- Area de resultado/lista: grade de SKUs importados + botoes Processar/Limpar.
325:     *-- Form OPERACIONAL flat (sem PageFrame): esta e a metade "resultado"
326:     *-- do layout do legado SIGPRVTX (Grade + cmdProcessar + cmdLimpar).
327:     *==========================================================================
328:         LOCAL loc_oGrid, loc_oBtn
329: 
330:         *-- Botao Limpar (cmdLimpar legado: top=3, left=498, w=75, h=75)
331:         THIS.AddObject("cmd_4c_Limpar", "CommandButton")
332:         loc_oBtn = THIS.cmd_4c_Limpar
333:         WITH loc_oBtn
334:             .Top             = 3
335:             .Left            = 623
336:             .Width           = 75
337:             .Height          = 75
338:             .Caption         = "\<Limpar"
339:             .FontName        = "Tahoma"
340:             .FontSize        = 8
341:             .FontBold        = .T.
342:             .FontItalic      = .T.
343:             .WordWrap        = .T.

*-- Linhas 352 a 367:
352:         ENDWITH
353: 
354:         *-- Botao Processar/Importar (cmdProcessar legado: top=3, left=573, w=75, h=75)
355:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
356:         loc_oBtn = THIS.cmd_4c_Processar
357:         WITH loc_oBtn
358:             .Top             = 3
359:             .Left            = 716
360:             .Width           = 75
361:             .Height          = 75
362:             .Caption         = "\<Processar"
363:             .FontName        = "Tahoma"
364:             .FontSize        = 8
365:             .FontBold        = .T.
366:             .FontItalic      = .T.
367:             .WordWrap        = .T.

*-- Linhas 379 a 388:
379:         THIS.AddObject("grd_4c_Dados", "Grid")
380:         loc_oGrid = THIS.grd_4c_Dados
381:         WITH loc_oGrid
382:             .Top                = 138
383:             .Left               = 12
384:             .Width              = 976
385:             .Height             = 450
386:             .ColumnCount        = 4
387:             .RecordMark         = .F.
388:             .DeleteMark         = .F.

*-- Linhas 400 a 409:
400:         ENDWITH
401: 
402:         *-- Vincula eventos dos botoes de acao da area lista/resultado
403:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
404:         BINDEVENT(THIS.cmd_4c_Limpar,    "Click", THIS, "CmdLimparClick")
405:     ENDPROC
406: 
407:     *==========================================================================
408:     PROCEDURE AlternarPagina(par_nPagina)
409:     *-- Form OPERACIONAL flat: sem alternancia de paginas

*-- Linhas 588 a 621:
588:             .Column1.ReadOnly         = .T.
589:             .Column1.Movable          = .F.
590:             .Column1.Resizable        = .F.
591:             .Column1.Header1.Caption  = "SKU ID"
592:             .Column1.Header1.FontName = "Tahoma"
593:             .Column1.Header1.FontBold = .T.
594: 
595:             .Column2.ControlSource    = "cursor_4c_Grade.nomesku"
596:             .Column2.Width            = 539
597:             .Column2.ReadOnly         = .T.
598:             .Column2.Movable          = .F.
599:             .Column2.Resizable        = .F.
600:             .Column2.Header1.Caption  = "Nome SKU"
601:             .Column2.Header1.FontName = "Tahoma"
602:             .Column2.Header1.FontBold = .T.
603: 
604:             .Column3.ControlSource    = "cursor_4c_Grade.skuativo"
605:             .Column3.Width            = 94
606:             .Column3.ReadOnly         = .T.
607:             .Column3.Movable          = .F.
608:             .Column3.Resizable        = .F.
609:             .Column3.Header1.Caption  = "SKU Ativo"
610:             .Column3.Header1.FontName = "Tahoma"
611:             .Column3.Header1.FontBold = .T.
612: 
613:             .Column4.ControlSource    = "cursor_4c_Grade.refsku"
614:             .Column4.Width            = 249
615:             .Column4.ReadOnly         = .T.
616:             .Column4.Header1.Caption  = "Refer" + CHR(234) + "ncia SKU"
617:             .Column4.Header1.FontName = "Tahoma"
618:             .Column4.Header1.FontBold = .T.
619: 
620:             .Refresh()
621:         ENDWITH

*-- Linhas 903 a 918:
903:         IF VARTYPE(THIS.txt_4c_Planilha) = "O"
904:             THIS.txt_4c_Planilha.ReadOnly = !loc_lHab
905:         ENDIF
906:         IF VARTYPE(THIS.cmd_4c_GetPlanilha) = "O"
907:             THIS.cmd_4c_GetPlanilha.Enabled = loc_lHab
908:         ENDIF
909:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
910:             THIS.cmd_4c_Processar.Enabled = loc_lHab
911:         ENDIF
912:         IF VARTYPE(THIS.cmd_4c_Limpar) = "O"
913:             THIS.cmd_4c_Limpar.Enabled = loc_lHab
914:         ENDIF
915:     ENDPROC
916: 
917:     *==========================================================================
918:     PROTECTED PROCEDURE LimparCampos()


### BO (C:\4c\projeto\app\classes\SIGPRVTXBO.prg):
*==============================================================================
* SIGPRVTXBO.prg - Business Object para FormSIGPRVTX
* Importacao de planilha Excel para atualizacao de SKUs (sigprvtx)
* Data: 2026-07-19
* Tabela principal: sigprvtx | PK: cidchaves
* Tabela auxiliar: SigCdPac (leitura de sigkeys)
*==============================================================================
DEFINE CLASS SIGPRVTXBO AS BusinessBase

    *-- -----------------------------------------------------------------------
    *-- CHAVE DE CONFIGURACAO (SigCdPac.sigkeys - lida no Init do Form)
    *-- -----------------------------------------------------------------------
    this_cSigKey        = ""    && sigkeys char(3) - chave de pacote de config

    *-- -----------------------------------------------------------------------
    *-- CAMINHO DA PLANILHA SELECIONADA
    *-- -----------------------------------------------------------------------
    this_cPlanilha      = ""    && Caminho completo do arquivo .xls selecionado

    *-- -----------------------------------------------------------------------
    *-- CAMPOS DA TABELA sigprvtx (PK + campos da planilha + demais colunas)
    *-- -----------------------------------------------------------------------
    this_cCidChaves     = ""    && cidchaves char(20)  NOT NULL - PK (fUniqueIds)
    this_cNomeSku       = ""    && nomesku   char(100) NOT NULL
    this_cRefSku        = ""    && refsku    char(40)  NOT NULL
    this_cSkuAtivo      = ""    && skuativo  char(3)   NOT NULL
    this_cSkuId         = ""    && skuid     char(10)  NOT NULL
    this_cCpros         = ""    && cpros     char(14)  NOT NULL
    this_cDescritivo    = ""    && descritivo char(45) NOT NULL
    this_cTamanho       = ""    && tamanho   char(4)   NOT NULL
    this_nQtd           = 0     && qtd       numeric(11,3) NOT NULL
    this_nBxQtd         = 0     && bxqtd     numeric(11,3) NOT NULL
    this_lChkAtuStock   = .F.   && chkatustock bit NULL
    this_nPvens         = 0     && pvens     numeric(11,5) NOT NULL
    this_nPrecode       = 0     && precode   numeric(11,5) NOT NULL
    this_lCkVtexUp      = .F.   && ckvtexup  bit NULL
    this_lCkAtuDesc     = .F.   && ckAtudesc bit NULL
    this_nVtexProdId    = 0     && vtexProdId int NULL

    *-- -----------------------------------------------------------------------
    *-- NOME DO CURSOR DA GRADE (padrao OPERACIONAL - cursor_4c_Grade)
    *-- -----------------------------------------------------------------------
    this_cCursorDados   = "cursor_4c_Grade"

    *--------------------------------------------------------------------------
    * Init - Configura BO: tabela e campo-chave da sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "sigprvtx"
            THIS.this_cCampoChave = "cidchaves"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do registro corrente
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cSkuId      = ALLTRIM(NVL(skuid, ""))
                THIS.this_cNomeSku    = ALLTRIM(NVL(nomesku, ""))
                THIS.this_cSkuAtivo   = ALLTRIM(NVL(skuativo, ""))
                THIS.this_cRefSku     = ALLTRIM(NVL(refsku, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor " + par_cAliasCursor + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " em uso"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro na tabela sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO sigprvtx " + ;
                "(cidchaves, nomesku, refsku, skuativo, skuid, " + ;
                "cpros, descritivo, tamanho, qtd, bxqtd, " + ;
                "chkatustock, pvens, precode, ckvtexup, ckAtudesc, vtexProdId) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cNomeSku, 100)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cRefSku, 40)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSkuAtivo, 3)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSkuId, 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDescritivo, 45)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cTamanho, 4)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtd, 3) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBxQtd, 3) + ", " + ;
                IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
                FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
                IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
                IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
                IIF(THIS.this_nVtexProdId = 0, "NULL", FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em sigprvtx (SKU: " + ;
                    ALLTRIM(THIS.this_cSkuId) + ")"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela sigprvtx
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigprvtx SET " + ;
                "nomesku = "     + EscaparSQL(LEFT(THIS.this_cNomeSku, 100)) + ", " + ;
                "refsku = "      + EscaparSQL(LEFT(THIS.this_cRefSku, 40)) + ", " + ;
                "skuativo = "    + EscaparSQL(LEFT(THIS.this_cSkuAtivo, 3)) + ", " + ;
                "skuid = "       + EscaparSQL(LEFT(THIS.this_cSkuId, 10)) + ", " + ;
                "cpros = "       + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                "descritivo = "  + EscaparSQL(LEFT(THIS.this_cDescritivo, 45)) + ", " + ;
                "tamanho = "     + EscaparSQL(LEFT(THIS.this_cTamanho, 4)) + ", " + ;
                "qtd = "         + FormatarNumeroSQL(THIS.this_nQtd, 3) + ", " + ;
                "bxqtd = "       + FormatarNumeroSQL(THIS.this_nBxQtd, 3) + ", " + ;
                "chkatustock = " + IIF(THIS.this_lChkAtuStock, "1", "NULL") + ", " + ;
                "pvens = "       + FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + ;
                "precode = "     + FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + ;
                "ckvtexup = "    + IIF(THIS.this_lCkVtexUp, "1", "NULL") + ", " + ;
                "ckAtudesc = "   + IIF(THIS.this_lCkAtuDesc, "1", "NULL") + ", " + ;
                "vtexProdId = "  + IIF(THIS.this_nVtexProdId = 0, "NULL", ;
                                      FormatarNumeroSQL(THIS.this_nVtexProdId, 0)) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 1
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em sigprvtx (cidchaves: " + ;
                    ALLTRIM(THIS.this_cCidChaves) + ")"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Popula o cursor da grade com os registros ja persistidos
    *                 em sigprvtx (usado por BtnVisualizarClick / refresh).
    *                 Cria cursor local com as 4 colunas do grid (skuid,
    *                 nomesku, skuativo, refsku) via SQLEXEC intermediario e
    *                 depois REPLICA em cursor local com nome canonico.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGrade(par_cCursorGrade)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursorTmp
        loc_lSucesso   = .F.
        loc_cCursorTmp = "cursor_4c_GradeTmp"

        TRY
            loc_cSQL = "SELECT skuid, nomesku, skuativo, refsku FROM sigprvtx"

            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF

            SET NULL ON
            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp) >= 0
                *-- (Re)cria cursor com nome canonico e ordem/estrutura
                *-- identicas ao placeholder do form (protege ColumnCount/tags)
                IF USED(par_cCursorGrade)
                    SELECT (par_cCursorGrade)
                    USE
                ENDIF

                CREATE CURSOR (par_cCursorGrade) (;
                    skuid    C(10)  NULL, ;
                    nomesku  C(100) NULL, ;
                    skuativo C(3)   NULL, ;
                    refsku   C(40)  NULL)
                SELECT (par_cCursorGrade)
                INDEX ON skuid TAG skuid

                SELECT (loc_cCursorTmp)
                GO TOP
                SCAN
                    INSERT INTO (par_cCursorGrade) ;
                        (skuid, nomesku, skuativo, refsku) VALUES ( ;
                            NVL(skuid, ""), ;
                            NVL(nomesku, ""), ;
                            NVL(skuativo, ""), ;
                            NVL(refsku, ""))
                    SELECT (loc_cCursorTmp)
                ENDSCAN

                IF USED(loc_cCursorTmp)
                    USE IN (loc_cCursorTmp)
                ENDIF

                SELECT (par_cCursorGrade)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao consultar sigprvtx"
            ENDIF
            SET NULL OFF
        CATCH TO loc_oErro
            SET NULL OFF
            IF USED(loc_cCursorTmp)
                USE IN (loc_cCursorTmp)
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarGrade - Deleta todos os registros de sigprvtx e reinsere a
    *                  partir do cursor da grade (replica logica cmdok.Click)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarGrade(par_cCursorGrade)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL
        loc_lSucesso = .F.
        loc_lTransacao = .F.

        TRY
            IF !USED(par_cCursorGrade)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorGrade + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " em uso"
            ELSE
                SELECT (par_cCursorGrade)
                GO TOP

                IF RECCOUNT(par_cCursorGrade) = 0
                    THIS.this_cMensagemErro = "Nenhum registro para atualiza" + ;
                        CHR(231) + CHR(227) + "o"
                ELSE
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                    loc_lTransacao = .T.

                    loc_cSQL = "DELETE FROM sigprvtx"
                    loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) >= 1)

                    IF loc_lSucesso
                        SELECT (par_cCursorGrade)
                        GO TOP

                        SCAN WHILE loc_lSucesso
                            IF THIS.CarregarDoCursor(par_cCursorGrade)
                                IF !THIS.Inserir()
                                    loc_lSucesso = .F.
                                ENDIF
                            ELSE
                                loc_lSucesso = .F.
                            ENDIF
                            SELECT (par_cCursorGrade)
                        ENDSCAN

                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT")
                            loc_lTransacao = .F.
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao excluir registros de sigprvtx"
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lSucesso AND loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

