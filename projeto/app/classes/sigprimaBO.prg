*============================================================================
* sigprimaBO.prg - Business Object: Importacao de Imagens de Produtos
* Migrado de: SIGPRIMA.SCX (form OPERACIONAL)
* Tabelas envolvidas:
*   - SigCdPro  (chave: CPros)       - imagem gravada no proprio produto
*   - SigCdPrc  (chave: cIdChaves)   - controle/auditoria do produto
*   - SigScjIm  (chave: cIdChaves)   - imagem auxiliar (tipo "Auxiliar")
*============================================================================
DEFINE CLASS sigprimaBO AS BusinessBase

    *-- Parametros recebidos pelo Form/Init (equivalentes a lcTipo1/lcPath1 do legado)
    this_cModoExecucao       = ""   && pcTipo1   - "A" = chamada automatica via parametro, vazio = manual
    this_cDiretorio          = ""   && lcDir/lcPath1 - diretorio de origem das imagens .JPG
    this_nTimerMsg           = 0    && pnTimerMsg1 - timeout do MessageBox (0=infinito, 10000=10s em modo automatico)

    *-- Selecao do usuario na tela (OptTipo.Value)
    this_nTipoImportacao     = 1    && 1=Produtos (SigCdPro) 2=Auxiliar (SigScjIm) 3=Exportar

    *-- Estado do processamento (equivalentes as variaveis locais do legado)
    this_nArquivosEncontrados = 0    && lnArq - total de arquivos .JPG localizados no diretorio
    this_nArquivosProcessados = 0    && contador de arquivos gravados com sucesso
    this_lProcessamentoOk     = .T.  && llOks - flag de sucesso acumulado do laco
    this_cMensagemResultado   = ""   && mensagem final exibida ao usuario

    *-- Nomes dos cursores de trabalho (populados nas fases seguintes)
    this_cCursorProdutos      = "cursor_4c_SigCdPro"
    this_cCursorProdutoCtl    = "cursor_4c_SigCdPrc"
    this_cCursorImagemAux     = "cursor_4c_SigScjIm"
    this_cCursorGrupos        = "cursor_4c_LocalGru"
    this_cCursorLocalizacao   = "cursor_4c_LocalPro"

    *-- Propriedades da entidade SigScjIm (imagem auxiliar - this_cCampoChave = cIdChaves)
    this_cCpros               = ""   && cpros      char(14) - produto associado a imagem
    this_nIdImagem            = 0    && idimagem   numeric(38,0) - codigo extraido do nome do arquivo
    this_cRefForRef           = ""   && refforref  char(50)
    this_cImagem              = ""   && imagem     text (NULL) - conteudo binario do arquivo (FileToStr)
    this_cCidChaves           = ""   && cidchaves  char(20) - PK (fUniqueIds na inclusao)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigScjIm"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia as colunas de SigScjIm (cursor_4c_SigScjIm) para
    * as properties this_* do BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        THIS.this_cCpros      = ALLTRIM(TratarNulo(cpros, ""))
        THIS.this_nIdImagem   = TratarNulo(idimagem, 0)
        THIS.this_cRefForRef  = ALLTRIM(TratarNulo(refforref, ""))
        THIS.this_cImagem     = TratarNulo(imagem, "")
        THIS.this_cCidChaves  = ALLTRIM(TratarNulo(cidchaves, ""))

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave primaria de SigScjIm (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT completo em SigScjIm (todas as colunas NOT NULL cobertas)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado

        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        loc_cSQL = "INSERT INTO SigScjIm (cpros, idimagem, refforref, imagem, cidchaves) " + ;
            "VALUES (" + ;
            EscaparSQL(PADR(THIS.this_cCpros, 14)) + ", " + ;
            FormatarNumeroSQL(THIS.this_nIdImagem, 0) + ", " + ;
            EscaparSQL(PADR(THIS.this_cRefForRef, 50)) + ", " + ;
            IIF(EMPTY(THIS.this_cImagem), "NULL", EscaparSQL(THIS.this_cImagem)) + ", " + ;
            EscaparSQL(THIS.this_cCidChaves) + ")"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Erro ao incluir imagem auxiliar: " + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
            RETURN .F.
        ENDIF

        THIS.RegistrarAuditoria("INSERT")
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE completo em SigScjIm pela chave cidchaves
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_cChave

        THIS.this_cMensagemErro = ""
        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave)
            THIS.this_cMensagemErro = "Registro sem chave (cidchaves) para atualizar"
            RETURN .F.
        ENDIF

        loc_cSQL = "UPDATE SigScjIm SET " + ;
            "cpros = "     + EscaparSQL(PADR(THIS.this_cCpros, 14))     + ", " + ;
            "idimagem = "  + FormatarNumeroSQL(THIS.this_nIdImagem, 0)  + ", " + ;
            "refforref = " + EscaparSQL(PADR(THIS.this_cRefForRef, 50)) + ", " + ;
            "imagem = "    + IIF(EMPTY(THIS.this_cImagem), "NULL", EscaparSQL(THIS.this_cImagem)) + ;
            " WHERE cidchaves = " + EscaparSQL(loc_cChave)

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Erro ao atualizar imagem auxiliar: " + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Erro ao Atualizar")
            RETURN .F.
        ENDIF

        THIS.RegistrarAuditoria("UPDATE")
        RETURN .T.
    ENDPROC

ENDDEFINE
