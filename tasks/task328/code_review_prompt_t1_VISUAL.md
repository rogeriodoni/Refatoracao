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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrScn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (470 linhas total):

*-- Linhas 39 a 47:
39:         TRY
40:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrScnBO")
41: 
42:             THIS.Caption = "Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema"
43: 
44:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
45:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
46:             ENDIF
47: 

*-- Linhas 83 a 146:
83:     PROTECTED PROCEDURE ConfigurarCabecalho()
84:     *==========================================================================
85:         LOCAL loc_cTitulo
86:         loc_cTitulo = "Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema"
87: 
88:         THIS.AddObject("cnt_4c_Sombra", "Container")
89: 
90:         WITH THIS.cnt_4c_Sombra
91:             .Top         = 0
92:             .Left        = 0
93:             .Width       = THIS.Width
94:             .Height      = 80
95:             .BackStyle   = 1
96:             .BackColor   = RGB(100, 100, 100)
97:             .BorderWidth = 0
98:             .Visible     = .T.
99:         ENDWITH
100: 
101:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
102:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
103:             .AutoSize  = .F.
104:             .FontBold  = .T.
105:             .FontName  = "Tahoma"
106:             .FontSize  = 18
107:             .WordWrap  = .T.
108:             .Alignment = 0
109:             .BackStyle = 0
110:             .Caption   = loc_cTitulo
111:             .Height    = 40
112:             .Left      = 10
113:             .Top       = 18
114:             .Width     = THIS.cnt_4c_Sombra.Width - 20
115:             .ForeColor = RGB(0, 0, 0)
116:         ENDWITH
117: 
118:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
119:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
120:             .AutoSize  = .F.
121:             .FontBold  = .T.
122:             .FontName  = "Tahoma"
123:             .FontSize  = 18
124:             .WordWrap  = .T.
125:             .Alignment = 0
126:             .BackStyle = 0
127:             .Caption   = loc_cTitulo
128:             .Height    = 46
129:             .Left      = 10
130:             .Top       = 17
131:             .Width     = THIS.cnt_4c_Sombra.Width - 20
132:             .ForeColor = RGB(255, 255, 255)
133:         ENDWITH
134:     ENDPROC
135: 
136:     *==========================================================================
137:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
138:     *==========================================================================
139:         LOCAL loc_i, loc_oControl
140: 
141:         FOR loc_i = 1 TO par_oContainer.ControlCount
142:             loc_oControl = par_oContainer.Controls(loc_i)
143: 
144:             IF VARTYPE(loc_oControl) = "O"
145:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
146:                     loc_oControl.Visible = .T.

*-- Linhas 180 a 214:
180:     PROTECTED PROCEDURE ConfigurarCamposLogin()
181:     *==========================================================================
182:         *-- Label "Usu" + CHR(225) + "rio :"
183:         THIS.AddObject("lbl_4c_Label1", "Label")
184:         WITH THIS.lbl_4c_Label1
185:             .AutoSize  = .T.
186:             .FontBold  = .T.
187:             .FontName  = "Tahoma"
188:             .FontSize  = 12
189:             .BackStyle = 0
190:             .Caption   = "Usu" + CHR(225) + "rio :"
191:             .Height    = 21
192:             .Left      = 78
193:             .Top       = 91
194:             .Width     = 75
195:             .ForeColor = RGB(90, 90, 90)
196:         ENDWITH
197: 
198:         *-- Label "Senha :"
199:         THIS.AddObject("lbl_4c_Label2", "Label")
200:         WITH THIS.lbl_4c_Label2
201:             .AutoSize  = .T.
202:             .FontBold  = .T.
203:             .FontName  = "Tahoma"
204:             .FontSize  = 12
205:             .BackStyle = 0
206:             .Caption   = "Senha :"
207:             .Height    = 21
208:             .Left      = 90
209:             .Top       = 126
210:             .Width     = 63
211:             .ForeColor = RGB(90, 90, 90)
212:         ENDWITH
213: 
214:         *-- TextBox Usu" + CHR(225) + "rio

*-- Linhas 221 a 233:
221:             .Format         = "K"
222:             .Height         = 30
223:             .InputMask      = "!!!!!!!!!!"
224:             .Left           = 160
225:             .SelectOnEntry  = .F.
226:             .SpecialEffect  = 1
227:             .TabIndex       = 2
228:             .Top            = 86
229:             .Width          = 136
230:             .BackColor      = RGB(255, 255, 255)
231:             .Value          = ""
232:         ENDWITH
233: 

*-- Linhas 241 a 253:
241:             .Format         = "K"
242:             .Height         = 30
243:             .InputMask      = "!!!!!!!!!!"
244:             .Left           = 160
245:             .PasswordChar   = "*"
246:             .SpecialEffect  = 1
247:             .TabIndex       = 3
248:             .Top            = 121
249:             .Width          = 136
250:             .BackColor      = RGB(255, 255, 255)
251:             .Value          = ""
252:         ENDWITH
253:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrScnBO.prg):
*==============================================================================
* SigPrScnBO.prg - Business Object: Libera" + CHR(231) + CHR(227) + "o de Acesso ao Sistema
* Herda de: BusinessBase
* Tabela: SigCdUsu
*==============================================================================

DEFINE CLASS SigPrScnBO AS BusinessBase

    *-- Usuario digitado para autenticacao
    this_cUsuario    = ""
    *-- Senha digitada (texto plano para comparacao com hash do BD)
    this_cSenha      = ""
    *-- Hash da senha recuperado do banco (SigCdUsu.senhas)
    this_cSenhasDB   = ""
    *-- Resultado da autenticacao
    this_lAutenticado = .F.
    *-- Estado da barra de atalhos antes de abrir o form (para restaurar)
    this_lTbVisivel  = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = "SigCdUsu"
        THIS.this_cCampoChave = "usuarios"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ALLTRIM(THIS.this_cUsuario)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuario  = TratarNulo(usuarios, "C")
            THIS.this_cSenhasDB = TratarNulo(senhas, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCredenciais - Autentica usuario/senha contra SigCdUsu
    * Retorna .T. se credenciais validas, .F. caso contrario
    * Em caso de erro preenche this_cMensagemErro
    *--------------------------------------------------------------------------
    FUNCTION ValidarCredenciais()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuarioPad, loc_cSenhaPad
        loc_lSucesso = .F.

        TRY
            loc_cUsuarioPad = PADR(ALLTRIM(THIS.this_cUsuario), 10)
            loc_cSenhaPad   = PADR(ALLTRIM(THIS.this_cSenha), 10)

            IF EMPTY(ALLTRIM(loc_cUsuarioPad))
                THIS.this_cMensagemErro = "Informe o usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT a.usuarios, a.senhas " + ;
                       "FROM SigCdUsu a " + ;
                       "WHERE NOT a.cAtivos = 'N' " + ;
                       "AND a.usuarios = '" + ALLTRIM(loc_cUsuarioPad) + "' " + ;
                       "ORDER BY 1"

            IF USED("cursor_4c_ScnUsu")
                USE IN cursor_4c_ScnUsu
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ScnUsu")

            IF !USED("cursor_4c_ScnUsu")
                THIS.this_cMensagemErro = "Erro ao consultar usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_ScnUsu

            IF EOF() OR EMPTY(ALLTRIM(loc_cUsuarioPad))
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos."
                loc_lSucesso = .F.
            ENDIF

            IF loc_cSenhaPad <> fCriptografar(cursor_4c_ScnUsu.senhas)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos."
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cSenhasDB    = TratarNulo(cursor_4c_ScnUsu.senhas, "C")
            THIS.this_lAutenticado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_ScnUsu")
            USE IN cursor_4c_ScnUsu
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de timeout de SigCdPam
    * Chamado quando SetFiscal.Ini nao existe
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nTmpChks, nTmpApps FROM SigCdPam"

            IF USED("cursor_4c_ScnParam")
                USE IN cursor_4c_ScnParam
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ScnParam")

            IF USED("cursor_4c_ScnParam")
                SELECT cursor_4c_ScnParam
                GOTO TOP
                IF !EOF()
                    fTempoApp(cursor_4c_ScnParam.nTmpChks, cursor_4c_ScnParam.nTmpApps)
                ENDIF
                USE IN cursor_4c_ScnParam
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLog - Registra acesso ao sistema via fGravarLog legado
    *--------------------------------------------------------------------------
    FUNCTION GravarLog(par_cEvento, par_cNomeForm, par_cUsuario, par_cCaption)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            fGravarLog(par_cEvento, par_cNomeForm, par_cUsuario, par_cCaption)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Registra evento de acesso autenticado do usuario
    * Contexto SIGPRSCN (Liberacao de Acesso): "insercao" = gravar registro
    * de acesso no LogAuditoria + atualizar data ultimo acesso em SigCdUsu.
    * Chamado apos ValidarCredenciais() retornar .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_nRet
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF EMPTY(loc_cUsuario)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            IF !THIS.this_lAutenticado
                THIS.this_cMensagemErro = "Credenciais n" + CHR(227) + "o validadas."
                loc_lSucesso = .F.
            ENDIF

            *-- Grava data/hora do acesso na coluna tdtsenhas do usuario
            loc_cSQL = "UPDATE SigCdUsu " + ;
                       "SET tdtsenhas = GETDATE() " + ;
                       "WHERE usuarios = " + EscaparSQL(loc_cUsuario)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Erro ao registrar hor" + CHR(225) + "rio de acesso."
                loc_lSucesso = .F.
            ENDIF

            *-- Registra no LogAuditoria via BusinessBase
            THIS.RegistrarAuditoria("ACESSO")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza dados do usuario autenticado
    * Contexto SIGPRSCN: sincroniza flag obrigsenhas / cativos apos login
    * bem-sucedido. Preserva o hash de senha (senhas) intocado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_nRet
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF EMPTY(loc_cUsuario)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            *-- Atualiza tdtsenhas (data ultima autenticacao)
            loc_cSQL = "UPDATE SigCdUsu " + ;
                       "SET tdtsenhas = GETDATE() " + ;
                       "WHERE usuarios = " + EscaparSQL(loc_cUsuario) + " " + ;
                       "AND NOT cAtivos = 'N'"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Erro ao atualizar dados do usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            *-- Registra alteracao no LogAuditoria
            THIS.RegistrarAuditoria("ATUALIZAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Desativa usuario (soft-delete via cAtivos='N')
    * NAO executa DELETE fisico - SIGPRSCN nunca remove usuario da base.
    * Marca cAtivos='N' para bloquear acessos futuros.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_nRet
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ALLTRIM(THIS.this_cUsuario)

            IF EMPTY(loc_cUsuario)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o informado."
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCdUsu " + ;
                       "SET cAtivos = 'N' " + ;
                       "WHERE usuarios = " + EscaparSQL(loc_cUsuario)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Erro ao desativar usu" + CHR(225) + "rio."
                loc_lSucesso = .F.
            ENDIF

            THIS.RegistrarAuditoria("EXCLUIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

