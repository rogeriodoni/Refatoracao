# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1065 linhas total):

*-- Linhas 8 a 17:
8: * MIGRACAO COMPLETA (8/8 fases)
9: *   - Init(4 params): armazena ParentForm, CPros, CGrus, PcEscolha
10: *   - ConfigurarPageFrame: fundo new_background.jpg (form plano OPERACIONAL)
11: *   - ConfigurarCabecalho: cnt_4c_Cabecalho cinza com lbl_4c_Sombra/Titulo
12: *   - ConfigurarBotoes: Shape1 + cmd_4c_Inserir/Excluir/Sair
13: *   - ConfigurarGrade: grd_4c_Grade (2 colunas Codigos+Descrs) + cursor placeholder
14: *   - CarregarGrid: SQLEXEC sigprcar filtrado por CPros (cursor temp + ZAP/APPEND)
15: *   - AjustarBotoesVisibilidade: Inserir/Excluir visiveis apenas em INSERIR/ALTERAR
16: *   - RegistrarBINDEVENTs: Click e KeyPress bindados
17: *   - CmdInserirClick: insere linha vazia, foca Column1

*-- Linhas 70 a 78:
70:     *-- Armazena parametros do form pai ANTES de InicializarForm().
71:     *-- DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
72:     *===========================================================================
73:         THIS.Caption          = "Caracter" + CHR(237) + "sticas do Produto"
74:         THIS.this_oParentForm = par_oParentForm
75:         THIS.this_cCpros      = IIF(VARTYPE(par_cCpros)     = "C", ALLTRIM(par_cCpros),     "")
76:         THIS.this_cCgrus      = IIF(VARTYPE(par_cCgrus)     = "C", ALLTRIM(par_cCgrus),     "")
77:         THIS.this_cPcEscolha  = IIF(VARTYPE(par_cPcEscolha) = "C", UPPER(par_cPcEscolha),   "CONSULTAR")
78: 

*-- Linhas 109 a 118:
109:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
110:                 THIS.ConfigurarPageFrame()
111:                 THIS.ConfigurarCabecalho()
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
114:                 THIS.ConfigurarPaginaLista()
115:                 THIS.ConfigurarPaginaDados()
116:                 THIS.TornarControlesVisiveis(THIS)
117:                 THIS.AjustarBotoesVisibilidade()
118:                 loc_lSucesso = .T.

*-- Linhas 127 a 136:
127:                     ELSE
128:                         THIS.ConfigurarPageFrame()
129:                         THIS.ConfigurarCabecalho()
130:                         THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
131:                         THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
132:                         THIS.ConfigurarPaginaLista()
133:                         THIS.ConfigurarPaginaDados()
134:                         THIS.TornarControlesVisiveis(THIS)
135:                         THIS.AjustarBotoesVisibilidade()
136:                         THIS.CarregarGrid()

*-- Linhas 155 a 200:
155:     *===========================================================================
156:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
157:         WITH THIS.cnt_4c_Cabecalho
158:             .Top         = 0
159:             .Left        = 0
160:             .Width       = THIS.Width
161:             .Height      = 80
162:             .BackStyle   = 1
163:             .BackColor   = RGB(100, 100, 100)
164:             .BorderWidth = 0
165:             .Visible     = .T.
166: 
167:             .AddObject("lbl_4c_Sombra", "Label")
168:             WITH .lbl_4c_Sombra
169:                 .Top       = 25
170:                 .Left      = 10
171:                 .Width     = THIS.Width
172:                 .Height    = 40
173:                 .AutoSize  = .F.
174:                 .BackStyle = 0
175:                 .FontBold  = .T.
176:                 .FontName  = "Tahoma"
177:                 .FontSize  = 18
178:                 .ForeColor = RGB(0, 0, 0)
179:                 .Caption   = "Caracter" + CHR(237) + "sticas do Produto"
180:                 .Visible   = .T.
181:             ENDWITH
182: 
183:             .AddObject("lbl_4c_Titulo", "Label")
184:             WITH .lbl_4c_Titulo
185:                 .Top       = 24
186:                 .Left      = 10
187:                 .Width     = THIS.Width
188:                 .Height    = 46
189:                 .AutoSize  = .F.
190:                 .BackStyle = 0
191:                 .FontBold  = .T.
192:                 .FontName  = "Tahoma"
193:                 .FontSize  = 18
194:                 .ForeColor = RGB(255, 255, 255)
195:                 .Caption   = "Caracter" + CHR(237) + "sticas do Produto"
196:                 .Visible   = .T.
197:             ENDWITH
198:         ENDWITH
199:     ENDPROC
200: 

*-- Linhas 254 a 279:
254:         *-- Shape decorativo por tras dos botoes (Shape1 do legado: Top=-3, Left=239, W=250, H=38)
255:         THIS.AddObject("shp_4c_Shape1", "Shape")
256:         WITH THIS.shp_4c_Shape1
257:             .Top         = -3
258:             .Left        = 239
259:             .Width       = 250
260:             .Height      = 38
261:             .BackStyle   = 0
262:             .BorderStyle = 0
263:             .BorderColor = RGB(136, 189, 188)
264:             .Visible     = .T.
265:         ENDWITH
266: 
267:         *-- cmd_4c_Inserir (cmdInserir do legado - Left=255, TabIndex=1)
268:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
269:         WITH THIS.cmd_4c_Inserir
270:             .Top             = 3
271:             .Left            = 255
272:             .Width           = 70
273:             .Height          = 70
274:             .Caption         = "Inserir"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
276:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
277:             .PicturePosition = 13
278:             .FontName        = "Tahoma"
279:             .FontBold        = .T.

*-- Linhas 290 a 305:
290:             .Visible         = .T.
291:         ENDWITH
292: 
293:         *-- cmd_4c_Excluir (cmdExcluir do legado - Left=330, TabIndex=2)
294:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
295:         WITH THIS.cmd_4c_Excluir
296:             .Top             = 3
297:             .Left            = 330
298:             .Width           = 70
299:             .Height          = 70
300:             .Caption         = "Excluir"
301:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
302:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
303:             .PicturePosition = 13
304:             .FontName        = "Tahoma"
305:             .FontBold        = .T.

*-- Linhas 316 a 331:
316:             .Visible         = .T.
317:         ENDWITH
318: 
319:         *-- cmd_4c_Sair/Encerrar (cmdSair do legado - Left=405, Cancel=.T., TabIndex=3)
320:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
321:         WITH THIS.cmd_4c_Sair
322:             .Top             = 3
323:             .Left            = 405
324:             .Width           = 75
325:             .Height          = 75
326:             .Caption         = "Encerrar"
327:             .Cancel          = .T.
328:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
329:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:             .PicturePosition = 13
331:             .FontName        = "Tahoma"

*-- Linhas 368 a 377:
368:         loc_oGrade.RecordSource = THIS.this_cCursorCarac
369: 
370:         WITH loc_oGrade
371:             .Top                = 103
372:             .Left               = 8
373:             .Width              = 463
374:             .Height             = 411
375:             .FontName           = "Tahoma"
376:             .FontSize           = 8
377:             .AllowHeaderSizing  = .F.

*-- Linhas 395 a 403:
395:                     .FontName  = "Tahoma"
396:                     .FontSize  = 8
397:                     .Alignment = 2
398:                     .Caption   = "Caracter" + CHR(237) + "stica"
399:                     .ForeColor = RGB(90, 90, 90)
400:                 ENDWITH
401:             ENDWITH
402: 
403:             *-- Coluna 2: Descrs (Descricao)

*-- Linhas 412 a 420:
412:                     .FontName  = "Tahoma"
413:                     .FontSize  = 8
414:                     .Alignment = 2
415:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
416:                     .ForeColor = RGB(90, 90, 90)
417:                 ENDWITH
418:             ENDWITH
419:         ENDWITH
420:     ENDPROC

*-- Linhas 458 a 467:
458:             WITH THIS.grd_4c_Grade
459:                 .Column1.ControlSource   = THIS.this_cCursorCarac + ".Codigos"
460:                 .Column2.ControlSource   = THIS.this_cCursorCarac + ".Descrs"
461:                 .Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
462:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
463:             ENDWITH
464: 
465:             THIS.grd_4c_Grade.Refresh()
466:             loc_lResultado = .T.
467:         CATCH TO loc_oErro

*-- Linhas 481 a 508:
481: 
482:         loc_lVis = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
483: 
484:         THIS.cmd_4c_Inserir.Visible = loc_lVis
485:         THIS.cmd_4c_Inserir.Enabled = loc_lVis
486:         THIS.cmd_4c_Excluir.Visible = loc_lVis
487:         THIS.cmd_4c_Excluir.Enabled = loc_lVis
488: 
489:         THIS.grd_4c_Grade.ReadOnly = !loc_lVis
490: 
491:         IF !loc_lVis
492:             THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
493:             THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left  - 5
494:         ENDIF
495:     ENDPROC
496: 
497:     *===========================================================================
498:     PROTECTED PROCEDURE RegistrarBINDEVENTs()
499:     *-- Vincula eventos dos botoes e celulas do grid aos handlers PUBLIC.
500:     *===========================================================================
501:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
502:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
503:         BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "CmdSairClick")
504:         BINDEVENT(THIS.grd_4c_Grade.Column1.Text1, "KeyPress", THIS, "GrdCol1KeyPress")
505:         BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress", THIS, "GrdCol2KeyPress")
506:     ENDPROC
507: 
508:     *===========================================================================


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*====================================================================
* SigPrCarBO.prg
* Business Object: Caracteristicas do Produto (sigprcar)
* Tabela principal: sigprcar
* Sub-form: aberto pelo form de produto (SigPrApr/SigPrAop)
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Campos da tabela sigprcar
    this_cCodigos  = ""    && char(20) - codigo da caracteristica (FK SIGCRRAP)
    this_cCpros    = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_cPkChaves = ""    && char(20) - chave primaria

    *-- Campo de exibicao: vem de SIGCRRAP.descrs, NAO armazenado em sigprcar
    this_cDescrs   = ""    && char(40) - descricao da caracteristica

    *-- Contexto do produto pai (passado pelo form chamador)
    this_cCgrus    = ""    && char(3) - grupo do produto (filtro de lookup SigCrRap)

    *-- Flags de controle de sessao (consultados pelo form pai apos fechar)
    this_lHouveIncl = .F.  && houve insercao nesta sessao
    this_lHouveExcl = .F.  && houve exclusao nesta sessao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprcar"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    * par_cAliasCursor: alias do cursor (crSigPrCar ou outro)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(codigos,  "C")
            THIS.this_cCpros    = TratarNulo(cpros,    "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            IF TYPE("descrs") != "U"
                THIS.this_cDescrs = TratarNulo(descrs, "C")
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (pkchaves)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *====================================================================
    * Inserir - SQL INSERT INTO sigprcar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)   + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - SQL UPDATE sigprcar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprcar SET codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao - SQL DELETE FROM sigprcar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprcar WHERE pkchaves = " + ;
                       EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * InserirNovaLinha - Insere linha vazia no cursor local
    * Equivalente a cmdInserir.Click do legado
    * par_cCursorCarac: alias do cursor local (ex: "crSigPrCar")
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE InserirNovaLinha(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cPkChaves, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                *-- Verifica se ja existe linha vazia para este produto
                SELECT (par_cCursorCarac)
                LOCATE FOR RTRIM(cpros) == RTRIM(par_cCpros) AND EMPTY(codigos) AND !DELETED()
                IF !EOF()
                    loc_lResultado = .T.
                ELSE
                    *-- Obtem chave unica do SQL Server
                    IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_PrCarNewid") > 0
                        SELECT cursor_4c_PrCarNewid
                        loc_cPkChaves = LEFT(ALLTRIM(nid), 20)
                        USE IN cursor_4c_PrCarNewid
                    ELSE
                        loc_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)
                    ENDIF

                    *-- Insere linha vazia no cursor local
                    SELECT (par_cCursorCarac)
                    INSERT INTO (par_cCursorCarac) (cpros, pkchaves, codigos, descrs) ;
                        VALUES (par_cCpros, loc_cPkChaves, "", "")

                    THIS.this_lHouveIncl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir nova linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove o registro corrente do cursor local
    * Equivalente a cmdExcluir.Click do legado
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto (verificacao de seguranca)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (par_cCursorCarac)
                IF !EOF() AND RTRIM(cpros) == RTRIM(par_cCpros)
                    DELETE
                    SKIP
                    SKIP -1
                    THIS.this_lHouveExcl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * LimparLinhasVazias - Remove linhas sem codigo do cursor local
    * Chamado antes de fechar o form (cmdSair.Click do legado)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE LimparLinhasVazias(par_cCursorCarac)
        LOCAL loc_oErro
        TRY
            IF USED(par_cCursorCarac)
                SELECT (par_cCursorCarac)
                SCAN WHILE !EOF()
                    IF EMPTY(codigos)
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao limpar linhas vazias: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * BuscarCodigoExato - Busca codigo exato em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    * par_cCodigos: valor a buscar
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular com resultado
    *====================================================================
    PROCEDURE BuscarCodigoExato(par_cCodigos, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar c" + CHR(243) + "digo: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarDescricaoExata - Busca descricao exata em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    *====================================================================
    PROCEDURE BuscarDescricaoExata(par_cDescrs, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE descrs = " + EscaparSQL(par_cDescrs) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar descri" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorCodigo - Lista para picker (Column1)
    * Busca registros em SIGCRRAP por LIKE no campo codigos
    * par_cValor: prefixo digitado
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorCodigo(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE codigos LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorDescricao - Lista para picker (Column2)
    * Busca registros em SIGCRRAP por LIKE no campo descrs
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorDescricao(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE descrs LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Checa se codigo ja existe no cursor local
    * para o mesmo produto (exceto o registro corrente)
    * Retorna .T. se duplicado
    * par_cCodigos: codigo a verificar
    * par_cPkChaveAtual: pkchaves do registro corrente (excluido da busca)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodigos, par_cPkChaveAtual, par_cCursorCarac)
        LOCAL loc_lDuplicado, loc_oErro
        loc_lDuplicado = .F.
        TRY
            IF USED(par_cCursorCarac) AND !EMPTY(par_cCodigos)
                SELECT codigos FROM (par_cCursorCarac) ;
                    WHERE RTRIM(codigos) == RTRIM(par_cCodigos) ;
                    AND RTRIM(pkchaves) != RTRIM(par_cPkChaveAtual) ;
                    AND !DELETED() ;
                    INTO CURSOR cursor_4c_PrCarDupCheck
                SELECT cursor_4c_PrCarDupCheck
                loc_lDuplicado = !EOF()
                USE IN cursor_4c_PrCarDupCheck
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao verificar duplicidade: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * SalvarTodasCaracteristicas - Persiste cursor local no SQL Server
    * Chamado pelo form pai (SigPrAop/SigPrApr) ao salvar o produto
    * Estrategia: DELETE todas as do produto + INSERT das validas
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE SalvarTodasCaracteristicas(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_lOk
        loc_lResultado = .F.
        TRY
            *-- Remove todas as caracteristicas anteriores do produto
            loc_cSQL = "DELETE FROM sigprcar WHERE cpros = " + EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lOk = .T.
                *-- Reinsere todas as linhas validas do cursor local
                IF USED(par_cCursorCarac)
                    SELECT (par_cCursorCarac)
                    GO TOP
                    SCAN WHILE !EOF() AND loc_lOk
                        IF !DELETED() AND !EMPTY(codigos)
                            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                                       EscaparSQL(codigos) + ", " + ;
                                       EscaparSQL(par_cCpros) + ", " + ;
                                       EscaparSQL(pkchaves) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                THIS.this_cMensagemErro = "Erro ao salvar caracter" + ;
                                    CHR(237) + "stica: " + ALLTRIM(codigos)
                                loc_lOk = .F.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDIF
                IF loc_lOk
                    loc_lResultado = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + ;
                    "sticas anteriores do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao salvar caracter" + CHR(237) + ;
                "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

