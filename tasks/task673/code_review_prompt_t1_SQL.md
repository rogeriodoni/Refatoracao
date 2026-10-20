# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CATIVOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS, LCPASS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  SelectOnEntry = .F.
lcQuery = [select a.usuarios, a.senhas from SigCdUsu a where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' order by 1]
ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
	Select CrSigCdUsu
			Select CrTmpParam

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrScn.prg) - TRECHOS RELEVANTES PARA PASS SQL (552 linhas total):

*-- Linhas 40 a 58:
40: * FASE 6 - LOOKUPS E EVENTOS DOS CAMPOS DIGITAVEIS
41: *   - LOOKUPS: NAO EXISTEM NESTE FORM. O dump nao casa nenhum padrao de busca
42: *     do legado: zero fwBuscaExt/fwBuscaSel/fwBuscaInt, zero mAddColuna, zero
43: *     sigacess ou Acesso<X>, zero KeyPress de F4/F5, e zero ControlSource - o
44: *     form nao vincula campo nenhum a cursor/tabela. Confere com analise.json
45: *     (lista de lookups vazia) e com comportamento.json (funcoes externas =
46: *     fConfigGeral, File, fGravarLog - nenhuma eh helper de busca).
47: *     Escrever AbrirLookup<X> ou AbrirBusca<X> aqui exigiria INVENTAR uma
48: *     tabela de lookup que o legado nunca consulta - viola o PILAR 1 e a regra
49: *     "NUNCA inventar tabelas de lookup que nao existem no original".
50: *   - CAMPOS DIGITAVEIS e os eventos de cada um. O dump nao tem ReadOnly nem
51: *     "When -> Return .F." em controle algum, logo os DOIS campos aceitam
52: *     digitacao e ambos foram inventariados:
53: *       . USUARIO -> o legado NAO tem Valid, When nem LostFocus neste campo.
54: *         A SECAO 3 do dump traz 3 metodos com codigo no total (Load, Init e
55: *         SENHA.LostFocus) e nenhum deles eh de USUARIO. Sem evento a
56: *         transcrever; criar handler seria inventar comportamento.
57: *       . SENHA   -> ValidarSenha(), ligado por BINDEVENT "LostFocus":
58: *         transcricao do SIGPRSCN.SENHA.LostFocus, que eh a autenticacao da

*-- Linhas 421 a 439:
421:             .BackColor     = RGB(255, 255, 255)
422:             .Format        = "K"
423:             .InputMask     = "!!!!!!!!!!"
424:             .SelectOnEntry = .F.
425:             .SpecialEffect = 1
426:             .TabIndex      = 2
427:         ENDWITH
428: 
429:         *-- SENHA (fwget) - mesma mascara do USUARIO + PasswordChar.
430:         THIS.AddObject("txt_4c_SENHA", "TextBox")
431:         WITH THIS.txt_4c_SENHA
432:             .Top           = 121
433:             .Left          = 160
434:             .Width         = 136
435:             .Height        = 30
436:             .Value         = ""
437:             .FontName      = "Arial"
438:             .FontSize      = 14
439:             .FontBold      = .T.


### BO (C:\4c\projeto\app\classes\SigPrScnBO.prg):
*====================================================================
* SigPrScnBO.prg
*
* Business Object para o dialogo de Liberacao de Acesso ao Sistema
* (SigPrScn) - login de usuario+senha exibido pelo form operacional
* homonimo. Confere o usuario ATIVO em SigCdUsu e a senha digitada
* (via fCriptografar, chamada literal do legado - ver nota em
* ValidarSenha nas proximas fases) e, autenticado, carrega os tempos
* de aviso/encerramento automatico configurados em SigCdPam.
* Tabela de referencia: SigCdUsu (Usuarios/Senhas/cAtivos)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrScnBO AS BusinessBase

    *-- Credenciais digitadas no login (Get_Usuario/Get_Senha do legado)
    this_cUsuario = ""    && SigCdUsu.Usuarios char(10) - usuario digitado (Padr(...,10))
    this_cSenha   = ""    && Senha digitada - transitorio, NUNCA persistida

    *-- Resultado final do dialogo de autenticacao
    this_lAcessoAutorizado = .F.    && .T. quando usuario+senha confere com SigCdUsu

    *-- Parametros de tempo lidos de SigCdPam apos login bem-sucedido
    *-- (legado: ThisForm.Podatamgr.cursorquery('SigCdPam', 'CrTmpParam', ...)
    *-- seguido de fTempoApp(CrTmpParam.nTmpChks, CrtmpParam.nTmpApps))
    this_nTempoAvisoChks = 0    && SigCdPam.nTmpChks - minutos para aviso de inatividade
    this_nTempoAvisoApps = 0    && SigCdPam.nTmpApps - minutos para encerramento automatico

    *-- Hash gravado em SigCdUsu.Senhas, carregado por CarregarDoCursor para
    *-- a conferencia feita em ValidarAcesso (fCriptografar - ver nota la)
    this_cSenhaArmazenada = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUsu"
            THIS.this_cCampoChave = "Usuarios"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigPrScnBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - mapeia o resultado do SELECT em SigCdUsu (feito
    * por ValidarAcesso) para as properties do BO. Chave = Usuarios.
    *====================================================================
    PROCEDURE CarregarDoCursor(pcCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(pcCursor)
            SELECT (pcCursor)
            IF !EOF()
                THIS.this_cUsuario           = TratarNulo(usuarios, "")
                THIS.this_cSenhaArmazenada   = TratarNulo(senhas, "")
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - SigCdUsu.Usuarios eh a chave (PK da tabela)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuario)
    ENDPROC

    *====================================================================
    * ValidarAcesso - equivalente ao SENHA.LostFocus do legado: confere
    * usuario ATIVO (cativos <> 'N') em SigCdUsu e a senha digitada contra
    * o hash gravado (fCriptografar - CHAMADA LITERAL, ver nota abaixo).
    * Autenticado, carrega os parametros de tempo de SigCdPam.
    *
    * fCriptografar() eh funcao GLOBAL do legado Fortyus (sig.prg/
    * SIGFUNCS.PRG) que NUNCA foi portada para o sistema novo (nao existe
    * em nenhum .prg do acervo, nem p-code legivel - esta compilada dentro
    * de Framework\sigmvcab.SCT). Por ser um HASH (valor de calculo), nao
    * criar wrapper que "adivinha": devolver a senha crua autenticaria
    * quem nao devia, devolver vazio recusaria todo mundo - os dois sao
    * divergencia SILENCIOSA. A chamada fica LITERAL e, se a funcao faltar,
    * estoura DENTRO deste TRY/CATCH: o usuario ve a mensagem em
    * this_cMensagemErro em vez de perder a tela.
    *====================================================================
    PROCEDURE ValidarAcesso(par_cUsuario, par_cSenha)
        LOCAL loc_cUsuarioPad, loc_cSenhaPad, loc_cSQL, loc_nResultado

        THIS.this_lAcessoAutorizado = .F.
        THIS.this_cMensagemErro     = ""

        loc_cUsuarioPad = PADR(ALLTRIM(NVL(par_cUsuario, "")), 10)
        loc_cSenhaPad   = PADR(ALLTRIM(NVL(par_cSenha, "")), 10)
        THIS.this_cUsuario = ALLTRIM(loc_cUsuarioPad)
        THIS.this_cSenha   = ALLTRIM(loc_cSenhaPad)

        TRY
            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            loc_cSQL = "SELECT usuarios, senhas FROM SigCdUsu " + ;
                       "WHERE cativos <> 'N' AND usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                       " ORDER BY usuarios"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Usuar")

            IF loc_nResultado <= 0 OR !USED("cursor_4c_Usuar") OR ;
               RECCOUNT("cursor_4c_Usuar") = 0 OR EMPTY(loc_cUsuarioPad)
                THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
            ELSE
                THIS.CarregarDoCursor("cursor_4c_Usuar")

                IF loc_cSenhaPad == fCriptografar(THIS.this_cSenhaArmazenada)
                    THIS.this_lAcessoAutorizado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
                ENDIF
            ENDIF

            IF USED("cursor_4c_Usuar")
                USE IN cursor_4c_Usuar
            ENDIF

            IF THIS.this_lAcessoAutorizado
                *-- Legado: "If Not File(Sys(5)+Sys(2003)+'\SetFiscal.Ini')" ->
                *-- carrega os tempos de aviso/encerramento SOMENTE quando o
                *-- modulo fiscal (que tem seu proprio mecanismo) nao esta
                *-- instalado. Transcrito literal - no sistema novo esse ini
                *-- nao existe, logo a carga roda sempre, igual ao legado.
                IF !FILE(SYS(5) + SYS(2003) + "\SetFiscal.Ini")
                    THIS.CarregarParametrosSistema()
                ENDIF

                *-- fGravarLog('L', ThisForm.Name, lcUser, ThisForm.Caption) do
                *-- legado precisa do Name/Caption do FORM - fica para a fase
                *-- do Form (que chama a mesma THIS.ValidarAcesso aqui). Aqui,
                *-- quem audita a tabela SigCdUsu eh a auditoria do sistema
                *-- novo (BusinessBase.RegistrarAuditoria -> LogAuditoria).
                THIS.RegistrarAuditoria("LOGIN")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.this_lAcessoAutorizado = .F.
        ENDTRY

        RETURN THIS.this_lAcessoAutorizado
    ENDPROC

    *====================================================================
    * CarregarParametrosSistema - SigCdPam.nTmpChks/nTmpApps (tempo de
    * aviso de inatividade / encerramento automatico). Tabela de parametro
    * unico do sistema (PK cidchaves) - GO TOP pega o registro vigente,
    * igual ao "Select CrTmpParam / Goto Top" do legado.
    *====================================================================
    PROTECTED PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado

        TRY
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            loc_cSQL = "SELECT ntmpchks, ntmpapps FROM SigCdPam"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")

            IF loc_nResultado > 0 AND USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                SELECT cursor_4c_Pam
                GO TOP
                THIS.this_nTempoAvisoChks = NVL(ntmpchks, 0)
                THIS.this_nTempoAvisoApps = NVL(ntmpapps, 0)
            ENDIF

            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        *-- fTempoApp(nTmpChks, nTmpApps) do legado eh funcao GLOBAL
        *-- (sig.prg/SIGFUNCS.PRG) que arma o timer de inatividade da
        *-- aplicacao inteira - nao foi portada (nao ha wrapper em utils\)
        *-- porque eh efeito de UI/sistema, nao calculo de dado. Os valores
        *-- ficam expostos em this_nTempoAvisoChks/this_nTempoAvisoApps
        *-- para quem for implementar o timer no Form/sistema.
        RETURN .T.
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao - este dialogo SOMENTE AUTENTICA
    * (SENHA.LostFocus do legado faz so SELECT em SigCdUsu, nunca grava
    * nela). Nao ha INSERT/UPDATE/DELETE equivalente a portar, entao o
    * comportamento padrao herdado de BusinessBase (recusar a operacao com
    * mensagem) ja eh o correto - sobrescrever aqui so para preencher
    * metodo criaria um caminho de escrita na tabela de usuarios que o
    * legado nunca tinha, violando o PILAR 2.
    *====================================================================

ENDDEFINE

