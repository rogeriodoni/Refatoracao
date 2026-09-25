# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'excluir' (parent: SIGMVCHV): Left original=401 vs migrado 'cmd_4c_Excluir' Left=230 (diff=171px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigMvChv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (947 linhas total):

*-- Linhas 83 a 92:
83:                 *-- Propaga o Caption do form para os labels do cabecalho (form
84:                 *-- OPERACIONAL flat: cnt_4c_Cabecalho fica direto em THIS, sem
85:                 *-- pgf_4c_Paginas/Page1 - a estrutura CRUD nao se aplica aqui)
86:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
88: 
89:                 *-- Sem conexao em modo de teste de UI (ValidarUIFidelity)
90:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
91:                     THIS.CarregarLista()
92:                 ENDIF

*-- Linhas 128 a 177:
128:         TRY
129:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
130:             WITH THIS.cnt_4c_Cabecalho
131:                 .Top         = 0
132:                 .Left        = 0
133:                 .Width       = THIS.Width
134:                 .Height      = 80
135:                 .BackStyle   = 1
136:                 .BackColor   = RGB(100, 100, 100)
137:                 .BorderWidth = 0
138:                 .Visible     = .T.
139:             ENDWITH
140: 
141:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
142:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
143:                 .FontBold      = .T.
144:                 .FontName      = "Tahoma"
145:                 .FontSize      = 18
146:                 .FontUnderline = .F.
147:                 .WordWrap      = .T.
148:                 .Alignment     = 0
149:                 .BackStyle     = 0
150:                 .AutoSize      = .F.
151:                 .Caption       = THIS.Caption
152:                 .Height        = 40
153:                 .Left          = 10
154:                 .Top           = 18
155:                 .Width         = THIS.Width - 40
156:                 .ForeColor     = RGB(0, 0, 0)
157:                 .Visible       = .T.
158:             ENDWITH
159: 
160:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
162:                 .FontBold      = .T.
163:                 .FontName      = "Tahoma"
164:                 .FontSize      = 18
165:                 .WordWrap      = .T.
166:                 .Alignment     = 0
167:                 .BackStyle     = 0
168:                 .AutoSize      = .F.
169:                 .Caption       = THIS.Caption
170:                 .Height        = 46
171:                 .Left          = 10
172:                 .Top           = 17
173:                 .Width         = THIS.Width - 40
174:                 .ForeColor     = RGB(255, 255, 255)
175:                 .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
176:                 .Visible       = .T.
177:             ENDWITH

*-- Linhas 211 a 268:
211:             THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
212:             loc_oCmg = THIS.cmg_4c_Botoes
213:             WITH loc_oCmg
214:                 .Top           = -2
215:                 .Left          = 344
216:                 .Width         = 160
217:                 .Height        = 85
218:                 .ButtonCount   = 2
219:                 .AutoSize      = .T.
220:                 .BackStyle     = 0
221:                 .BorderStyle   = 0
222:                 .SpecialEffect = 1
223:                 .BorderColor   = RGB(136, 189, 188)
224:                 .Themes        = .F.
225:                 .Value         = 0
226: 
227:                 WITH .Buttons(1)
228:                     .Top           = 5
229:                     .Left          = 80
230:                     .Width         = 75
231:                     .Height        = 75
232:                     .FontName      = "Comic Sans MS"
233:                     .FontSize      = 8
234:                     .FontBold      = .T.
235:                     .FontItalic    = .T.
236:                     .WordWrap      = .T.
237:                     .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
238:                     *-- "\<" = tecla de acesso Alt+C do legado (Command1.Caption
239:                     *-- = "\<Cancelar"). PILAR 1: atalhos de teclado identicos.
240:                     .Caption       = "\<Cancelar"
241:                     .Cancel        = .T.
242:                     .MousePointer  = 15
243:                     .ToolTipText   = "[Esc] Encerrar"
244:                     .SpecialEffect = 0
245:                     .ForeColor     = RGB(90, 90, 90)
246:                     .BackColor     = RGB(255, 255, 255)
247:                     .Themes        = .F.
248:                 ENDWITH
249: 
250:                 WITH .Buttons(2)
251:                     .Top          = 5
252:                     .Left         = 5
253:                     .Width        = 75
254:                     .Height       = 75
255:                     .FontName     = "Comic Sans MS"
256:                     .FontSize     = 8
257:                     .FontBold     = .T.
258:                     .FontItalic   = .T.
259:                     .WordWrap     = .T.
260:                     .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
261:                     *-- "\<" = tecla de acesso Alt+C do legado (Command2.Caption
262:                     *-- = "\<Confirmar"). PILAR 1: atalhos de teclado identicos.
263:                     .Caption      = "\<Confirmar"
264:                     .MousePointer = 15
265:                     .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
266:                     .ForeColor    = RGB(90, 90, 90)
267:                     .BackColor    = RGB(255, 255, 255)
268:                     .Themes       = .F.

*-- Linhas 275 a 284:
275:             THIS.AddObject("grd_4c_Dados", "Grid")
276:             loc_oGrd = THIS.grd_4c_Dados
277:             WITH loc_oGrd
278:                 .Top           = 86
279:                 .Left          = 56
280:                 .Width         = 342
281:                 .Height        = 259
282:                 .ColumnCount   = 1
283:                 .FontName      = "Tahoma"
284:                 .FontSize      = 8

*-- Linhas 298 a 306:
298:                 .Resizable = .F.
299:                 .ReadOnly  = !THIS.this_lModoEdicao
300:             ENDWITH
301:             loc_oGrd.Column1.Header1.Caption   = "Chave"
302:             loc_oGrd.Column1.Header1.Alignment = 2
303:             WITH loc_oGrd.Column1.Text1
304:                 .FontName    = "Tahoma"
305:                 .FontSize    = 8
306:                 .Alignment   = 3

*-- Linhas 316 a 396:
316:             loc_oGrd.ColumnCount = 1
317:             loc_oGrd.RecordSource            = "cursor_4c_Dados"
318:             loc_oGrd.Column1.ControlSource   = "cursor_4c_Dados.ChaveNota"
319:             loc_oGrd.Column1.Header1.Caption = "Chave"
320:             loc_oGrd.Column1.Width           = 310
321:             loc_oGrd.Column1.ReadOnly        = !THIS.this_lModoEdicao
322: 
323:             IF THIS.this_lModoEdicao
324:                 BINDEVENT(loc_oGrd.Column1.Text1, "KeyPress", THIS, "ValidarChaveGrade")
325:             ENDIF
326: 
327:             *-- Botoes standalone Incluir/Excluir - habilitados so em
328:             *-- INSERIR/ALTERAR (equivalente ao When legado
329:             *-- "Return(INLIST(Thisform.pcEscolha,'INSERIR','ALTERAR'))")
330:             THIS.AddObject("cmd_4c_Incluir", "CommandButton")
331:             WITH THIS.cmd_4c_Incluir
332:                 .Top             = 171
333:                 .Left = 5
334:                 .Width           = 45
335:                 .Height          = 45
336:                 .FontBold        = .T.
337:                 .FontName        = "Verdana"
338:                 .FontSize        = 8
339:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
340:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
341:                 .Caption         = ""
342:                 .ToolTipText     = "Inserir"
343:                 .ForeColor       = RGB(36, 84, 155)
344:                 .BackColor       = RGB(255, 255, 255)
345:                 .Themes          = .T.
346:                 .Enabled         = THIS.this_lModoEdicao
347:             ENDWITH
348:             BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
349: 
350:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
351:             WITH THIS.cmd_4c_Excluir
352:                 .Top             = 216
353:                 .Left = 230
354:                 .Width           = 45
355:                 .Height          = 45
356:                 .FontBold        = .T.
357:                 .FontName        = "Verdana"
358:                 .FontSize        = 8
359:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
360:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
361:                 .Caption         = ""
362:                 .ToolTipText     = "Excluir"
363:                 .ForeColor       = RGB(36, 84, 155)
364:                 .BackColor       = RGB(255, 255, 255)
365:                 .Themes          = .T.
366:                 .Enabled         = THIS.this_lModoEdicao
367:             ENDWITH
368:             BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
369:         CATCH TO loc_oErro
370:             MsgErro(loc_oErro.Message + CHR(13) + ;
371:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
372:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaLista")
373:         ENDTRY
374:     ENDPROC
375: 
376:     *==========================================================================
377:     * CarregarLista - (Re)carrega as chaves do documento no cursor_4c_Dados
378:     * via BO e rebinda a grade (o BO fecha/recria o cursor a cada chamada,
379:     * entao RecordSource/ControlSource/Header/Width precisam ser reaplicados).
380:     *==========================================================================
381:     PROCEDURE CarregarLista()
382:         LOCAL loc_lOk, loc_oErro
383:         loc_lOk = .F.
384: 
385:         TRY
386:             loc_lOk = THIS.this_oBusinessObject.Buscar(THIS.this_cEmpDopNums)
387: 
388:             IF loc_lOk AND USED("cursor_4c_Dados") AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
389:                 THIS.grd_4c_Dados.RecordSource           = "cursor_4c_Dados"
390:                 THIS.grd_4c_Dados.Column1.ControlSource  = "cursor_4c_Dados.ChaveNota"
391:                 THIS.grd_4c_Dados.Column1.Header1.Caption = "Chave"
392:                 THIS.grd_4c_Dados.Column1.Width          = 310
393:                 THIS.grd_4c_Dados.Column1.ReadOnly       = !THIS.this_lModoEdicao
394: 
395:                 SELECT cursor_4c_Dados
396:                 GO TOP


### BO (C:\4c\projeto\app\classes\SigMvChvBO.prg):
*==============================================================================
* SIGMVCHVBO.PRG
* Business Object - Chaves de Nota (SigMvChv)
*
* Form OPERACIONAL: dialogo auxiliar chamado por outro form para o usuario
* incluir/excluir Chaves de Nota (ChaveNota) associadas a um documento pai
* (EmpDopNums). No legado (SIGMVCHV.Init) o form manipula um cursor local
* crChaves ja populado pelo form chamador (Select crChaves / Go Top) e so
* grava a tabela real por fora (fluxo comentado no legado, nunca ativo).
*
* Tabela SigMvChv existe no schema (chavenota, empdopnums, pkchaves - mesmas
* 3 colunas do cursor crChaves) - este BO usa arquitetura em camadas (PILAR 3)
* e persiste cada linha na tabela via Inserir/Atualizar/ExecutarExclusao.
*==============================================================================

DEFINE CLASS SigMvChvBO AS BusinessBase

    *-- Propriedades especificas da entidade SigMvChv (linha do cursor crChaves)
    this_cChaveNota  = ""   && crChaves.ChaveNota  - chave da nota digitada pelo usuario
    this_cEmpDopNums = ""   && crChaves.EmpDopNums - empresa + numero do documento pai
    this_cPkChaves   = ""   && crChaves.pkChaves   - chave primaria Fortyus (Sys(2015)+Sys(2015))

    *--------------------------------------------------------------------------
    * Init - Construtor
    * Tabela SigMvChv (chavenota, empdopnums, pkchaves) existe no schema com
    * as mesmas 3 colunas do cursor local crChaves do legado - THIS BO grava
    * cada linha nela via Inserir/Atualizar (arquitetura camadas, PILAR 3).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvChv"
        THIS.this_cCampoChave = "pkChaves"

        THIS.this_cChaveNota  = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cPkChaves   = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de uma linha do
    * cursor informado (crChaves ou cursor_4c_Dados, mesma estrutura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChaveNota  = TratarNulo(ChaveNota, "C")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                THIS.this_cPkChaves   = TratarNulo(pkChaves, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Limpa propriedades de dados
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        THIS.this_cChaveNota  = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cPkChaves   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Mesma checagem do legado: ChaveNota nao pode ficar vazia (Valid do
    * grade.Column1.Text1 so processa "If Not Empty(This.Value)")
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cChaveNota))
            THIS.this_cMensagemErro = "Chave da nota " + CHR(233) + " obrigat" + CHR(243) + "ria"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cEmpDopNums))
            THIS.this_cMensagemErro = "Documento de origem (EmpDopNums) " + CHR(227) + "o informado"
            MsgAviso(THIS.this_cMensagemErro, "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteChaveDuplicada - Espelha o Valid do legado: bloqueia gravar duas
    * linhas com a mesma ChaveNota (Select ChaveNota, Count(*) ... Group By)
    *--------------------------------------------------------------------------
    PROCEDURE ExisteChaveDuplicada(par_cChaveNota, par_cPkChavesAtual)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicada
        loc_lDuplicada = .F.

        TRY
            IF USED("cursor_4c_DupChv")
                USE IN cursor_4c_DupChv
            ENDIF

            loc_cSQL = "SELECT pkchaves FROM SigMvChv WHERE chavenota = " + ;
                       EscaparSQL(ALLTRIM(par_cChaveNota)) + ;
                       " AND empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums)) + ;
                       " AND pkchaves <> " + EscaparSQL(ALLTRIM(par_cPkChavesAtual))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupChv")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupChv") > 0
                loc_lDuplicada = .T.
            ENDIF

            IF USED("cursor_4c_DupChv")
                USE IN cursor_4c_DupChv
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicada
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista as chaves de nota de um documento (grid da lista).
    * A grade edita ChaveNota diretamente na celula (transcricao do
    * grade.Column1.Text1 legado), entao o cursor NAO pode ficar somente-
    * leitura como o SQLEXEC entrega por padrao - converte via cursor
    * temporario para cursor_4c_Dados READWRITE.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT chavenota AS ChaveNota, empdopnums AS EmpDopNums," + ;
                           " pkchaves AS pkChaves FROM SigMvChv" + ;
                           " WHERE empdopnums = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                           " ORDER BY chavenota"
            ELSE
                loc_cSQL = "SELECT chavenota AS ChaveNota, empdopnums AS EmpDopNums," + ;
                           " pkchaves AS pkChaves FROM SigMvChv ORDER BY chavenota"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar chaves de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigMvChv (PROTECTED, chamado por Salvar())
    * Gera pkChaves via fUniqueIds() quando ainda nao preenchida, igual ao
    * legado (Sys(2015)+Sys(2015)) so que com o helper canonico do sistema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigMvChv (chavenota, empdopnums, pkchaves) VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cChaveNota), 44)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cPkChaves), 20)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsChv")
            IF USED("cursor_4c_InsChv")
                USE IN cursor_4c_InsChv
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigMvChv (PROTECTED, chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para altera" + CHR(231) + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "UPDATE SigMvChv SET " + ;
                           "chavenota = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cChaveNota), 44)) + ", " + ;
                           "empdopnums = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpDopNums), 29)) + ;
                           " WHERE pkchaves = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AltChv")
                IF USED("cursor_4c_AltChv")
                    USE IN cursor_4c_AltChv
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao alterar chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigMvChv (PROTECTED, chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para exclus" + CHR(227) + "o", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigMvChv WHERE pkchaves = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcChv")
                IF USED("cursor_4c_ExcChv")
                    USE IN cursor_4c_ExcChv
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir chave de nota:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

