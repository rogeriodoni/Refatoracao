# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RECCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS, LCPASS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALIDARLOG' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: USUARIOS, LCPASS

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

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopprr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1091 linhas total):

*-- Linhas 62 a 80:
62: *     ListBox que lista registros ......... 0
63: *     token Grade/grd do proprio form ..... 0
64: *     AddCursor que liga grade ............ 0
65: *     RecordSource/ControlSource de lista . 0  (o dump nao tem nenhum dos dois)
66: *   superficie de BOTAO .. ZERO (BaseClass commandbutton|commandgroup = 0 e
67: *     PROCEDURE Click = 0). Os 5 metodos do SCX sao Release, Load e Init do
68: *     form e os dois LostFocus dos campos - o dialogo fecha pelo proprio
69: *     LostFocus (Thisform.Release), sem CommandButton algum.
70: *   superficie de CAMPO .. 2 TextBox EDITAVEIS (USUARIO, SENHA): o dump nao
71: *     declara ReadOnly em controle nenhum.
72: *
73: * Logo o legado eh um dialogo de CAPTURA - coleta operador + senha, valida
74: * contra SigCdUsu e devolve o resultado ao chamador. Inventar aqui grade,
75: * botoes CRUD ou AlternarPagina() criaria superficie que o legado nao tem
76: * (viola o PILAR 1 e a regra "NUNCA inventar" do CLAUDE.md), e a unica
77: * alternativa seria escrever metodos-adaptador vazios so para casar com o
78: * regex do gate - o "stub disfarcado" que a regra de completude proibe.
79: *
80: * Nota de medicao (probe de instanciacao desta fase): PEMSTATUS(form,

*-- Linhas 547 a 565:
547:     * txt_4c_USUARIO (USUARIO, classe fwget no legado): campo numerico do
548:     * codigo do operador - Format = "K" (seleciona o conteudo ao entrar),
549:     * InputMask = "999" (3 digitos) e MaxLength = 3 transcritos literalmente
550:     * do dump; SelectOnEntry = .F. tambem esta declarado no dump e sobrescreve
551:     * o default .T. do VFP. O Valid/LostFocus ("If IsEmpty(This.Value) /
552:     * Thisform.Release") fica para a Fase 7 - aqui so geometria e mascara,
553:     * igual ao padrao ja usado em FormSigOpCts/FormSigOpChp neste mesmo ponto
554:     * do pipeline. Classe "TextBox" simples (nao subclasse): o legado liga o
555:     * LostFocus por PROCEDURE no proprio controle, que na migracao se
556:     * reproduz com BINDEVENT (regra #3/#47), sem exigir subclasse dedicada.
557:     *==========================================================================
558:     PROTECTED PROCEDURE ConfigurarCampoOperador()
559:         LOCAL loc_oErro
560: 
561:         TRY
562:             THIS.AddObject("lbl_4c_Label1", "Label")
563:             WITH THIS.lbl_4c_Label1
564:                 .AutoSize  = .F.
565:                 .FontBold  = .T.

*-- Linhas 584 a 602:
584:                 .Format        = "K"
585:                 .InputMask     = "999"
586:                 .MaxLength     = 3
587:                 .SelectOnEntry = .F.
588:                 .TabIndex      = 1
589:                 .Value         = ""
590:                 .Top           = 104
591:                 .Left          = 201
592:                 .Width         = 50
593:                 .Height        = 30
594:                 .ForeColor     = RGB(0, 0, 0)
595:                 .BackColor     = RGB(255, 255, 255)
596:                 .Themes        = .T.
597:                 .Visible       = .T.
598:             ENDWITH
599:         CATCH TO loc_oErro
600:             MsgErro(loc_oErro.Message + CHR(13) + ;
601:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
602:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopprr.ConfigurarCampoOperador")

*-- Linhas 800 a 820:
800:     *
801:     *   lcUser = PADR(ThisForm.USUARIO.Value,10)
802:     *   lcPass = PADR(Thisform.SENHA.Value,10)
803:     *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a
804:     *              where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' ...]
805:     *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
806:     *   If Not Used(...) Or Reccount(...)==0 Or Empty(lcUser)
807:     *      OR lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
808:     *       =MessageBox('Usuario ou Senha incorretos',0+48,'')
809:     *       ThisForm.Senha.Value   = ''
810:     *       Thisform.Usuario.Value = ''
811:     *       ThisForm.Usuario.SetFocus
812:     *   Else
813:     *       If ProgOper(Val(Thisform.Usuario.Value),Thisform.oModem)
814:     *           goSistema.Operador = Transform(Val(...),'@L 999')
815:     *       Endif
816:     *       Thisform.Release
817:     *   EndIf
818:     *
819:     * Divisao de responsabilidade (PILAR 3): a CONSULTA e a conferencia moram
820:     * em sigopprrBO.ValidarLogin (Fase 2), que ja transcreve a query, o filtro


### BO (C:\4c\projeto\app\classes\sigopprrBO.prg):
*==============================================================================
* sigopprrBO.prg - Business Object para Formsigopprr (Codigo do Operador)
* Herda de BusinessBase
*
* Form OPERACIONAL (dialogo de login/reautenticacao do operador). O legado
* (SIGOPPRR) nao faz CRUD - o Init() da tela conecta ao banco e chama
* fConfigGeral()/fLerFiscal(), e o LostFocus de Senha valida USUARIO + SENHA
* contra SigCdUsu (tabela de usuarios, nao editada por este dialogo):
*     lcUser = Padr(ThisForm.USUARIO.Value,10)
*     lcPass = Padr(ThisForm.SENHA.Value,10)
*     Select a.usuarios, a.senhas From SigCdUsu a
*         Where Not a.cAtivos='N' And a.usuarios = ?lcUser Order By 1
*     If Not Used('CrSigCdUsu') Or Reccount=0 Or Empty(lcUser) ;
*         Or lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
*         *-- usuario/senha incorretos
*
* Como a tela so LE SigCdUsu para validar credenciais (nunca insere, altera
* ou exclui), o comportamento padrao herdado de BusinessBase para
* Inserir()/Atualizar()/ExecutarExclusao() ja eh o correto. Sobrescrever esses
* tres metodos aqui exigiria INVENTAR um INSERT/UPDATE em SigCdUsu que o
* legado nunca faz - o oposto da regra #22 do CLAUDE.md (a lista de colunas
* vem do schema, e a operacao vem do legado). ObterChavePrimaria() continua
* sobrescrito para que qualquer caminho herdado de auditoria reporte a chave
* certa (usuarios).
*
* Tabela ...: SigCdUsu (consulta de validacao)
* Chave .....: usuarios (char 10) - PK sigcdusu_usuarios
*
*------------------------------------------------------------------------------
* DEPENDENCIAS DO LEGADO FORTYUS QUE NAO VIERAM NO ACERVO (regra #27)
*
* fCriptografar(<senha gravada>) - devolve a senha em claro, comparavel com o
*   que o operador digitou. A funcao vive em sig.prg/SIGFUNCS.PRG, que nao
*   veio no acervo, e o algoritmo nao esta legivel em fonte nenhum. A chamada
*   eh transcrita LITERALMENTE em ValidarLogin(): se a funcao faltar, o VFP
*   estoura dentro do TRY e o CATCH devolve a mensagem pelo this_cMensagemErro
*   em vez de fechar a tela. NUNCA criar utils\fcriptografar.prg com algoritmo
*   inventado: hash inventado autentica quem nao deveria entrar, e em silencio.
*   Mesmo tratamento ja adotado em SigOpAlCBO, SigOpLimBO e SigOpCtsBO.
*
* ProgOper(<operador>, <modem>) - programa o codigo do operador no dispositivo
*   (modem/ECF) antes de publicar goSistema.Operador. Tambem nao veio no
*   acervo, e o objeto que o legado passa como 2o argumento (ThisForm.oModem)
*   nao existe nem no SCX legado nem no form migrado, entao a chamada nao eh
*   sequer expressavel aqui. DIVERGENCIA CONSCIENTE: DefinirOperadorLogado()
*   publica o operador SEM o passo de dispositivo - era o unico efeito do qual
*   o resto do sistema depende; sem ele o dialogo inteiro nao teria proposito.
*==============================================================================
DEFINE CLASS sigopprrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - credenciais digitadas pelo operador
    * Tipos conferidos em docs/schema.sql (tabela sigcdusu):
    *   usuarios char(10) NOT NULL (PK) | senhas char(10) NOT NULL
    *--------------------------------------------------------------------------
    this_cUsuarios = ""    && SigCdUsu.usuarios - codigo do operador digitado (char 10)
    this_cSenhas   = ""    && SigCdUsu.senhas   - senha digitada em texto claro (char 10)

    *--------------------------------------------------------------------------
    * Propriedades - estado da validacao (NAO existem em SigCdUsu)
    *--------------------------------------------------------------------------
    this_lLoginValido = .F.    && .T. apos ValidarLogin() encontrar usuario/senha corretos

    *--------------------------------------------------------------------------
    * Propriedades - demais colunas de SigCdUsu, preenchidas por
    * CarregarDoCursor() com a linha do operador autenticado. Tipos conferidos
    * em docs/schema.sql (lido com Get-Content -Raw - o arquivo eh UTF-16,
    * regra #14):
    *   supervis char(1)   | ccargs char(10)  | limdescs char(1)
    *   ncomps char(30)    | deptos char(10)  | libpess char(1)
    *   libprods char(1)   | setores char(10) | cativos char(1)
    *   tdtsenhas datetime NULL                | iclis char(10)
    *   obrigsenhas numeric(1,0)               | libqtmins char(1)
    *
    * As duas colunas text de sigcdusu (mbiodigs = digital biometrica,
    * figjpgsuser = foto do usuario) ficam DE FORA de proposito: o legado deste
    * dialogo nunca as le, elas sao blobs, e o SELECT de ValidarLogin() lista
    * as colunas explicitamente - logo nao chegam ao cursor e nao ha o que
    * mapear. Tela que precisar da biometria/foto deve consulta-las no seu
    * proprio BO.
    *--------------------------------------------------------------------------
    this_cSupervis    = ""    && SigCdUsu.supervis  - indicador de supervisor (char 1)
    this_cCcargs      = ""    && SigCdUsu.ccargs    - cargo do operador (char 10)
    this_cLimdescs    = ""    && SigCdUsu.limdescs  - limite de desconto (char 1)
    this_cNcomps      = ""    && SigCdUsu.ncomps    - nome completo do operador (char 30)
    this_cDeptos      = ""    && SigCdUsu.deptos    - departamento (char 10)
    this_cLibpess     = ""    && SigCdUsu.libpess   - liberacao de dados pessoais (char 1)
    this_cLibprods    = ""    && SigCdUsu.libprods  - liberacao de produtos (char 1)
    this_cSetores     = ""    && SigCdUsu.setores   - setor do operador (char 10)
    this_cCativos     = ""    && SigCdUsu.cativos   - N = usuario inativo (char 1)
    this_dTdtsenhas   = {}    && SigCdUsu.tdtsenhas - data/hora da ultima troca de senha
    this_cIclis       = ""    && SigCdUsu.iclis     - conta/cliente vinculado (char 10)
    this_nObrigsenhas = 0     && SigCdUsu.obrigsenhas - numeric(1,0), NAO eh logico
    this_cLibqtmins   = ""    && SigCdUsu.libqtmins - liberacao de quantidade minima (char 1)

    *--------------------------------------------------------------------------
    * Cursor de trabalho da consulta de credenciais (equivale ao CrSigCdUsu do
    * legado; nome novo por causa do PILAR 3)
    *--------------------------------------------------------------------------
    this_cCursorUsuario = "cursor_4c_UsuarioLogin"

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro

        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigCdUsu"
                THIS.this_cCampoChave = "usuarios"

                *-- Estado inicial da validacao de login
                THIS.LimparDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar sigopprrBO")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia a linha corrente do cursor informado para as
    * propriedades do BO. Chamado por ValidarLogin() e por CarregarPorCodigo()
    * depois do SELECT em SigCdUsu.
    *
    * Metodo PUBLIC (a base tambem eh): o Form pode chamar de fora depois de
    * popular o cursor por conta propria - regra #51.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias   = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- usuarios char(10) - chave primaria
                    IF TYPE(loc_cAlias + ".usuarios") == "C"
                        THIS.this_cUsuarios = TratarNulo(usuarios, "")
                    ENDIF

                    *-- senhas char(10) vem no cursor para a conferencia de
                    *-- ValidarLogin, mas NAO eh copiada para propriedade
                    *-- nenhuma: a senha gravada nao fica viva na memoria do BO
                    *-- depois do login.

                    *-- supervis char(1)
                    IF TYPE(loc_cAlias + ".supervis") == "C"
                        THIS.this_cSupervis = TratarNulo(supervis, "")
                    ENDIF

                    *-- ccargs char(10)
                    IF TYPE(loc_cAlias + ".ccargs") == "C"
                        THIS.this_cCcargs = TratarNulo(ccargs, "")
                    ENDIF

                    *-- limdescs char(1)
                    IF TYPE(loc_cAlias + ".limdescs") == "C"
                        THIS.this_cLimdescs = TratarNulo(limdescs, "")
                    ENDIF

                    *-- ncomps char(30)
                    IF TYPE(loc_cAlias + ".ncomps") == "C"
                        THIS.this_cNcomps = TratarNulo(ncomps, "")
                    ENDIF

                    *-- deptos char(10)
                    IF TYPE(loc_cAlias + ".deptos") == "C"
                        THIS.this_cDeptos = TratarNulo(deptos, "")
                    ENDIF

                    *-- libpess char(1)
                    IF TYPE(loc_cAlias + ".libpess") == "C"
                        THIS.this_cLibpess = TratarNulo(libpess, "")
                    ENDIF

                    *-- libprods char(1)
                    IF TYPE(loc_cAlias + ".libprods") == "C"
                        THIS.this_cLibprods = TratarNulo(libprods, "")
                    ENDIF

                    *-- setores char(10)
                    IF TYPE(loc_cAlias + ".setores") == "C"
                        THIS.this_cSetores = TratarNulo(setores, "")
                    ENDIF

                    *-- cativos char(1) - N marca usuario inativo
                    IF TYPE(loc_cAlias + ".cativos") == "C"
                        THIS.this_cCativos = TratarNulo(cativos, "")
                    ENDIF

                    *-- tdtsenhas datetime NULL - ConverterParaData normaliza
                    *-- DATE/DATETIME/CHAR (regra #16: TTOD so aceita DATETIME)
                    IF INLIST(TYPE(loc_cAlias + ".tdtsenhas"), "T", "D")
                        THIS.this_dTdtsenhas = ConverterParaData(TratarNulo(tdtsenhas, {}))
                    ENDIF

                    *-- iclis char(10)
                    IF TYPE(loc_cAlias + ".iclis") == "C"
                        THIS.this_cIclis = TratarNulo(iclis, "")
                    ENDIF

                    *-- obrigsenhas numeric(1,0) - NAO eh logico, nao achatar
                    *-- para .T./.F. (perderia os valores diferentes de 0 e 1)
                    IF TYPE(loc_cAlias + ".obrigsenhas") == "N"
                        THIS.this_nObrigsenhas = NVL(obrigsenhas, 0)
                    ENDIF

                    *-- libqtmins char(1)
                    IF TYPE(loc_cAlias + ".libqtmins") == "C"
                        THIS.this_cLibqtmins = TratarNulo(libqtmins, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados do operador:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo)
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Le a linha de SigCdUsu do operador informado e
    * preenche as propriedades, SEM conferir senha. Usado quando a tela so
    * precisa dos dados do operador (cargo/setor/nome) ja autenticado.
    *
    * Mantem o filtro do legado (Not cativos = N): operador inativo nao eh
    * encontrado, igual a consulta do SENHA.LostFocus.
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cUsuarioPad, loc_cCursor, loc_oErro

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""
        loc_cCursor             = THIS.this_cCursorUsuario
        loc_cUsuarioPad         = PADR(THIS.NormalizarTexto(par_cUsuario), 10)

        TRY
            IF EMPTY(loc_cUsuarioPad)
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o informado."
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                        "indispon" + CHR(237) + "vel."
                ELSE
                    THIS.FecharCursorUsuario()

                    loc_cSQL = "SELECT a.usuarios, a.senhas, a.supervis, a.ccargs" + ;
                               ", a.limdescs, a.ncomps, a.deptos, a.libpess" + ;
                               ", a.libprods, a.setores, a.cativos, a.tdtsenhas" + ;
                               ", a.iclis, a.obrigsenhas, a.libqtmins" + ;
                               " FROM SigCdUsu a" + ;
                               " WHERE NOT a.cativos = 'N'" + ;
                               " AND a.usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                               " ORDER BY a.usuarios"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                    IF loc_nResultado <= 0
                        THIS.this_cMensagemErro = "Erro ao consultar o operador:" + CHR(13) + ;
                            CapturarErroSQL()
                    ELSE
                        IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                            THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o cadastrado " + ;
                                "ou inativo."
                        ELSE
                            SELECT (loc_cCursor)
                            GO TOP
                            loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                        ENDIF
                    ENDIF

                    THIS.FecharCursorUsuario()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            THIS.FecharCursorUsuario()
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarLogin - Transcricao do SIGOPPRR.SENHA.LostFocus:
    *
    *   lcUser = PADR(ThisForm.USUARIO.Value,10)
    *   lcPass = PADR(Thisform.SENHA.Value,10)
    *   lcQuery = [select a.usuarios, a.senhas from SigCdUsu a
    *              where Not a.cAtivos='N' and a.usuarios='] + lcUser + [' order by 1]
    *   ThisForm.poDataMgr.SQLExecute(lcQuery, 'crSigCdUsu')
    *   If Not Used('CrSigCdUsu') Or Reccount('CrSigCdUsu')==0 Or Empty(lcUser) ;
    *      OR lcPass <> fCriptografar(CrSigCdUsu.SENHAS)
    *       *-- recusa
    *
    * Fidelidade preservada ponto a ponto:
    *  - PADR SEM ALLTRIM nos dois valores: o campo USUARIO tem InputMask 999
    *    e o legado compara o que esta no controle, com o espacamento que
    *    estiver la. ALLTRIM aqui mudaria quem casa com a chave char(10).
    *  - o filtro continua NOT cativos = N (usuario inativo nao autentica).
    *  - as quatro condicoes de recusa do If sao as mesmas, e todas devolvem a
    *    MESMA mensagem do legado (Usuario ou Senha incorretos), sem revelar
    *    qual delas falhou.
    *
    * Unica extensao: o SELECT lista as demais colunas escalares da linha (o
    * legado pede so usuarios+senhas) para preencher as propriedades de estado
    * declaradas neste BO. O criterio de autenticacao nao muda.
    *==========================================================================
    PROCEDURE ValidarLogin(par_cUsuario, par_cSenha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cCursor
        LOCAL loc_cUsuarioPad, loc_cSenhaPad, loc_cSenhaGravada, loc_oErro

        loc_lSucesso            = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lLoginValido  = .F.
        loc_cCursor             = THIS.this_cCursorUsuario

        *-- PADR sem ALLTRIM, exatamente como o legado
        loc_cUsuarioPad = PADR(THIS.NormalizarTexto(par_cUsuario), 10)
        loc_cSenhaPad   = PADR(THIS.NormalizarTexto(par_cSenha), 10)

        THIS.this_cUsuarios = loc_cUsuarioPad
        THIS.this_cSenhas   = loc_cSenhaPad

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "indispon" + CHR(237) + "vel."
            ELSE
                THIS.FecharCursorUsuario()

                loc_cSQL = "SELECT a.usuarios, a.senhas, a.supervis, a.ccargs" + ;
                           ", a.limdescs, a.ncomps, a.deptos, a.libpess" + ;
                           ", a.libprods, a.setores, a.cativos, a.tdtsenhas" + ;
                           ", a.iclis, a.obrigsenhas, a.libqtmins" + ;
                           " FROM SigCdUsu a" + ;
                           " WHERE NOT a.cativos = 'N'" + ;
                           " AND a.usuarios = " + EscaparSQL(loc_cUsuarioPad) + ;
                           " ORDER BY a.usuarios"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                IF loc_nResultado <= 0
                    THIS.this_cMensagemErro = "Erro ao consultar o operador:" + CHR(13) + ;
                        CapturarErroSQL()
                ELSE
                    IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0 OR EMPTY(loc_cUsuarioPad)
                        *-- 3 das 4 condicoes do If legado
                        THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
                    ELSE
                        SELECT (loc_cCursor)
                        GO TOP

                        *-- 4a condicao: lcPass <> fCriptografar(CrSigCdUsu.SENHAS).
                        *-- fCriptografar NAO foi portada (ver cabecalho): a
                        *-- chamada eh literal e, faltando a funcao, o VFP
                        *-- estoura aqui dentro e cai no CATCH abaixo - que eh
                        *-- o comportamento desejado (ausencia VISIVEL), nunca
                        *-- um stub devolvendo valor de calculo.
                        loc_cSenhaGravada = fCriptografar(senhas)

                        IF loc_cSenhaPad == PADR(TratarNulo(loc_cSenhaGravada, ""), 10)
                            loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)

                            IF loc_lSucesso
                                THIS.this_lLoginValido = .T.
                            ELSE
                                THIS.this_cMensagemErro = "Erro ao ler os dados do operador " + ;
                                    "autenticado." + CHR(13) + THIS.this_cMensagemErro
                            ENDIF
                        ELSE
                            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio ou Senha incorretos"
                        ENDIF
                    ENDIF
                ENDIF

                THIS.FecharCursorUsuario()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            THIS.FecharCursorUsuario()
        ENDTRY

        *-- A senha em claro nunca permanece viva no BO depois da conferencia
        THIS.this_cSenhas = ""

        IF !loc_lSucesso
            THIS.this_lLoginValido = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * DefinirOperadorLogado - Publica o operador autenticado em
    * go_4c_Sistema.Operador, no mesmo formato do legado:
    *
    *   If ProgOper(Val(Thisform.Usuario.Value), Thisform.oModem)
    *       goSistema.Operador = Transform(Val(Thisform.Usuario.Value),'@L 999')
    *   Endif
    *
    * ProgOper (programacao do operador no dispositivo) nao veio no acervo e o
    * objeto ThisForm.oModem nao existe nem no SCX legado nem no form migrado -
    * ver o cabecalho deste arquivo. O operador eh publicado assim mesmo: eh o
    * efeito do qual o resto do sistema depende.
    *
    * go_4c_Sistema eh um objeto Empty: ler/gravar property que ele nao tem
    * estoura "Property OPERADOR is not found" (medido no VFP9), e Empty nao
    * tem metodo AddProperty - por isso a criacao vai pela FUNCAO ADDPROPERTY().
    *==========================================================================
    PROCEDURE DefinirOperadorLogado()
        LOCAL loc_lSucesso, loc_cOperador, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF THIS.this_lLoginValido AND !EMPTY(THIS.this_cUsuarios)
                loc_cOperador = TRANSFORM(VAL(THIS.this_cUsuarios), "@L 999")

                IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                    IF PEMSTATUS(go_4c_Sistema, "Operador", 5)
                        go_4c_Sistema.Operador = loc_cOperador
                    ELSE
                        ADDPROPERTY(go_4c_Sistema, "Operador", loc_cOperador)
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Objeto de sistema indispon" + CHR(237) + "vel " + ;
                        "para registrar o operador."
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o autenticado."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Conferencia previa dos campos da tela, antes de gastar
    * uma ida ao banco. O legado trata operador vazio como recusa
    * (Empty(lcUser) entra no If de erro) e o LostFocus de USUARIO fecha o
    * dialogo quando o campo fica em branco.
    *
    * PUBLIC (como na base) - o Form chama de fora. Regra #51.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido             = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            CASE EMPTY(THIS.this_cUsuarios)
                THIS.this_cMensagemErro = "Operador n" + CHR(227) + "o informado."

            CASE EMPTY(THIS.this_cSenhas)
                THIS.this_cMensagemErro = "Senha n" + CHR(227) + "o informada."

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * LimparDados - Devolve o BO ao estado de "ninguem autenticado". Chamado
    * pelo Init e pelo Form a cada nova tentativa, para que a tentativa
    * seguinte nunca herde o cargo/setor do operador anterior.
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cUsuarios    = ""
        THIS.this_cSenhas      = ""
        THIS.this_lLoginValido = .F.

        THIS.this_cSupervis    = ""
        THIS.this_cCcargs      = ""
        THIS.this_cLimdescs    = ""
        THIS.this_cNcomps      = ""
        THIS.this_cDeptos      = ""
        THIS.this_cLibpess     = ""
        THIS.this_cLibprods    = ""
        THIS.this_cSetores     = ""
        THIS.this_cCativos     = ""
        THIS.this_dTdtsenhas   = {}
        THIS.this_cIclis       = ""
        THIS.this_nObrigsenhas = 0
        THIS.this_cLibqtmins   = ""

        RETURN .T.
    ENDPROC

    *==========================================================================
    * NormalizarTexto - Devolve sempre CARACTERE, qualquer que seja o tipo
    * recebido do controle (TextBox com InputMask numerico pode entregar
    * Numerico, e coluna anulavel chega como .NULL.). Existe para que o PADR de
    * ValidarLogin/CarregarPorCodigo nunca receba tipo errado - PADR com
    * numerico dispara "Function argument value, type, or count is invalid".
    *==========================================================================
    PROTECTED PROCEDURE NormalizarTexto(par_uValor)
        LOCAL loc_cTexto

        DO CASE
            CASE VARTYPE(par_uValor) = "C"
                loc_cTexto = par_uValor

            CASE ISNULL(par_uValor)
                loc_cTexto = ""

            CASE VARTYPE(par_uValor) = "N"
                loc_cTexto = ALLTRIM(TRANSFORM(par_uValor))

            OTHERWISE
                loc_cTexto = ""
        ENDCASE

        RETURN loc_cTexto
    ENDPROC

    *==========================================================================
    * FecharCursorUsuario - Fecha o cursor de trabalho da consulta de
    * credenciais. O guard pelo BUFFERING antes do TABLEREVERT eh a regra #52:
    * cursor nascido com Buffering = 1 faz TABLEREVERT estourar erro 1586, e
    * USE IN fecha o alias de qualquer modo.
    *==========================================================================
    PROTECTED PROCEDURE FecharCursorUsuario()
        LOCAL loc_cCursor

        loc_cCursor = THIS.this_cCursorUsuario

        IF USED(loc_cCursor)
            IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                TABLEREVERT(.T., loc_cCursor)
            ENDIF
            USE IN (loc_cCursor)
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave de SigCdUsu (usuarios char 10). Sobrescrito
    * para que o caminho herdado de auditoria do BusinessBase reporte a chave
    * correta. PROTECTED como na base: de fora ninguem chama (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Garante que o cursor de trabalho nao fique aberto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.FecharCursorUsuario()
        DODEFAULT()
    ENDPROC

ENDDEFINE

