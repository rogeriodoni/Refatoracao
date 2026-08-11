# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 247: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 265: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICD.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (690 linhas total):

*-- Linhas 27 a 35:
27:     * Init - define Caption com CHR() antes de delegar ao FormBase
28:     *--------------------------------------------------------------------------
29:     PROCEDURE Init()
30:         THIS.Caption = "Duplica" + CHR(231) + CHR(227) + "o dos Tipo de Tributa" + CHR(231) + CHR(227) + "o"
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *--------------------------------------------------------------------------
35:     * InicializarForm - monta estrutura base do form operacional

*-- Linhas 88 a 272:
88:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
89:         loc_oCab = THIS.cnt_4c_Cabecalho
90:         WITH loc_oCab
91:             .Top         = 0
92:             .Left        = 0
93:             .Width       = THIS.Width
94:             .Height      = 80
95:             .BackColor   = RGB(100,100,100)
96:             .BackStyle   = 1
97:             .BorderWidth = 0
98:         ENDWITH
99: 
100:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
101:         WITH loc_oCab.lbl_4c_Sombra
102:             .AutoSize      = .F.
103:             .Width         = loc_oCab.Width - 10
104:             .Height        = 40
105:             .Top           = 18
106:             .Left          = 10
107:             .FontName      = "Tahoma"
108:             .FontSize      = 18
109:             .FontBold      = .T.
110:             .FontUnderline = .F.
111:             .Alignment     = 0
112:             .BackStyle     = 0
113:             .WordWrap      = .T.
114:             .ForeColor     = RGB(0,0,0)
115:             .Caption       = THIS.Caption
116:         ENDWITH
117: 
118:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
119:         WITH loc_oCab.lbl_4c_Titulo
120:             .AutoSize      = .F.
121:             .Width         = loc_oCab.Width - 10
122:             .Height        = 46
123:             .Top           = 17
124:             .Left          = 10
125:             .FontName      = "Tahoma"
126:             .FontSize      = 18
127:             .FontBold      = .T.
128:             .Alignment     = 0
129:             .BackStyle     = 0
130:             .WordWrap      = .T.
131:             .ForeColor     = RGB(255,255,255)
132:             .Caption       = THIS.Caption
133:         ENDWITH
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * ConfigurarCampos - cria container branco dos campos de entrada
138:     *--------------------------------------------------------------------------
139:     PROTECTED PROCEDURE ConfigurarCampos()
140:         LOCAL loc_oCnt
141: 
142:         *-- Shape decorativo ao redor do container (top=79, left=103, w=173, h=110)
143:         THIS.AddObject("shp_4c_Borda", "Shape")
144:         WITH THIS.shp_4c_Borda
145:             .Top           = 79
146:             .Left          = 103
147:             .Height        = 110
148:             .Width         = 173
149:             .BackStyle     = 0
150:             .BorderStyle   = 0
151:             .SpecialEffect = 1
152:             .BorderColor   = RGB(136,189,188)
153:         ENDWITH
154: 
155:         *-- Container principal dos campos (Tipo: e Novo:)
156:         THIS.AddObject("cnt_4c_Container1", "Container")
157:         loc_oCnt = THIS.cnt_4c_Container1
158:         WITH loc_oCnt
159:             .Top           = 132
160:             .Left          = 84
161:             .Width         = 279
162:             .Height        = 59
163:             .SpecialEffect = 0
164:             .BackColor     = RGB(255,255,255)
165:             .BackStyle     = 1
166:             .BorderWidth   = 0
167:         ENDWITH
168: 
169:         *-- Labels "Tipo :" e "Novo :"
170:         loc_oCnt.AddObject("lbl_4c_RotTipo", "Label")
171:         WITH loc_oCnt.lbl_4c_RotTipo
172:             .Caption  = "Tipo :"
173:             .Left     = 9
174:             .Top      = 8
175:             .AutoSize = .T.
176:             .TabIndex = 5
177:         ENDWITH
178: 
179:         loc_oCnt.AddObject("lbl_4c_RotNovo", "Label")
180:         WITH loc_oCnt.lbl_4c_RotNovo
181:             .Caption  = "Novo :"
182:             .Left     = 6
183:             .Top      = 34
184:             .AutoSize = .T.
185:             .TabIndex = 6
186:         ENDWITH
187: 
188:         *-- TextBoxes: linha 1 = tipo existente (Tipo + Desc)
189:         loc_oCnt.AddObject("txt_4c_Tipo", "TextBox")
190:         WITH loc_oCnt.txt_4c_Tipo
191:             .Value     = ""
192:             .MaxLength = 4
193:             .Height    = 23
194:             .Width     = 40
195:             .Left      = 46
196:             .Top       = 4
197:             .TabIndex  = 1
198:         ENDWITH
199: 
200:         loc_oCnt.AddObject("txt_4c_Desc", "TextBox")
201:         WITH loc_oCnt.txt_4c_Desc
202:             .Value     = ""
203:             .MaxLength = 20
204:             .Height    = 23
205:             .Width     = 184
206:             .Left      = 90
207:             .Top       = 4
208:             .TabIndex  = 2
209:         ENDWITH
210: 
211:         *-- TextBoxes: linha 2 = novo tipo (NovoTipo + NovaDesc)
212:         loc_oCnt.AddObject("txt_4c_NovoTipo", "TextBox")
213:         WITH loc_oCnt.txt_4c_NovoTipo
214:             .Value     = ""
215:             .MaxLength = 4
216:             .Height    = 23
217:             .Width     = 40
218:             .Left      = 46
219:             .Top       = 30
220:             .TabIndex  = 3
221:         ENDWITH
222: 
223:         loc_oCnt.AddObject("txt_4c_NovaDesc", "TextBox")
224:         WITH loc_oCnt.txt_4c_NovaDesc
225:             .Value     = ""
226:             .MaxLength = 20
227:             .Height    = 23
228:             .Width     = 184
229:             .Left      = 90
230:             .Top       = 30
231:             .TabIndex  = 4
232:         ENDWITH
233:     ENDPROC
234: 
235:     *--------------------------------------------------------------------------
236:     * ConfigurarBotoes - cria botoes Duplicar e Encerrar
237:     *--------------------------------------------------------------------------
238:     PROTECTED PROCEDURE ConfigurarBotoes()
239:         THIS.AddObject("cmd_4c_Duplicar", "CommandButton")
240:         WITH THIS.cmd_4c_Duplicar
241:             .Top             = 2
242:             .Left            = 294
243:             .Height          = 75
244:             .Width           = 75
245:             .FontBold        = .T.
246:             .FontItalic      = .T.
247:             .FontName        = "Comic Sans MS"
248:             .FontSize        = 8
249:             .Caption         = "Duplicar"
250:             .ForeColor       = RGB(90,90,90)
251:             .BackColor       = RGB(255,255,255)
252:             .Themes          = .T.
253:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_26.jpg"
254:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_26.jpg"
255:         ENDWITH
256: 
257:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
258:         WITH THIS.cmd_4c_Encerrar
259:             .Top             = 2
260:             .Left            = 367
261:             .Height          = 75
262:             .Width           = 75
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .FontName        = "Comic Sans MS"
266:             .FontSize        = 8
267:             .Caption         = "Encerrar"
268:             .ForeColor       = RGB(90,90,90)
269:             .BackColor       = RGB(255,255,255)
270:             .Themes          = .T.
271:             .Cancel          = .T.
272:             .Picture         = gc_4c_CaminhoIcones + "simbolosl_erro_26.jpg"

*-- Linhas 570 a 579:
570:         BINDEVENT(loc_oCnt.txt_4c_Tipo,  "DblClick", THIS, "TxtTipoDblClick")
571:         BINDEVENT(loc_oCnt.txt_4c_Desc,  "KeyPress", THIS, "TxtDescKeyPress")
572:         BINDEVENT(loc_oCnt.txt_4c_Desc,  "DblClick", THIS, "TxtDescDblClick")
573:         BINDEVENT(THIS.cmd_4c_Duplicar,  "Click",    THIS, "CmdDuplicarClick")
574:         BINDEVENT(THIS.cmd_4c_Encerrar,  "Click",    THIS, "CmdEncerrarClick")
575:     ENDPROC
576: 
577:     *--------------------------------------------------------------------------
578:     * FormParaBO - popula propriedades do BO com valores dos campos do form
579:     *--------------------------------------------------------------------------

*-- Linhas 608 a 616:
608:         loc_oCnt.txt_4c_Desc.Enabled      = par_lHabilitar
609:         loc_oCnt.txt_4c_NovoTipo.Enabled  = par_lHabilitar
610:         loc_oCnt.txt_4c_NovaDesc.Enabled  = par_lHabilitar
611:         THIS.cmd_4c_Duplicar.Enabled      = par_lHabilitar
612:     ENDPROC
613: 
614:     *--------------------------------------------------------------------------
615:     * LimparCampos - limpa todos os campos de entrada
616:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\ICDBO.prg):
*------------------------------------------------------------------------------
* ICDBO.prg - Business Object para Duplicacao de Tipo de Tributacao
* Tabela: SigPrTri
* PK: cIdChaves (char 20)
* Form associado: FormICD.prg (operacionais\)
*------------------------------------------------------------------------------

DEFINE CLASS ICDBO AS BusinessBase

    *-- Tipo de origem (registro a ser duplicado)
    this_cTipos    = ""   && char(4)  - codigo do tipo existente
    this_cDescs    = ""   && char(20) - descricao do tipo existente

    *-- Novo tipo (destino da duplicacao)
    this_cNovoTipos  = ""  && char(4)  - novo codigo do tipo
    this_cNovaDescs  = ""  && char(20) - nova descricao

    *-- Chave primaria do registro carregado (para auditoria)
    this_cCidChaves  = ""  && char(20) - PK cIdChaves

    *-- Demais campos da SigPrTri (copiados integralmente no INSERT)
    this_nAliquotas  = 0   && numeric(5,2)
    this_nBases      = 0   && numeric(5,2)
    this_cCfops      = ""  && char(10)
    this_cDestinos   = ""  && char(2)
    this_cMovs       = ""  && char(1)
    this_cOrigems    = ""  && char(2)
    this_nReduzidas  = 0   && numeric(5,2)
    this_nAliqIcmsts = 0   && numeric(5,2) - aliqicmsts (presente no schema, ausente na Fase 1)

    *-- Cursor principal
    this_cCursorDados = "cnSigPrTri"

    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrTri"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna valor da chave primaria (requerido por BusinessBase)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cIdChaves,  "C")
            THIS.this_cTipos       = TratarNulo(Tipos,      "C")
            THIS.this_cDescs       = TratarNulo(Descs,      "C")
            THIS.this_nAliquotas   = TratarNulo(Aliquotas,  "N")
            THIS.this_nBases       = TratarNulo(Bases,      "N")
            THIS.this_cCfops       = TratarNulo(Cfops,      "C")
            THIS.this_cDestinos    = TratarNulo(Destinos,   "C")
            THIS.this_cMovs        = TratarNulo(Movs,       "C")
            THIS.this_cOrigems     = TratarNulo(Origems,    "C")
            THIS.this_nReduzidas   = TratarNulo(Reduzidas,  "N")
            THIS.this_nAliqIcmsts  = TratarNulo(Aliqicmsts, "N")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - carrega cursor cnSigPrTri com todos os tipos de tributacao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cnSigPrTri")
                TABLEREVERT(.T., "cnSigPrTri")
                USE IN cnSigPrTri
            ENDIF
            loc_cSQL = "SELECT cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts " + ;
                       "FROM SigPrTri "
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + "WHERE " + par_cFiltro + " "
            ENDIF
            loc_cSQL = loc_cSQL + "ORDER BY tipos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cnSigPrTri") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), ;
                        "Erro ao buscar tipos de tributa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorTipo - carrega cursor cnSigPrTri filtrado por codigo de tipo
    *               e popula propriedades do BO com os dados encontrados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorTipo(par_cTipos)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cnSigPrTri")
                TABLEREVERT(.T., "cnSigPrTri")
                USE IN cnSigPrTri
            ENDIF
            loc_cSQL = "SELECT cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts " + ;
                       "FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(ALLTRIM(par_cTipos))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cnSigPrTri") > 0
                SELECT cnSigPrTri
                IF !EOF()
                    THIS.CarregarDoCursor("cnSigPrTri")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao buscar tipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BuscarPorTipo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTipoExistente - retorna .T. se o tipo ja existe na SigPrTri
    *--------------------------------------------------------------------------
    FUNCTION VerificarTipoExistente(par_cTipos)
        LOCAL loc_cSQL, loc_lExiste, loc_oErro
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(ALLTRIM(par_cTipos))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheckTipo") > 0
                SELECT cursor_4c_CheckTipo
                loc_lExiste = (NVL(nExiste, 0) > 0)
                USE IN cursor_4c_CheckTipo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em VerificarTipoExistente")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * DuplicarTipo - duplica registro SigPrTri com novo codigo e descricao
    *               Logica original (Command1.Click): Requery cnSigPrTri com
    *               o tipo de origem, REPLACE ALL com novos valores + UpDate
    *               Equivalente novo: SELECT origem, INSERT com novos tipos/descs/cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION DuplicarTipo(par_cTipoOrigem, par_cNovoTipo, par_cNovaDesc)
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaChave, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Validar parametros de entrada
            IF EMPTY(ALLTRIM(par_cTipoOrigem))
                MsgAviso("Informe o Tipo de origem para duplicar.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cNovoTipo))
                MsgAviso("Informe o novo c" + CHR(243) + "digo do Tipo.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            *-- Verificar se novo tipo ja existe (equivalente ao SELECT csSigPrTri + EOF check original)
            IF THIS.VerificarTipoExistente(par_cNovoTipo)
                MsgAviso("Novo Tipo J" + CHR(225) + " Cadastrado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            *-- Carregar dados completos do tipo de origem (equivalente ao Requery original)
            IF !THIS.BuscarPorTipo(par_cTipoOrigem)
                MsgAviso("Tipo de origem n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cTipoOrigem), "Aviso")
                loc_lSucesso = .F.
            ENDIF
            *-- Gerar nova chave primaria unica (equivalente ao fUniqueIds() do REPLACE ALL)
            loc_cNovaChave = LEFT(fUniqueIds(), 20)
            *-- INSERT do novo registro copiando todos os campos + novos tipos/descs/cIdChaves
            loc_cSQL = "INSERT INTO SigPrTri " + ;
                       "(cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts) " + ;
                       "VALUES (" + ;
                       EscaparSQL(loc_cNovaChave) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(par_cNovoTipo), 4)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(par_cNovaDesc), 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                       EscaparSQL(THIS.this_cCfops) + ", " + ;
                       EscaparSQL(THIS.this_cDestinos) + ", " + ;
                       EscaparSQL(THIS.this_cMovs) + ", " + ;
                       EscaparSQL(THIS.this_cOrigems) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + ;
                       ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.this_cCidChaves = loc_cNovaChave
                THIS.this_cNovoTipos = LEFT(ALLTRIM(par_cNovoTipo), 4)
                THIS.this_cNovaDescs = LEFT(ALLTRIM(par_cNovaDesc), 20)
                THIS.RegistrarAuditoria("DUPLICAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao duplicar tipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em DuplicarTipo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTri com todos os campos populados nas
    *          propriedades this_*. Gera cIdChaves via fUniqueIds se vazio.
    *          Verifica duplicidade de Tipos antes do INSERT.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaChave, loc_cTipoDestino, loc_cDescDestino, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cTipoDestino = ALLTRIM(THIS.this_cNovoTipos)
            IF EMPTY(loc_cTipoDestino)
                loc_cTipoDestino = ALLTRIM(THIS.this_cTipos)
            ENDIF
            loc_cDescDestino = ALLTRIM(THIS.this_cNovaDescs)
            IF EMPTY(loc_cDescDestino)
                loc_cDescDestino = ALLTRIM(THIS.this_cDescs)
            ENDIF
            IF EMPTY(loc_cTipoDestino)
                MsgAviso("Informe o c" + CHR(243) + "digo do Tipo.", "Aviso")
            ELSE
                IF THIS.VerificarTipoExistente(loc_cTipoDestino)
                    MsgAviso("Tipo J" + CHR(225) + " Cadastrado: " + loc_cTipoDestino, "Aviso")
                ELSE
                    loc_cNovaChave = ALLTRIM(THIS.this_cCidChaves)
                    IF EMPTY(loc_cNovaChave)
                        loc_cNovaChave = LEFT(fUniqueIds(), 20)
                    ENDIF
                    loc_cSQL = "INSERT INTO SigPrTri " + ;
                               "(cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                               "destinos, movs, origems, reduzidas, aliqicmsts) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cNovaChave) + ", " + ;
                               EscaparSQL(LEFT(loc_cTipoDestino, 4)) + ", " + ;
                               EscaparSQL(LEFT(loc_cDescDestino, 20)) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                               EscaparSQL(THIS.this_cCfops) + ", " + ;
                               EscaparSQL(THIS.this_cDestinos) + ", " + ;
                               EscaparSQL(THIS.this_cMovs) + ", " + ;
                               EscaparSQL(THIS.this_cOrigems) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + ;
                               ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.this_cCidChaves = loc_cNovaChave
                        THIS.this_cTipos     = LEFT(loc_cTipoDestino, 4)
                        THIS.this_cDescs     = LEFT(loc_cDescDestino, 20)
                        THIS.RegistrarAuditoria("INCLUSAO")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao inserir tipo de tributa" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTri para o registro identificado por
    *            this_cCidChaves (PK). Usado quando o BO precisa persistir
    *            alteracoes em um registro previamente carregado.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro carregado para atualizar.", "Aviso")
            ELSE
                loc_cSQL = "UPDATE SigPrTri SET " + ;
                           "tipos = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipos), 4)) + ", " + ;
                           "descs = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 20)) + ", " + ;
                           "aliquotas = "  + FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                           "bases = "      + FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                           "cfops = "      + EscaparSQL(THIS.this_cCfops) + ", " + ;
                           "destinos = "   + EscaparSQL(THIS.this_cDestinos) + ", " + ;
                           "movs = "       + EscaparSQL(THIS.this_cMovs) + ", " + ;
                           "origems = "    + EscaparSQL(THIS.this_cOrigems) + ", " + ;
                           "reduzidas = "  + FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                           "aliqicmsts = " + FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("ALTERACAO")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao atualizar tipo de tributa" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

