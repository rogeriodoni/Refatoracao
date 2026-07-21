# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 173: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrTar.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (708 linhas total):

*-- Linhas 64 a 72:
64:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrTarBO")
65: 
66:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
67:                 THIS.Caption = "Inspira" + CHR(231) + CHR(227) + "o da Tarefa"
68:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
69: 
70:                 THIS.ConfigurarPageFrame()
71:                 THIS.ConfigurarEncerrar()
72:                 THIS.ConfigurarPaginaDados()

*-- Linhas 102 a 223:
102: 
103:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH THIS.cnt_4c_Cabecalho
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = loc_nLargura
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112: 
113:             .AddObject("lbl_4c_Sombra", "Label")
114:             .AddObject("lbl_4c_Titulo", "Label")
115:             .Visible     = .T.
116:         ENDWITH
117: 
118:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
119:             .AutoSize  = .F.
120:             .Width     = loc_nLargura
121:             .Height    = 40
122:             .Top       = 18
123:             .Left      = 10
124:             .FontName  = "Tahoma"
125:             .FontSize  = 18
126:             .FontBold  = .T.
127:             .BackStyle = 0
128:             .ForeColor = RGB(0, 0, 0)
129:             .WordWrap  = .T.
130:             .Caption   = loc_cCaption
131:         ENDWITH
132: 
133:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
134:             .AutoSize  = .F.
135:             .Width     = loc_nLargura
136:             .Height    = 46
137:             .Top       = 17
138:             .Left      = 10
139:             .FontName  = "Tahoma"
140:             .FontSize  = 18
141:             .FontBold  = .T.
142:             .BackStyle = 0
143:             .ForeColor = RGB(255, 255, 255)
144:             .WordWrap  = .T.
145:             .Caption   = loc_cCaption
146:         ENDWITH
147:     ENDPROC
148: 
149:     *--------------------------------------------------------------------------
150:     * ConfigurarEncerrar - Shape decorativo e botao Encerrar
151:     *--------------------------------------------------------------------------
152:     PROTECTED PROCEDURE ConfigurarEncerrar()
153:         THIS.AddObject("shp_4c_Shape1", "Shape")
154:         WITH THIS.shp_4c_Shape1
155:             .Top         = 31
156:             .Left        = 486
157:             .Height      = 53
158:             .Width       = 66
159:             .BackStyle   = 0
160:             .BorderStyle = 0
161:             .BorderColor = RGB(136, 189, 188)
162:         ENDWITH
163: 
164:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
165:         WITH THIS.cmd_4c_Encerrar
166:             .Top             = 4
167:             .Left            = 510
168:             .Width           = 75
169:             .Height          = 75
170:             .Caption         = "Encerrar"
171:             .Cancel          = .T.
172:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
173:             .FontName        = "Comic Sans MS"
174:             .FontBold        = .T.
175:             .FontItalic      = .T.
176:             .FontSize        = 8
177:             .ForeColor       = RGB(90, 90, 90)
178:             .BackColor       = RGB(255, 255, 255)
179:             .Themes           = .T.
180:             .SpecialEffect   = 0
181:             .PicturePosition = 13
182:             .MousePointer    = 15
183:             .WordWrap        = .T.
184:         ENDWITH
185: 
186:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
187:     ENDPROC
188: 
189:     *--------------------------------------------------------------------------
190:     * ConfigurarPaginaDados - campos principais do sub-form (SIGSERPR)
191:     * Nao ha PageFrame/Page2 neste form modal; o metodo cria os controles de
192:     * dados diretamente sobre o form (label descritivo + EditBox de Inspiracao)
193:     * seguindo a convencao canonica de nomes do pipeline de migracao.
194:     *--------------------------------------------------------------------------
195:     PROTECTED PROCEDURE ConfigurarPaginaDados()
196:         THIS.AddObject("lbl_4c_Label1", "Label")
197:         WITH THIS.lbl_4c_Label1
198:             .AutoSize  = .T.
199:             .FontBold  = .T.
200:             .FontName  = "Tahoma"
201:             .FontSize  = 8
202:             .WordWrap  = .F.
203:             .Alignment = 1
204:             .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
205:             .Height    = 15
206:             .Left      = 12
207:             .Top       = 84
208:             .Width     = 62
209:             .ForeColor = RGB(90, 90, 90)
210:         ENDWITH
211: 
212:         THIS.AddObject("obj_4c_GetObsInsp", "EditBox")
213:         WITH THIS.obj_4c_GetObsInsp
214:             .FontName           = "Tahoma"
215:             .FontSize           = 8
216:             .Height             = 212
217:             .Left               = 12
218:             .Top                = 100
219:             .Width              = 564
220:             .ReadOnly           = .T.
221:             .DisabledBackColor  = RGB(255, 255, 255)
222:             .DisabledForeColor  = RGB(36, 84, 155)
223:         ENDWITH

*-- Linhas 264 a 273:
264:             ENDWITH
265:         ENDIF
266: 
267:         IF PEMSTATUS(THIS, "lbl_4c_Label1", 5)
268:             THIS.lbl_4c_Label1.Caption = "Inspira" + CHR(231) + CHR(227) + "o"
269:         ENDIF
270:     ENDPROC
271: 
272:     *--------------------------------------------------------------------------
273:     * AlternarPagina - alterna entre visualizacao do registro corrente e


### BO (C:\4c\projeto\app\classes\SigPrTarBO.prg):
*------------------------------------------------------------------------------
* SigPrTarBO.prg - Business Object para FormSigPrTar
* Sub-formulario modal de visualizacao de Observacao de Inspecao
* Herda de BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS SigPrTarBO AS BusinessBase

    *-- ObsInsp do cursor csTmpPrTar compartilhado pelo form pai
    this_cObsInsp = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega ObsInsp do cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cObsInsp = TratarNulo(ObsInsp, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do registro visualizado
    * Retorna hash do conteudo ObsInsp (permite auditar visualizacoes)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        IF EMPTY(THIS.this_cObsInsp)
            loc_cChave = "SEM_OBSERVACAO"
        ELSE
            loc_cChave = LEFT(ALLTRIM(THIS.this_cObsInsp), 40)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao suportado (sub-form somente leitura)
    * O EditBox getObsInsp tem ReadOnly=.T. no SCX legado
    * A tabela real eh mantida pelo form pai via cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de visualiza" + CHR(231) + CHR(227) + ;
                                  "o de observa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o suporta inclus" + CHR(227) + "o. As altera" + CHR(231) + ;
                                  CHR(245) + "es s" + CHR(227) + "o feitas no formul" + CHR(225) + "rio principal."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao suportado (sub-form somente leitura)
    * O EditBox getObsInsp tem ReadOnly=.T. no SCX legado
    * A tabela real eh mantida pelo form pai via cursor csTmpPrTar compartilhado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Formul" + CHR(225) + "rio de visualiza" + CHR(231) + CHR(227) + ;
                                  "o de observa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o suporta altera" + CHR(231) + CHR(227) + "o. As altera" + CHR(231) + ;
                                  CHR(245) + "es s" + CHR(227) + "o feitas no formul" + CHR(225) + "rio principal."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra evento de visualizacao de observacao
    * Override do BusinessBase: usa nome logico "SigPrTar" na coluna Tabela
    * (o BO nao tem tabela fisica dedicada; audita a acao do sub-form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_nResultado

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF

        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + ;
                   EscaparSQL("SigPrTar") + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", " + ;
                   "GETDATE())"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        RETURN (loc_nResultado >= 0)
    ENDPROC

ENDDEFINE

