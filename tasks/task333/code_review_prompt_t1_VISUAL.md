# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'Saida' (parent: SIGPRSND): Left original=425 vs migrado 'cnt_4c_Saida' Left=917 (diff=492px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSnd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (748 linhas total):

*-- Linhas 45 a 66:
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.Caption = "Senhas livres"
49: 
50:             *-- Criar Business Object
51:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrSndBO")
52:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
53:                 MsgErro("Falha ao criar SigPrSndBO", "Erro")
54:             ELSE
55:                 *-- Configurar picture de fundo do form
56:                 THIS.ConfigurarPageFrame()
57: 
58:                 *-- Cabecalho cinza escuro com titulo
59:                 THIS.ConfigurarCabecalho()
60:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
61:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
62: 
63:                 *-- Botao Encerrar (padrao canonico Left=917)
64:                 THIS.ConfigurarSaida()
65: 
66:                 *-- Controles principais (grid + campos + botoes operacionais)

*-- Linhas 108 a 150:
108: 
109:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
110:         WITH THIS.cnt_4c_Cabecalho
111:             .Top         = 0
112:             .Left        = 0
113:             .Width       = loc_nW
114:             .Height      = 80
115:             .BackStyle   = 1
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .AutoSize  = .F.
124:             .Width     = loc_nW
125:             .Height    = 40
126:             .Top       = 18
127:             .Left      = 10
128:             .Caption   = ""
129:             .FontName  = "Tahoma"
130:             .FontSize  = 18
131:             .FontBold  = .T.
132:             .BackStyle = 0
133:             .ForeColor = RGB(0, 0, 0)
134:             .WordWrap  = .T.
135:             .Alignment = 0
136:         ENDWITH
137: 
138:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
139:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
140:             .AutoSize  = .F.
141:             .Width     = loc_nW
142:             .Height    = 46
143:             .Top       = 17
144:             .Left      = 10
145:             .Caption   = ""
146:             .FontName  = "Tahoma"
147:             .FontSize  = 18
148:             .FontBold  = .T.
149:             .BackStyle = 0
150:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 158 a 190:
158:     *==========================================================================
159:     PROTECTED PROCEDURE ConfigurarSaida
160:     *==========================================================================
161:         *-- Padrao canonico OPERACIONAL: Top=4, Left=917, Width=90, Height=85
162:         *-- Botoes de acao (btnExcel/btnGerSen) ficam a esquerda do Encerrar
163:         THIS.AddObject("cnt_4c_Saida", "Container")
164:         WITH THIS.cnt_4c_Saida
165:             .Top         = 4
166:             .Left        = 917
167:             .Width       = 90
168:             .Height      = 85
169:             .BackStyle   = 0
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
175:         WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
176:             .Top             = 5
177:             .Left            = 5
178:             .Width           = 75
179:             .Height          = 75
180:             .Caption         = "Encerrar"
181:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
182:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
183:             .Themes          = .F.
184:             .FontName        = "Tahoma"
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .FontSize        = 8
188:             .ForeColor       = RGB(90, 90, 90)
189:             .BackColor       = RGB(255, 255, 255)
190:             .SpecialEffect   = 0

*-- Linhas 204 a 227:
204:         *-- Em 1000px: botoes ficam na faixa Left=100..900
205:         THIS.AddObject("cnt_4c_Botoes", "Container")
206:         WITH THIS.cnt_4c_Botoes
207:             .Top         = 4
208:             .Left        =  542
209:             .Width       = 560
210:             .Height      = 85
211:             .BackStyle   = 0
212:             .BorderWidth = 0
213:             .Visible     = .T.
214:         ENDWITH
215: 
216:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_SenPend", "CommandButton")
217:         WITH THIS.cnt_4c_Botoes.cmd_4c_SenPend
218:             .Top             = 5
219:             .Left            = 5
220:             .Width           = 170
221:             .Height          = 75
222:             .Caption         = "Senhas pendentes"
223:             .Picture         = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
224:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_60.jpg"
225:             .Themes          = .F.
226:             .FontName        = "Tahoma"
227:             .FontBold        = .T.

*-- Linhas 235 a 249:
235:             .MousePointer    = 15
236:         ENDWITH
237: 
238:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Excel", "CommandButton")
239:         WITH THIS.cnt_4c_Botoes.cmd_4c_Excel
240:             .Top             = 5
241:             .Left            = 185
242:             .Width           = 170
243:             .Height          = 75
244:             .Caption         = "Excel"
245:             .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
246:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
247:             .Themes          = .F.
248:             .FontName        = "Tahoma"
249:             .FontBold        = .T.

*-- Linhas 257 a 271:
257:             .MousePointer    = 15
258:         ENDWITH
259: 
260:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_GerSen", "CommandButton")
261:         WITH THIS.cnt_4c_Botoes.cmd_4c_GerSen
262:             .Top             = 5
263:             .Left            = 365
264:             .Width           = 170
265:             .Height          = 75
266:             .Caption         = "Gerar Senha"
267:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
268:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
269:             .Themes          = .F.
270:             .FontName        = "Tahoma"
271:             .FontBold        = .T.

*-- Linhas 282 a 297:
282:         *-- Label e TextBox para quantidade de senhas
283:         *-- Original: Label3 Top=87 Left=54 / getqtdsen Top=84 Left=152 (forma 500px)
284:         *-- Escalado para 1000px: mesmas proporcoes
285:         THIS.AddObject("lbl_4c_QtdSen", "Label")
286:         WITH THIS.lbl_4c_QtdSen
287:             .Caption   = "Qtde de Senhas :"
288:             .AutoSize  = .F.
289:             .Width     = 100
290:             .Height    = 23
291:             .Top       = 100
292:             .Left      = 100
293:             .FontName  = "Tahoma"
294:             .FontSize  = 8
295:             .BackStyle = 0
296:             .ForeColor = RGB(90, 90, 90)
297:         ENDWITH

*-- Linhas 304 a 313:
304:             .MaxLength     = 3
305:             .Width         = 60
306:             .Height        = 23
307:             .Top           = 97
308:             .Left          = 210
309:             .Alignment     = 3
310:             .FontName      = "Tahoma"
311:             .FontSize      = 8
312:             .ForeColor     = RGB(90, 90, 90)
313:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 320 a 329:
320:         *-- Em 1000px: proporcional mas com mais espaco
321:         THIS.AddObject("grd_4c_Dados", "Grid")
322:         WITH THIS.grd_4c_Dados
323:             .Top               = 140
324:             .Left              = 100
325:             .Width             = 280
326:             .Height            = 420
327:             .ColumnCount       = 1
328:             .FontSize          = 8
329:             .FontName          = "Verdana"

*-- Linhas 344 a 384:
344:         THIS.grd_4c_Dados.Column1.ColumnOrder = 1
345:         THIS.grd_4c_Dados.Column1.ReadOnly    = .T.
346:         THIS.grd_4c_Dados.Column1.FontSize    = 8
347:         THIS.grd_4c_Dados.Column1.Header1.Caption   = "Senhas geradas"
348:         THIS.grd_4c_Dados.Column1.Header1.FontName  = "Verdana"
349:         THIS.grd_4c_Dados.Column1.Header1.FontSize  = 8
350:         THIS.grd_4c_Dados.Column1.Header1.Alignment = 2
351:         THIS.grd_4c_Dados.Column1.Header1.ForeColor = RGB(36, 84, 155)
352:         *-- Text1.When retorna .F. (somente leitura na UI)
353:         THIS.grd_4c_Dados.Column1.Sparse = .F.
354:     ENDPROC
355: 
356:     *==========================================================================
357:     PROTECTED PROCEDURE VincularEventos
358:     *==========================================================================
359:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
360:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_SenPend, "Click", THIS, "CmdSenPendClick")
361:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Excel,   "Click", THIS, "CmdExcelClick")
362:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_GerSen,  "Click", THIS, "CmdGerSenClick")
363:     ENDPROC
364: 
365:     *==========================================================================
366:     * AtualizarGrid - Vincula cursor ao grid e reconfigura ControlSource
367:     *==========================================================================
368:     PROCEDURE AtualizarGrid()
369:         LOCAL loc_oGrid
370:         loc_oGrid = THIS.grd_4c_Dados
371:         IF VARTYPE(loc_oGrid) != "O"
372:             RETURN
373:         ENDIF
374:         loc_oGrid.RecordSource = ""
375:         IF USED("crSigPrSnd")
376:             loc_oGrid.ColumnCount              = 1
377:             loc_oGrid.RecordSource             = "crSigPrSnd"
378:             loc_oGrid.Column1.ControlSource    = "crSigPrSnd.Senhads"
379:             loc_oGrid.Column1.Header1.Caption  = "Senhas geradas"
380:             loc_oGrid.Refresh()
381:         ENDIF
382:     ENDPROC
383: 
384:     *==========================================================================

*-- Linhas 668 a 678:
668:             THIS.txt_4c_Qtdsen.Enabled = loc_lHab
669:         ENDIF
670:         IF PEMSTATUS(THIS, "cnt_4c_Botoes", 5)
671:             THIS.cnt_4c_Botoes.cmd_4c_SenPend.Enabled = loc_lHab
672:             THIS.cnt_4c_Botoes.cmd_4c_Excel.Enabled   = loc_lHab
673:             THIS.cnt_4c_Botoes.cmd_4c_GerSen.Enabled  = loc_lHab
674:         ENDIF
675:     ENDPROC
676: 
677:     *==========================================================================
678:     * LimparCampos - Reseta campos para estado inicial

*-- Linhas 726 a 734:
726:     *==========================================================================
727:     * ConfigurarPaginaDados - Form OPERACIONAL flat: nao ha Page2
728:     * Legado SIGPRSND tem tela unica com botoes no topo + textbox qtde + grid.
729:     * Todos os campos (lbl_4c_QtdSen, txt_4c_Qtdsen, grd_4c_Dados) estao em
730:     * ConfigurarPaginaLista(). Metodo mantido por compatibilidade com pipeline.
731:     *==========================================================================
732:     PROTECTED PROCEDURE ConfigurarPaginaDados
733:         RETURN
734:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrSndBO.prg):
*==============================================================================
* SigPrSndBO.prg - Business Object: Senhas Livres
* Tabela: SigPrSnd
* Chave: cidchaves char(20)
*==============================================================================
DEFINE CLASS SigPrSndBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela      = "SigPrSnd"
    this_cCampoChave  = "cidchaves"

    *-- Propriedades mapeadas para colunas de SigPrSnd
    this_cCidChaves   = ""   && cidchaves char(20) PK NOT NULL
    this_dDatas       = {}   && datas     datetime NULL
    this_nDocs        = 0    && docs      numeric(10,0) NOT NULL
    this_cHoras       = ""   && horas     char(8) NOT NULL
    this_cMotivos     = ""   && motivos   char(40) NOT NULL
    this_cOperas      = ""   && operas    char(20) NOT NULL
    this_cSenhads     = ""   && senhads   char(6) NOT NULL
    this_cSolicits    = ""   && solicits  char(10) NOT NULL
    this_cUsuars      = ""   && usuars    char(10) NOT NULL
    this_nValors      = 0    && valors    numeric(11,2) NOT NULL
    this_nTipos       = 0    && tipos     numeric(1,0) NOT NULL
    this_cEmps        = ""   && emps      char(3) NOT NULL
    this_cFpags       = ""   && fpags     char(12) NOT NULL
    this_cEmpDopNums  = ""   && empdopnums char(29) NOT NULL
    this_nPerlimite   = 0    && perlimite numeric(5,2) NOT NULL

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrSnd"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Inicializa cursor vazio com estrutura de SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            *-- Query que retorna 0 registros para criar cursor estruturado vazio
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves = " + ;
                EscaparSQL(REPLICATE(CHR(254), 20))
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_nDocs       = TratarNulo(docs,       "N")
                THIS.this_cHoras      = TratarNulo(horas,      "C")
                THIS.this_cMotivos    = TratarNulo(motivos,    "C")
                THIS.this_cOperas     = TratarNulo(operas,     "C")
                THIS.this_cSenhads    = TratarNulo(senhads,    "C")
                THIS.this_cSolicits   = TratarNulo(solicits,   "C")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_nValors     = TratarNulo(valors,     "N")
                THIS.this_nTipos      = TratarNulo(tipos,      "N")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cFpags      = TratarNulo(fpags,      "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrSnd (todas as colunas NOT NULL)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.GerarIdUnico()
            ENDIF
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                "VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)              + ", " + ;
                EscaparSQL(LEFT(THIS.this_cUsuars, 10))       + ", " + ;
                "GETDATE(), "                                          + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0)        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSenhads, 6))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cHoras, 8))         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmps, 3))          + ", " + ;
                FormatarNumeroSQL(THIS.this_nDocs, 0)         + ", " + ;
                EscaparSQL(LEFT(THIS.this_cMotivos, 40))      + ", " + ;
                EscaparSQL(LEFT(THIS.this_cOperas, 20))       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cSolicits, 10))     + ", " + ;
                FormatarNumeroSQL(THIS.this_nValors, 2)       + ", " + ;
                EscaparSQL(LEFT(THIS.this_cFpags, 12))        + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29))   + ", " + ;
                FormatarNumeroSQL(THIS.this_nPerlimite, 2)    + ;
                ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                "usuars     = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10))     + ", " + ;
                "datas      = " + FormatarDataSQL(THIS.this_dDatas)           + ", " + ;
                "tipos      = " + FormatarNumeroSQL(THIS.this_nTipos, 0)      + ", " + ;
                "senhads    = " + EscaparSQL(LEFT(THIS.this_cSenhads, 6))     + ", " + ;
                "horas      = " + EscaparSQL(LEFT(THIS.this_cHoras, 8))       + ", " + ;
                "emps       = " + EscaparSQL(LEFT(THIS.this_cEmps, 3))        + ", " + ;
                "docs       = " + FormatarNumeroSQL(THIS.this_nDocs, 0)       + ", " + ;
                "motivos    = " + EscaparSQL(LEFT(THIS.this_cMotivos, 40))    + ", " + ;
                "operas     = " + EscaparSQL(LEFT(THIS.this_cOperas, 20))     + ", " + ;
                "solicits   = " + EscaparSQL(LEFT(THIS.this_cSolicits, 10))   + ", " + ;
                "valors     = " + FormatarNumeroSQL(THIS.this_nValors, 2)     + ", " + ;
                "fpags      = " + EscaparSQL(LEFT(THIS.this_cFpags, 12))      + ", " + ;
                "empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                "perlimite  = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " "  + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar senha em SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrSnd " + ;
                "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir senha de SigPrSnd.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarSemVinculo - Carrega senhas livres com EmpDopNums em branco
    *--------------------------------------------------------------------------
    PROCEDURE BuscarSemVinculo()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigPrSnd WHERE EmpDopNums = ''"
            IF USED("crSigPrSnd")
                USE IN crSigPrSnd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                SELECT crSigPrSnd
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSenhas - Gera N senhas livres e insere em SigPrSnd
    *--------------------------------------------------------------------------
    PROCEDURE GerarSenhas(par_nQtd)
        LOCAL loc_lSucesso, loc_n, loc_nSenha, loc_cSenha, loc_cId
        LOCAL loc_cSQL, loc_cChaves, loc_lTransacao, loc_lErroSQL
        loc_lSucesso   = .F.
        loc_cChaves    = ""
        loc_lTransacao = .F.
        loc_lErroSQL   = .F.
        TRY
            IF VARTYPE(par_nQtd) != "N" OR par_nQtd <= 0
                MsgAviso("Quantidade de senhas inv" + CHR(225) + "lida.", "Aviso")
            ELSE
                IF MsgConfirma("Deseja realmente gerar " + ;
                    ALLTRIM(STR(par_nQtd)) + " senhas livres?", "Gerar Senha")
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                    loc_lTransacao = .T.
                    FOR loc_n = 1 TO par_nQtd
                        IF !loc_lErroSQL
                            *-- Gera senha unica nao existente em SigPrSnd
                            loc_nSenha = 0
                            DO WHILE loc_nSenha = 0
                                loc_nSenha = THIS.GerarSenhaAleatoria()
                                loc_cSenha = STR(loc_nSenha, 6)
                                IF THIS.SenhaExisteSQL(loc_cSenha)
                                    loc_nSenha = 0
                                ENDIF
                            ENDDO
                            loc_cId  = THIS.GerarIdUnico()
                            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                                "(cidchaves, usuars, datas, tipos, senhads, horas, " + ;
                                " emps, docs, motivos, operas, solicits, valors, fpags, empdopnums, perlimite) " + ;
                                "VALUES (" + ;
                                EscaparSQL(loc_cId) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                                "GETDATE(), " + ;
                                "0, " + ;
                                EscaparSQL(loc_cSenha) + ", " + ;
                                EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                                EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + ", " + ;
                                "0, '', '', '', 0, '', '', 0" + ;
                                ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                                MsgErro("Erro ao gravar senha " + ALLTRIM(loc_cSenha) + ".", "Erro")
                                loc_lErroSQL = .T.
                            ELSE
                                IF EMPTY(loc_cChaves)
                                    loc_cChaves = "'" + loc_cId + "'"
                                ELSE
                                    loc_cChaves = loc_cChaves + ",'" + loc_cId + "'"
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDFOR
                    IF loc_lErroSQL
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        loc_lTransacao = .F.
                    ELSE
                        SQLEXEC(gnConnHandle, "COMMIT")
                        loc_lTransacao = .F.
                        *-- Recarrega cursor com as senhas recem geradas
                        IF USED("crSigPrSnd")
                            USE IN crSigPrSnd
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigPrSnd WHERE cidchaves IN (" + loc_cChaves + ")"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrSnd") > 0
                            SELECT crSigPrSnd
                            GO TOP
                        ENDIF
                        MsgInfo("Favor anotar as senhas geradas.", "Senhas Livres")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SenhaExisteSQL - Verifica se senha ja existe em SigPrSnd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SenhaExisteSQL(par_cSenha)
        LOCAL loc_lExiste, loc_cSQL, loc_nCount
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrSnd WHERE SenhaDs = " + ;
                EscaparSQL(par_cSenha)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SenhaCheck") > 0
                IF USED("cursor_4c_SenhaCheck")
                    loc_nCount  = cursor_4c_SenhaCheck.nExiste
                    loc_lExiste = NVL(loc_nCount, 0) > 0
                    USE IN cursor_4c_SenhaCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarSenhaAleatoria - Gera numero aleatorio de 6 digitos (100000-999999)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarSenhaAleatoria()
        RETURN INT(RAND() * 900000) + 100000
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera identificador unico de 20 caracteres para cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarIdUnico()
        LOCAL loc_cId
        loc_cId = SYS(2015) + SYS(2015)
        RETURN LEFT(loc_cId, 20)
    ENDFUNC

ENDDEFINE

