# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 176: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprsen.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (554 linhas total):

*-- Linhas 98 a 182:
98:     * Chamado pelo pipeline para homogeneidade entre forms OPERACIONAIS.
99:     *--------------------------------------------------------------------------
100:     PROCEDURE AlternarPagina(par_nPagina)
101:         IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O" AND ;
102:            VARTYPE(THIS.cmd_4c_Encerrar)   = "O"
103:             THIS.cmd_4c_GerarSenha.Visible = .T.
104:             THIS.cmd_4c_Encerrar.Visible   = .T.
105:             THIS.cmd_4c_GerarSenha.Enabled = !THIS.this_lAutomatico
106:         ENDIF
107:     ENDPROC
108: 
109:     *--------------------------------------------------------------------------
110:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarCabecalho()
113:         LOCAL loc_oCab
114: 
115:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH THIS.cnt_4c_Cabecalho
117:             .Top         = 0
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackStyle   = 1
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126:         loc_oCab = THIS.cnt_4c_Cabecalho
127: 
128:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oCab.lbl_4c_Sombra
130:             .Top       = 18
131:             .Left      = 10
132:             .Width     = loc_oCab.Width - 20
133:             .Height    = 40
134:             .AutoSize  = .F.
135:             .WordWrap  = .T.
136:             .Alignment = 0
137:             .BackStyle = 0
138:             .FontBold  = .T.
139:             .FontName  = "Tahoma"
140:             .FontSize  = 18
141:             .ForeColor = RGB(0, 0, 0)
142:             .Caption   = THIS.Caption
143:         ENDWITH
144: 
145:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oCab.lbl_4c_Titulo
147:             .Top       = 17
148:             .Left      = 10
149:             .Width     = loc_oCab.Width - 20
150:             .Height    = 46
151:             .AutoSize  = .F.
152:             .WordWrap  = .T.
153:             .Alignment = 0
154:             .BackStyle = 0
155:             .FontBold  = .T.
156:             .FontName  = "Tahoma"
157:             .FontSize  = 18
158:             .ForeColor = RGB(255, 255, 255)
159:             .Caption   = THIS.Caption
160:         ENDWITH
161:     ENDPROC
162: 
163:     *--------------------------------------------------------------------------
164:     * ConfigurarBotoes - Botoes de acao standalone (Gerar Senha, Encerrar)
165:     *--------------------------------------------------------------------------
166:     PROTECTED PROCEDURE ConfigurarBotoes()
167:         *-- Botao Gerar Senha (replica btnGerSen, posicao original Top=4 Left=348)
168:         THIS.AddObject("cmd_4c_GerarSenha", "CommandButton")
169:         WITH THIS.cmd_4c_GerarSenha
170:             .Top             = 4
171:             .Left            = 348
172:             .Width           = 75
173:             .Height          = 75
174:             .Caption         = "Gerar Senha"
175:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
176:             .FontName        = "Comic Sans MS"
177:             .FontBold        = .T.
178:             .FontItalic      = .T.
179:             .FontSize        = 8
180:             .ForeColor       = RGB(90, 90, 90)
181:             .BackColor       = RGB(255, 255, 255)
182:             .Themes           = .T.

*-- Linhas 189 a 207:
189:         ENDWITH
190: 
191:         *-- Botao Encerrar (replica Saida, posicao original Top=4 Left=423)
192:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
193:         WITH THIS.cmd_4c_Encerrar
194:             .Top             = 4
195:             .Left            = 423
196:             .Width           = 75
197:             .Height          = 75
198:             .Caption         = "Encerrar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
200:             .Cancel          = .T.
201:             .FontName        = "Comic Sans MS"
202:             .FontBold        = .T.
203:             .FontItalic      = .T.
204:             .FontSize        = 8
205:             .ForeColor       = RGB(90, 90, 90)
206:             .BackColor       = RGB(255, 255, 255)
207:             .Themes           = .T.

*-- Linhas 249 a 268:
249:     * ocorre via 2 botoes. Esta fase conecta os handlers via BINDEVENT.
250:     *--------------------------------------------------------------------------
251:     PROTECTED PROCEDURE ConfigurarPaginaDados()
252:         IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O"
253:             BINDEVENT(THIS.cmd_4c_GerarSenha, "Click", THIS, "CmdGerarSenhaClick")
254:         ENDIF
255:         IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
256:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
257:         ENDIF
258:     ENDPROC
259: 
260:     *--------------------------------------------------------------------------
261:     * CmdGerarSenhaClick - Delega processamento completo ao BO
262:     * Chamado diretamente em Init() quando this_lAutomatico = .T.
263:     * Chamado via BINDEVENT no evento Click de cmd_4c_GerarSenha.
264:     *--------------------------------------------------------------------------
265:     PROCEDURE CmdGerarSenhaClick()
266:         LOCAL loc_lSucesso, loc_oErro
267:         loc_lSucesso = .F.
268: 

*-- Linhas 280 a 288:
280: 
281:     *--------------------------------------------------------------------------
282:     * CmdEncerrarClick - Fecha o form
283:     * Chamado via BINDEVENT no evento Click de cmd_4c_Encerrar.
284:     *--------------------------------------------------------------------------
285:     PROCEDURE CmdEncerrarClick()
286:         THIS.Release()
287:     ENDPROC
288: 

*-- Linhas 463 a 476:
463:     * Form OPERACIONAL: Gerar Senha habilitado exceto quando this_lAutomatico=.T.
464:     *--------------------------------------------------------------------------
465:     PROCEDURE AjustarBotoesPorModo()
466:         IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O"
467:             THIS.cmd_4c_GerarSenha.Enabled = !THIS.this_lAutomatico
468:         ENDIF
469: 
470:         IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
471:             THIS.cmd_4c_Encerrar.Enabled = .T.
472:         ENDIF
473:     ENDPROC
474: 
475:     *--------------------------------------------------------------------------
476:     * FormParaBO - Sincroniza estado do form para o BO

*-- Linhas 497 a 510:
497:     * par_lHabilitar: .T. = habilitar, .F. = desabilitar
498:     *--------------------------------------------------------------------------
499:     PROCEDURE HabilitarCampos(par_lHabilitar)
500:         IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O"
501:             THIS.cmd_4c_GerarSenha.Enabled = par_lHabilitar AND !THIS.this_lAutomatico
502:         ENDIF
503: 
504:         IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
505:             THIS.cmd_4c_Encerrar.Enabled = par_lHabilitar
506:         ENDIF
507:     ENDPROC
508: 
509:     *--------------------------------------------------------------------------
510:     * LimparCampos - Descarta a senha gerada na sessao corrente


### BO (C:\4c\projeto\app\classes\sigprsenBO.prg):
*==============================================================================
* sigprsenBO.prg - Business Object para Senha do Dia
* Herda de: BusinessBase
* Tipo: OPERACIONAL - geracao de senha diaria e envio de e-mail
*==============================================================================
DEFINE CLASS sigprsenBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Estado operacional
    this_lAutomatico  = .F.
    this_cSenha       = ""

    *-- Configuracao SMTP (espelhando valores do legado)
    this_cSmtpServer      = "mail.4control.com.br"
    this_nSmtpPort        = 25
    this_cSmtpUser        = "errormail@4control.com.br"
    this_cSmtpSenha       = "PswError2@"
    this_cEmailDe         = "desenvolvimento@4control.com.br"
    this_cEmailPara       = "config4c@4control.com.br"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSenha - Gera a senha do dia usando algoritmo proprietario 4Control
    * Retorno: .T. se a senha foi gerada com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE GerarSenha()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cSenha = fGerPswDiario(VAL(SYS(1)), DATE(), 0)
            loc_lSucesso = !EMPTY(THIS.this_cSenha)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar senha")
            THIS.this_cSenha = ""
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Envia a senha do dia por e-mail via CDO
    * par_cSenha: senha a ser enviada
    * Retorno: .T. se enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cSenha)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSch, loc_oObs, loc_oMsg, loc_cCabecalho
        loc_lSucesso = .F.

        loc_cSch       = "http://schemas.microsoft.com/cdo/configuration/"
        loc_cCabecalho = "Senha do Dia : " + par_cSenha

        TRY
            loc_oObs = CREATEOBJECT("CDO.Configuration")

            WITH loc_oObs.Fields
                .Item(loc_cSch + "smtpserver")            = THIS.this_cSmtpServer
                .Item(loc_cSch + "smtpserverport")        = THIS.this_nSmtpPort
                .Item(loc_cSch + "sendusing")             = 2
                .Item(loc_cSch + "smtpauthenticate")      = 1
                .Item(loc_cSch + "smtpusessl")            = .F.
                .Item(loc_cSch + "sendusername")          = THIS.this_cSmtpUser
                .Item(loc_cSch + "sendpassword")          = THIS.this_cSmtpSenha
                .Item(loc_cSch + "smtpconnectiontimeout") = 60
                .Update
            ENDWITH

            loc_oMsg = CREATEOBJECT("CDO.Message")

            WITH loc_oMsg
                .Configuration         = loc_oObs
                .From                  = THIS.this_cEmailDe
                .To                    = THIS.this_cEmailPara
                .Subject               = loc_cCabecalho
                .AutoGenerateTextBody  = .F.
                =INKEY(1, "MH")
                .Send()
            ENDWITH

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            IF !THIS.this_lAutomatico
                MsgErro("Erro: " + TRANSFORM(loc_oErro.ErrorNo) + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Mensagem: " + loc_oErro.Message, "Aviso")
            ENDIF
            loc_lSucesso = .F.
        FINALLY
            loc_oObs = .NULL.
            loc_oMsg = .NULL.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Fluxo completo: confirmacao + geracao de senha + envio por e-mail
    * par_lAutomatico: .T. = execucao automatica (sem dialogs)
    * Retorno: .T. se processamento concluido com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_lAutomatico)
        LOCAL loc_lSucesso, loc_oErro, loc_lConfirmado
        loc_lSucesso   = .F.
        loc_lConfirmado = .T.

        THIS.this_lAutomatico = par_lAutomatico

        TRY
            IF !THIS.this_lAutomatico
                loc_lConfirmado = MsgConfirma("Deseja realmente gerar a senha?")
            ENDIF

            IF loc_lConfirmado
                IF THIS.GerarSenha()
                    IF !THIS.this_lAutomatico
                        MsgInfo("Favor Anotar a Senha :" + CHR(13) + CHR(13) + ;
                                THIS.this_cSenha + CHR(13) + CHR(13))
                    ENDIF

                    IF THIS.EnviarEmail(THIS.this_cSenha)
                        THIS.Inserir()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do registro operacional
    * A senha do dia e identificada pela data de geracao (YYYYMMDD)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOS(DATE())
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega estado operacional a partir de um cursor
    * Para SIGPRSEN nao existe tabela persistida; o cursor opcional pode
    * conter a senha gerada por outro processo (par_cAliasCursor com campo Senha).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".Senha") != "U"
                    THIS.this_cSenha = TratarNulo(Senha, "C")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra a geracao da senha do dia na auditoria
    * Como esta e uma operacao sem tabela de negocio, o "Inserir" corresponde
    * ao registro do evento de geracao em LogAuditoria via RegistrarAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cSenha)
                THIS.this_cMensagemErro = "Senha n" + CHR(227) + "o gerada"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("GERAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa a geracao da senha do dia
    * Para forms operacionais sem tabela, atualizar e equivalente a executar
    * novamente o Processar e registrar o evento na auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cSenha)
                THIS.this_cMensagemErro = "Senha n" + CHR(227) + "o gerada"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("REGERAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava evento de geracao/reenvio em LogAuditoria
    * par_cOperacao: "GERAR" (primeira geracao do dia) ou "REGERAR" (reenvio)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria" + ;
                       " (Tabela, Operacao, ChaveRegistro, Usuario, DataHora, Detalhes)" + ;
                       " VALUES (" + ;
                       EscaparSQL("SIGPRSEN") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("Senha do Dia gerada e enviada por e-mail") + ;
                       ")"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

