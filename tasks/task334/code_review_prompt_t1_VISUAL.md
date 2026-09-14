# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRSTF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (502 linhas total):

*-- Linhas 102 a 172:
102:     * ConfigurarCabecalho - Cria container de cabecalho cinza (cntSombra)
103:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarCabecalho()
106:         *-- Container cinza do cabecalho
107:         THIS.AddObject("cnt_4c_Sombra", "Container")
108:         WITH THIS.cnt_4c_Sombra
109:             .Top         = 0
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BorderWidth = 0
114:             .BackStyle   = 1
115:             .BackColor   = RGB(100,100,100)
116:             .Visible     = .T.
117:         ENDWITH
118: 
119:         *-- Label sombra (deslocado 1px para efeito de profundidade - preto)
120:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
121:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
122:             .AutoSize   = .F.
123:             .FontBold   = .T.
124:             .FontName   = "Tahoma"
125:             .FontSize   = 18
126:             .WordWrap   = .T.
127:             .Alignment  = 0
128:             .BackStyle  = 0
129:             .Caption    = "Senha de Risco"
130:             .Height     = 40
131:             .Left       = 10
132:             .Top        = 18
133:             .Width      = THIS.Width
134:             .ForeColor  = RGB(0,0,0)
135:             .Visible    = .T.
136:         ENDWITH
137: 
138:         *-- Label titulo principal (branco sobre cinza)
139:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
140:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
141:             .AutoSize   = .F.
142:             .FontBold   = .T.
143:             .FontName   = "Tahoma"
144:             .FontSize   = 18
145:             .WordWrap   = .T.
146:             .Alignment  = 0
147:             .BackStyle  = 0
148:             .Caption    = "Senha de Risco"
149:             .Height     = 46
150:             .Left       = 10
151:             .Top        = 17
152:             .Width      = THIS.Width
153:             .ForeColor  = RGB(255,255,255)
154:             .Visible    = .T.
155:         ENDWITH
156: 
157:         THIS.cnt_4c_Sombra.Visible = .T.
158:     ENDPROC
159: 
160:     *--------------------------------------------------------------------------
161:     * AtualizarEstadoControles - override seguro (dialogo sem botoes CRUD)
162:     *--------------------------------------------------------------------------
163:     PROCEDURE AtualizarEstadoControles()
164:         RETURN
165:     ENDPROC
166: 
167:     *--------------------------------------------------------------------------
168:     * Handlers CRUD - Nao aplicavel a este form
169:     * ------------------------------------------------------------------------
170:     * SigTfSup (legado) eh dialogo modal de senha de supervisor: nao tem
171:     * grid de registros, nao tem Page Lista/Dados, nao expoe botoes Incluir/
172:     * Alterar/Visualizar/Excluir. O usuario digita senha + Enter (confirma) ou

*-- Linhas 208 a 243:
208:     *--------------------------------------------------------------------------
209:     * ConfigurarPaginaDados - Area de instrucao ao usuario (Container1 do legado)
210:     * Container1 exibe orientacao dinamica definida em Init() original:
211:     *   ThisForm.Container1.Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarPaginaDados()
214:         *-- Container instrucao ao usuario (Container1 do legado)
215:         THIS.AddObject("cnt_4c_Container1", "Container")
216:         WITH THIS.cnt_4c_Container1
217:             .Top           = 137
218:             .Left          = 114
219:             .Width         = 171
220:             .Height        = 56
221:             .SpecialEffect = 0
222:             .BackStyle     = 1
223:             .BackColor     = RGB(212,208,200)
224:             .BorderWidth   = 0
225:             .Visible     = .T.
226:         ENDWITH
227: 
228:         THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
229:         WITH THIS.cnt_4c_Container1.lbl_4c_Label1
230:             .AutoSize  = .F.
231:             .FontBold  = .T.
232:             .FontName  = "Trebuchet MS"
233:             .FontSize  = 10
234:             .Alignment = 2
235:             .Caption   = "Digite a Senha" + CHR(13) + "do Supervisor"
236:             .Height    = 30
237:             .Left      = 7
238:             .Top       = 16
239:             .Width     = 157
240:             .BackStyle = 0
241:             .ForeColor = RGB(90,90,90)
242:             .WordWrap  = .T.
243:         ENDWITH

*-- Linhas 268 a 307:
268:         *-- Shape retangulo borda da area de senha (Shape1 do legado)
269:         THIS.AddObject("shp_4c_Shape1", "Shape")
270:         WITH THIS.shp_4c_Shape1
271:             .Top           = 90
272:             .Left          = 76
273:             .Height        = 42
274:             .Width         = 247
275:             .SpecialEffect = 0
276:         ENDWITH
277: 
278:         *-- Label "Senha do Supervisor :" (Label3 do legado)
279:         THIS.AddObject("lbl_4c_Label3", "Label")
280:         WITH THIS.lbl_4c_Label3
281:             .AutoSize  = .T.
282:             .FontName  = "Tahoma"
283:             .FontSize  = 8
284:             .Alignment = 0
285:             .Caption   = "Senha do Supervisor :"
286:             .Height    = 15
287:             .Left      = 87
288:             .Top       = 104
289:             .Width     = 108
290:             .BackStyle = 0
291:             .ForeColor = RGB(90,90,90)
292:         ENDWITH
293: 
294:         *-- TextBox GetSenha desabilitado (leitura de cartao - GetSenha do legado)
295:         THIS.AddObject("txt_4c_GetSenha", "TextBox")
296:         WITH THIS.txt_4c_GetSenha
297:             .FontName  = "Tahoma"
298:             .FontSize  = 8
299:             .Enabled   = .F.
300:             .Height    = 23
301:             .Left      = 214
302:             .Top       = 99
303:             .Width     = 100
304:             .ForeColor = RGB(0,0,0)
305:             .Value     = ""
306:         ENDWITH
307: 

*-- Linhas 315 a 324:
315:             .BackColor    = RGB(255,255,255)
316:             .ForeColor    = RGB(0,0,0)
317:             .Height       = 23
318:             .Left         = 214
319:             .Top          = 99
320:             .Width        = 100
321:             .PasswordChar = "*"
322:             .TabIndex     = 1
323:             .Value        = ""
324:         ENDWITH

*-- Linhas 336 a 355:
336:             .BorderStyle = 0
337:             .Value       = 0
338:             .Height      = 85
339:             .Left        = 320
340:             .Top         = -2
341:             .Width       = 85
342:             .TabIndex    = 4
343:             WITH .Buttons(1)
344:                 .Top             = 5
345:                 .Left            = 5
346:                 .Height          = 75
347:                 .Width           = 75
348:                 .FontBold        = .T.
349:                 .FontItalic      = .F.
350:                 .Caption         = "\<Cancelar"
351:                 .ForeColor       = RGB(90,90,90)
352:                 .BackColor       = RGB(255,255,255)
353:                 .Themes          = .F.
354:                 .SpecialEffect   = 0
355:                 .PicturePosition = 13


### BO (C:\4c\projeto\app\classes\SIGPRSTFBO.prg):
*==============================================================================
* SIGPRSTFBO.prg - Business Object para dialogo Senha de Risco
* Herda de: BusinessBase
* Responsabilidade: Encapsular estado do dialogo de senha de supervisor
*==============================================================================

DEFINE CLASS SIGPRSTFBO AS BusinessBase

    *-- Senha digitada pelo usuario
    this_cSenha     = ""

    *-- Indica se o usuario cancelou (F. = confirmou, T. = cancelou)
    this_lCancelado = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - nao aplica (dialogo sem tabela SQL)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSenha     = TratarNulo(cSenha, "C")
            THIS.this_lCancelado = .F.
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - verifica que a senha nao esta vazia
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cSenha))
            THIS.this_cMensagemErro = "A senha do supervisor n" + CHR(227) + "o pode estar em branco."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - nao aplica (dialogo sem tabela SQL); retorna .T. por interface
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        THIS.RegistrarAuditoria("SENHA_RISCO")
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - nao aplica (dialogo sem tabela SQL); retorna .T. por interface
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        IF !THIS.ValidarDados()
            RETURN .F.
        ENDIF
        THIS.RegistrarAuditoria("SENHA_RISCO_ALT")
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra acesso ao dialogo de senha de risco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .T.

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, Usuario, DataHora) VALUES (" + ;
                       EscaparSQL("SIGPRSTF") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
            loc_lSucesso = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

