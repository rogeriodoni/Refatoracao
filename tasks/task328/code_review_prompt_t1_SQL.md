# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONFIGURARCAMPOSLOG' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS, LCPASS

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrScn.prg) - TRECHOS RELEVANTES PARA PASS SQL (470 linhas total):

*-- Linhas 222 a 240:
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
234:         *-- TextBox Senha
235:         THIS.AddObject("txt_4c_Senha", "TextBox")
236:         WITH THIS.txt_4c_Senha
237:             .FontBold       = .T.
238:             .FontName       = "Arial"
239:             .FontSize       = 14
240:             .BackStyle      = 1

*-- Linhas 382 a 400:
382:     *==========================================================================
383:     * Form OPERACIONAL SigPrScn (dialogo de autenticacao) NAO possui botao
384:     * Excluir - form nao gerencia registros de SigCdUsu, apenas verifica
385:     * credencial via SELECT em BO.ValidarCredenciais. Stub para
386:     * compatibilidade com o contrato do FormBase.
387:     *==========================================================================
388:     PROCEDURE BtnExcluirClick()
389:         RETURN .F.
390:     ENDPROC
391: 
392:     *==========================================================================
393:     * BtnBuscarClick - Nao aplicavel a form OPERACIONAL de login
394:     *==========================================================================
395:     PROCEDURE BtnBuscarClick()
396:         RETURN .F.
397:     ENDPROC
398: 
399:     *==========================================================================
400:     * BtnEncerrarClick - Nao aplicavel a form OPERACIONAL de login


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

