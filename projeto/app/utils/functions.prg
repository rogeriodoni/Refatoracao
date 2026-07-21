*==============================================================================
* FUNCTIONS.PRG
* Funções utilitárias compartilhadas
* Conjunto de funções auxiliares usadas em toda a aplicação
*==============================================================================

*------------------------------------------------------------------------------
* SomenteNumeros - Remove caracteres não numéricos de uma string
* Parâmetros: pcTexto - texto a ser processado
* Retorno: string contendo apenas números
*------------------------------------------------------------------------------
FUNCTION SomenteNumeros(pcTexto)
    LOCAL lcResultado, lnI, lcChar

    IF VARTYPE(pcTexto) != "C"
        RETURN ""
    ENDIF

    lcResultado = ""

    FOR lnI = 1 TO LEN(pcTexto)
        lcChar = SUBSTR(pcTexto, lnI, 1)
        IF ISDIGIT(lcChar)
            lcResultado = lcResultado + lcChar
        ENDIF
    ENDFOR

    RETURN lcResultado
ENDFUNC

*------------------------------------------------------------------------------
* FormatarNumeroSQL - Formata numero para uso em SQL (sempre com ponto decimal)
* IMPORTANTE: TRANSFORM() usa SET POINT (virgula no Brasil), mas SQL Server
* espera ponto como separador decimal. Esta funcao garante formato correto.
* Parametros: pnValor - valor numerico a ser formatado
*             pnDecimais - numero de casas decimais (padrao 2)
* Retorno: string formatada para SQL (ex: "123.45")
*------------------------------------------------------------------------------
FUNCTION FormatarNumeroSQL(pnValor, pnDecimais)
    LOCAL lcResultado, lnDecimais, lnValor, lcTipo

    * Valor padrao para decimais
    IF VARTYPE(pnDecimais) != "N"
        lnDecimais = 2
    ELSE
        lnDecimais = pnDecimais
    ENDIF

    * Verifica tipo do valor
    lcTipo = VARTYPE(pnValor)

    * Trata NULL
    IF ISNULL(pnValor)
        RETURN "0"
    ENDIF

    * Converte para numero se necessario
    DO CASE
    CASE lcTipo = "N"
        lnValor = pnValor

    CASE lcTipo = "C"
        * String - pode ser "123.45" ou "123,45" ou vazio
        IF EMPTY(ALLTRIM(pnValor))
            RETURN "0"
        ENDIF
        * Remove pontos de milhar e substitui virgula por ponto
        lcResultado = ALLTRIM(pnValor)
        * Se tem ponto e virgula, ponto eh milhar
        IF "." $ lcResultado AND "," $ lcResultado
            lcResultado = STRTRAN(lcResultado, ".", "")
        ENDIF
        * Substitui virgula por ponto (decimal)
        lcResultado = STRTRAN(lcResultado, ",", ".")
        lnValor = VAL(lcResultado)

    CASE lcTipo = "L"
        * Logico - converte para 0 ou 1
        lnValor = IIF(pnValor, 1, 0)

    OTHERWISE
        RETURN "0"
    ENDCASE

    * Usa STR() que nao depende de SET POINT
    * STR(numero, tamanho_total, decimais)
    lcResultado = ALLTRIM(STR(lnValor, 20, lnDecimais))

    * Garante que o separador eh ponto
    lcResultado = STRTRAN(lcResultado, ",", ".")

    * Remove espacos e caracteres invalidos
    lcResultado = CHRTRAN(lcResultado, " ", "")

    * Se resultado vazio ou invalido, retorna 0
    IF EMPTY(lcResultado) OR lcResultado = "." OR lcResultado = "*"
        RETURN "0"
    ENDIF

    RETURN lcResultado
ENDFUNC

*------------------------------------------------------------------------------
* FormatarDataSQL - Formata data para uso em SQL Server
* IMPORTANTE: DTOC() usa SET DATE que pode variar. SQL Server espera
* formato ISO 'YYYY-MM-DD' ou americano 'MM/DD/YYYY'.
* Aceita tipo D (Date) ou T (DateTime); para T retorna 'YYYY-MM-DD HH:MM:SS'.
* Parametros: pdData - data ou datetime a ser formatada
* Retorno: string formatada para SQL (ex: "'2024-01-15'" ou "'2024-01-15 14:30:45'" ou "NULL")
* Bug historico (Erro35 2026-07-08): callers passando DATETIME() (tipo T) recebiam
* "NULL" quando o filtro rejeitava != "D", quebrando INSERT em LogAuditoria.DataHora
* (NOT NULL). Fix: aceitar D e T; para RegistrarAuditoria preferir GETDATE() literal.
*------------------------------------------------------------------------------
FUNCTION FormatarDataSQL(pdData)
    LOCAL lcResultado, lcTipo

    * Trata NULL e valores vazios
    IF ISNULL(pdData) OR EMPTY(pdData)
        RETURN "NULL"
    ENDIF

    lcTipo = VARTYPE(pdData)
    IF lcTipo != "D" AND lcTipo != "T"
        RETURN "NULL"
    ENDIF

    * Formato ISO: YYYY-MM-DD para D, YYYY-MM-DD HH:MM:SS para T
    lcResultado = "'" + ;
        PADL(YEAR(pdData), 4, "0") + "-" + ;
        PADL(MONTH(pdData), 2, "0") + "-" + ;
        PADL(DAY(pdData), 2, "0")
    IF lcTipo == "T"
        lcResultado = lcResultado + " " + ;
            PADL(HOUR(pdData), 2, "0") + ":" + ;
            PADL(MINUTE(pdData), 2, "0") + ":" + ;
            PADL(SEC(pdData), 2, "0")
    ENDIF
    lcResultado = lcResultado + "'"

    RETURN lcResultado
ENDFUNC

*------------------------------------------------------------------------------
* FormatarCPF - Formata string como CPF (999.999.999-99)
* Parâmetros: pcCPF - CPF sem formatação
* Retorno: CPF formatado
*------------------------------------------------------------------------------
FUNCTION FormatarCPF(pcCPF)
    LOCAL lcCPF

    lcCPF = SomenteNumeros(pcCPF)

    IF LEN(lcCPF) != 11
        RETURN pcCPF
    ENDIF

    RETURN SUBSTR(lcCPF, 1, 3) + "." + ;
           SUBSTR(lcCPF, 4, 3) + "." + ;
           SUBSTR(lcCPF, 7, 3) + "-" + ;
           SUBSTR(lcCPF, 10, 2)
ENDFUNC

*------------------------------------------------------------------------------
* FormatarCNPJ - Formata string como CNPJ (99.999.999/9999-99)
* Parâmetros: pcCNPJ - CNPJ sem formatação
* Retorno: CNPJ formatado
*------------------------------------------------------------------------------
FUNCTION FormatarCNPJ(pcCNPJ)
    LOCAL lcCNPJ

    lcCNPJ = SomenteNumeros(pcCNPJ)

    IF LEN(lcCNPJ) != 14
        RETURN pcCNPJ
    ENDIF

    RETURN SUBSTR(lcCNPJ, 1, 2) + "." + ;
           SUBSTR(lcCNPJ, 3, 3) + "." + ;
           SUBSTR(lcCNPJ, 6, 3) + "/" + ;
           SUBSTR(lcCNPJ, 9, 4) + "-" + ;
           SUBSTR(lcCNPJ, 13, 2)
ENDFUNC

*------------------------------------------------------------------------------
* FormatarCEP - Formata string como CEP (99999-999)
* Parâmetros: pcCEP - CEP sem formatação
* Retorno: CEP formatado
*------------------------------------------------------------------------------
FUNCTION FormatarCEP(pcCEP)
    LOCAL lcCEP

    lcCEP = SomenteNumeros(pcCEP)

    IF LEN(lcCEP) != 8
        RETURN pcCEP
    ENDIF

    RETURN SUBSTR(lcCEP, 1, 5) + "-" + SUBSTR(lcCEP, 6, 3)
ENDFUNC

*------------------------------------------------------------------------------
* FormatarTelefone - Formata string como telefone
* Parâmetros: pcTelefone - telefone sem formatação
* Retorno: telefone formatado
*------------------------------------------------------------------------------
FUNCTION FormatarTelefone(pcTelefone)
    LOCAL lcTelefone

    lcTelefone = SomenteNumeros(pcTelefone)

    DO CASE
        CASE LEN(lcTelefone) = 10  && (99) 9999-9999
            RETURN "(" + SUBSTR(lcTelefone, 1, 2) + ") " + ;
                   SUBSTR(lcTelefone, 3, 4) + "-" + ;
                   SUBSTR(lcTelefone, 7, 4)

        CASE LEN(lcTelefone) = 11  && (99) 99999-9999
            RETURN "(" + SUBSTR(lcTelefone, 1, 2) + ") " + ;
                   SUBSTR(lcTelefone, 3, 5) + "-" + ;
                   SUBSTR(lcTelefone, 8, 4)

        OTHERWISE
            RETURN pcTelefone
    ENDCASE
ENDFUNC

*------------------------------------------------------------------------------
* FormatarMoeda - Formata número como moeda brasileira
* Parâmetros: pnValor - valor numérico
* Retorno: string formatada como R$ 9.999,99
*------------------------------------------------------------------------------
FUNCTION FormatarMoeda(pnValor)
    LOCAL lcValor

    IF VARTYPE(pnValor) != "N"
        RETURN "R$ 0,00"
    ENDIF

    lcValor = TRANSFORM(pnValor, "@E 999,999,999.99")
    lcValor = "R$ " + ALLTRIM(lcValor)

    * Troca ponto por vírgula (separador decimal)
    lcValor = STRTRAN(lcValor, ".", "#")
    lcValor = STRTRAN(lcValor, ",", ".")
    lcValor = STRTRAN(lcValor, "#", ",")

    RETURN lcValor
ENDFUNC

*------------------------------------------------------------------------------
* ConverterParaNumero - Converte string formatada em número
* Parâmetros: pcValor - string com valor formatado
* Retorno: valor numérico
*------------------------------------------------------------------------------
FUNCTION ConverterParaNumero(pcValor)
    LOCAL lcValor

    IF VARTYPE(pcValor) = "N"
        RETURN pcValor
    ENDIF

    IF VARTYPE(pcValor) != "C"
        RETURN 0
    ENDIF

    * Remove caracteres não numéricos exceto vírgula e ponto
    lcValor = ALLTRIM(pcValor)
    lcValor = STRTRAN(lcValor, "R$", "")
    lcValor = STRTRAN(lcValor, " ", "")

    * Converte vírgula em ponto
    lcValor = STRTRAN(lcValor, ",", ".")

    RETURN VAL(lcValor)
ENDFUNC

*------------------------------------------------------------------------------
* EscaparSQL - Escapa string para uso em queries SQL
* Parâmetros: pcTexto - texto a ser escapado
* Retorno: texto escapado e entre aspas
*------------------------------------------------------------------------------
FUNCTION EscaparSQL(pcTexto)
    LOCAL lcTexto

    IF VARTYPE(pcTexto) != "C"
        RETURN "''"
    ENDIF

    * Substitui aspas simples por duas aspas simples (escape SQL)
    lcTexto = STRTRAN(pcTexto, "'", "''")

    RETURN "'" + lcTexto + "'"
ENDFUNC

*------------------------------------------------------------------------------
* FormatarData - Formata data para exibição
* Parâmetros: pdData - data a ser formatada
*            pcFormato - formato desejado (opcional, padrão DD/MM/YYYY)
* Retorno: string com data formatada
*------------------------------------------------------------------------------
FUNCTION FormatarData(pdData, pcFormato)
    LOCAL lcFormato

    IF VARTYPE(pdData) != "D" AND VARTYPE(pdData) != "T"
        RETURN ""
    ENDIF

    IF EMPTY(pdData)
        RETURN ""
    ENDIF

    lcFormato = IIF(VARTYPE(pcFormato) = "C", pcFormato, "DD/MM/YYYY")

    DO CASE
        CASE UPPER(lcFormato) = "DD/MM/YYYY"
            RETURN DTOC(pdData)

        CASE UPPER(lcFormato) = "YYYY-MM-DD"
            RETURN TRANSFORM(YEAR(pdData), "9999") + "-" + ;
                   PADL(MONTH(pdData), 2, "0") + "-" + ;
                   PADL(DAY(pdData), 2, "0")

        CASE UPPER(lcFormato) = "YYYYMMDD"
            RETURN TRANSFORM(YEAR(pdData), "9999") + ;
                   PADL(MONTH(pdData), 2, "0") + ;
                   PADL(DAY(pdData), 2, "0")

        OTHERWISE
            RETURN DTOC(pdData)
    ENDCASE
ENDFUNC

*------------------------------------------------------------------------------
* DataAtual - Retorna data/hora atual do sistema
* Retorno: data atual
*------------------------------------------------------------------------------
FUNCTION DataAtual()
    RETURN DATE()
ENDFUNC

*------------------------------------------------------------------------------
* DataHoraAtual - Retorna data/hora atual do sistema
* Retorno: datetime atual
*------------------------------------------------------------------------------
FUNCTION DataHoraAtual()
    RETURN DATETIME()
ENDFUNC

*------------------------------------------------------------------------------
* GerarGUID - Gera um identificador único (GUID)
* Retorno: string com GUID
*------------------------------------------------------------------------------
FUNCTION GerarGUID()
    * Gera GUID usando função do Windows
    LOCAL loAPI, lcGUID

    DECLARE INTEGER CoCreateGuid IN ole32.dll STRING @pguid
    DECLARE INTEGER StringFromGUID2 IN ole32.dll STRING pguid, STRING @lpsz, INTEGER cchMax

    lcGUID = REPLICATE(CHR(0), 16)
    CoCreateGuid(@lcGUID)

    LOCAL lcBuffer
    lcBuffer = REPLICATE(CHR(0), 80)
    StringFromGUID2(lcGUID, @lcBuffer, 40)

    RETURN SUBSTR(lcBuffer, 1, AT(CHR(0), lcBuffer) - 1)
ENDFUNC

*------------------------------------------------------------------------------
* TratarNulo - Trata valores nulos
* Parâmetros: puValor - valor a ser testado
*            puPadrao - valor padrão se for nulo
* Retorno: valor original ou padrão
*------------------------------------------------------------------------------
FUNCTION TratarNulo(puValor, puPadrao)
    IF ISNULL(puValor) OR VARTYPE(puValor) = "L" AND EMPTY(puValor)
        RETURN puPadrao
    ENDIF

    RETURN puValor
ENDFUNC

*------------------------------------------------------------------------------
* Centralizar - Centraliza um formulário na tela
* Parâmetros: poForm - referência ao formulário
*------------------------------------------------------------------------------
FUNCTION Centralizar(poForm)
    IF VARTYPE(poForm) != "O"
        RETURN .F.
    ENDIF

    poForm.AutoCenter = .T.
    RETURN .T.
ENDFUNC


*------------------------------------------------------------------------------
* CapturarErroSQL - Captura mensagem de erro do SQL Server via AERROR()
*
* Retorna: String com a mensagem de erro SQL ou "Erro desconhecido"
*------------------------------------------------------------------------------
FUNCTION CapturarErroSQL()
    LOCAL ARRAY loc_aErro[1]
    LOCAL loc_cMensagem

    loc_cMensagem = "Erro desconhecido"

    IF AERROR(loc_aErro) > 0
        IF TYPE("loc_aErro[2]") = "C" AND !EMPTY(loc_aErro[2])
            loc_cMensagem = ALLTRIM(loc_aErro[2])
        ELSE
            IF TYPE("loc_aErro[1]") = "N"
                loc_cMensagem = "Erro SQL #" + TRANSFORM(loc_aErro[1])
            ENDIF
        ENDIF
    ENDIF

    RETURN loc_cMensagem
ENDFUNC

*------------------------------------------------------------------------------
* fChecaAcesso - Stub de compatibilidade com Framework legado
* No sistema legado, esta funcao verifica permissoes do usuario na tabela.
* Aqui retorna .T. (acesso permitido) quando o Framework nao esta disponivel.
* Par: par_cTabela  - nome da tabela ou modulo
*      par_cOperacao - operacao: ALTERAR, EXCLUIR, FOLLOWUP, etc.
*------------------------------------------------------------------------------
FUNCTION fChecaAcesso(par_cTabela, par_cOperacao)
    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* VerificarAcessoEmpresa - Substitui fAcessoEmpresa(usu,'C',emp) do legado
*   quando usado apenas para verificar acesso (modo check, sem popular textboxes)
* Regra (mesma do sigacess.PRG):
*   - Se usuario = 4CONTROL -> acesso total (.T.)
*   - Se usuario NAO tem registros em SigCdAcE -> acesso irrestrito (.T.)
*   - Caso contrario, deve existir SigCdAcE.Usuarios=usu e .Emps=emp
* Retorna .T. se tem acesso, .F. caso contrario.
*------------------------------------------------------------------------------
FUNCTION VerificarAcessoEmpresa(par_cUsuario, par_cCodEmp)
    LOCAL loc_cUsu, loc_cEmp, loc_nTotal, loc_nAcesso
    loc_cUsu = ALLTRIM(IIF(TYPE([par_cUsuario]) = [C], par_cUsuario, []))
    loc_cEmp = ALLTRIM(IIF(TYPE([par_cCodEmp]) = [C], par_cCodEmp, []))
    IF EMPTY(loc_cUsu) OR EMPTY(loc_cEmp)
        RETURN .F.
    ENDIF
    IF UPPER(loc_cUsu) == [4CONTROL]
        RETURN .T.
    ENDIF
    IF USED([cur_4c_AceEmpTot])
        USE IN cur_4c_AceEmpTot
    ENDIF
    IF SQLEXEC(gnConnHandle, ;
            [Select Count(*) as Nreg From SigCdAcE Where Usuarios = ] + EscaparSQL(loc_cUsu), ;
            [cur_4c_AceEmpTot]) < 1
        RETURN .F.
    ENDIF
    loc_nTotal = cur_4c_AceEmpTot.Nreg
    USE IN cur_4c_AceEmpTot
    IF loc_nTotal = 0
        RETURN .T.
    ENDIF
    IF USED([cur_4c_AceEmpChk])
        USE IN cur_4c_AceEmpChk
    ENDIF
    IF SQLEXEC(gnConnHandle, ;
            [Select Count(*) as Nreg From SigCdAcE Where Usuarios = ] + EscaparSQL(loc_cUsu) + ;
            [ And Emps = ] + EscaparSQL(loc_cEmp), ;
            [cur_4c_AceEmpChk]) < 1
        RETURN .F.
    ENDIF
    loc_nAcesso = cur_4c_AceEmpChk.Nreg
    USE IN cur_4c_AceEmpChk
    RETURN (loc_nAcesso > 0)
ENDFUNC

*==============================================================================
* fAcessoContab - Verifica acesso do usuario a grupos contabeis (SigCdGcr)
* Portada de Framework\sigacess.PRG - adaptada para nova arquitetura
* Usa gnConnHandle (SQLEXEC) em vez de loCnx.SQLExecute
* Usa FormBuscaSimples em vez de fwBuscaInt
*
* Parametros:
*   pUsu - Usuario (gc_4c_UsuarioLogado)
*   pTip - Tipo busca: 'C'=Codigo, 'D'=Descricao
*   pTxt - Texto de busca (codigo ou descricao do grupo)
*   pCod - Objeto TextBox do codigo (opcional, para preencher)
*   pDsc - Objeto TextBox da descricao (opcional, para preencher)
*   pCta - Conta corrente para validar vinculo (opcional)
*   pDat - Data para validar bloqueio de periodo (opcional)
*   pArr - Array para retornar grupos (opcional, se passado retorna array)
*   pRecPag - Flag rec/pag (opcional)
*
* Retorno: .T. se tem acesso, .F. se nao tem
*         Se pArr passado, retorna o array preenchido
*==============================================================================
FUNCTION fAcessoContab(pUsu, pTip, pTxt, pCod, pDsc, pCta, pDat, pArr, pRecPag)
    LOCAL lcEsc, llRet, llTot, llRst, llClr, lcGpr, lnSel, lnErr, llLik
    LOCAL lcQry, laArr, ldDsr, ldDsf, loc_oBusca

    pUsu = PADR(IIF(TYPE([pUsu]) = [C], pUsu, []), 10)
    pTip = UPPER(IIF(TYPE([pTip]) = [C] AND INLIST(pTip, [C], [D]), pTip, [C]))
    pTxt = IIF(TYPE([pTxt]) = [C], pTxt, [])
    pCta = PADR(IIF(TYPE([pCta]) = [C], pCta, []), 10)

    laArr = IIF(TYPE([pArr]) = [L], .F., .T.)
    llRet = EMPTY(pTxt)
    lcGpr = SPACE(10)
    lcEsc = SET([Escape])
    lnSel = SELECT(0)
    llClr = .F.
    llRst = .F.
    lnErr = IIF(gnConnHandle > 0, 1, -1)
    llTot = .F.

    ldDsr = 0
    ldDsf = 0
    IF (TYPE([pDat]) = [T] OR TYPE([pDat]) = [D])
        pDat = IIF(TYPE([pDat]) = [T], TTOD(pDat), pDat)
    ELSE
        pDat = CTOD([])
    ENDIF

    llLik = goSistema.BuscaP

    SET ESCAPE OFF

    IF USED([crAc1])
        USE IN crAc1
    ENDIF
    IF (lnErr > 0)
        lnErr = IIF(SQLEXEC(gnConnHandle, [Select Usuarios, Supervis From SigCdUsu Where Usuarios = '] + pUsu + ['], [crAc1]) >= 1, 1, -1)
    ENDIF
    IF USED([crAc1])
        SELECT crAc1
        GO TOP
        llTot = (NOT EOF([crAc1]) AND (UPPER(crAc1.Usuarios) = [4CONTROL]))
    ENDIF

    IF NOT llTot
        lcQry = [Select Count(*) as Nnreg1s ] + ;
                [From SigSyAgc a ] + ;
                [Left Join SigCdAcG c On c.Grupos = a.GrAcess And c.Usuarios = '] + pUsu + [' ] + ;
                [Right Join SigCdGcr b On b.Codigos = a.GrContbs ] + ;
                [Where (a.Usuacess = '] + pUsu + [' Or c.Usuarios = '] + pUsu + [')]

        IF USED([crAc2])
            USE IN crAc2
        ENDIF
        IF (lnErr > 0)
            lnErr = IIF(SQLEXEC(gnConnHandle, lcQry, [crAc2]) >= 1, 1, -1)
        ENDIF
        IF USED([crAc2])
            SELECT crAc2
            SET ORDER TO ''
            LOCATE
        ENDIF
    ENDIF

    lcQry = [Select a.Grcontbs, b.Codigos, b.Descrs, b.ddRetros, b.ddFutus ] + ;
            [From SigSyAgc a ] + ;
            [Left Join SigCdAcG c On c.Grupos = a.Gracess And c.Usuarios = '] + pUsu + [' ] + ;
            [Right Join SigCdGcr b On b.Codigos = a.Grcontbs ] + ;
            [Where ] + IIF(llTot, [0=0], [(a.Usuacess = '] + pUsu + [' Or c.Usuarios = '] + pUsu + [')]) + ;
            IIF(EMPTY(pTxt), [], IIF(pTip = [C], ;
            [ And ((a.Grcontbs between '] + pTxt + [' And '] + PADR(ALLTRIM(pTxt), LEN(pTxt), CHR(254)) + [')] + ;
            [ Or (b.Codigos Between '] + pTxt + [' And '] + PADR(ALLTRIM(pTxt), LEN(pTxt), CHR(254)) + ['))], ;
            [ And b.Descrs Between '] + pTxt + [' And '] + PADR(ALLTRIM(pTxt), LEN(pTxt), CHR(254)) + ['])) + ;
            [ Group By a.Grcontbs, b.Codigos, b.Descrs, b.ddRetros, b.ddFutus ] + ;
            [ Order By 1]
    IF USED([crAc3])
        USE IN crAc3
    ENDIF
    IF (lnErr > 0)
        lnErr = IIF(SQLEXEC(gnConnHandle, lcQry, [crAc3]) >= 1, 1, -1)
    ENDIF
    IF USED([crAc3])
        SELECT NVL(GrContbs, Codigos) as GrContbs, a.Descrs, a.Codigos, a.ddRetros, a.ddFutus ;
          FROM crAc3 a ;
         GROUP BY 1, 2, 3, 4, 5 ;
         ORDER BY 1, 3 ;
          INTO CURSOR crAr4
    ENDIF

    llRst = ((USED([crAr4]) AND RECCOUNT([crAr4]) = 0 AND USED([crAc2]) AND crAc2.nNreg1s = 0) OR llTot)

    IF llRst
        lcQry = [Select Codigos as Grcontbs, Descrs, ddRetros, ddfutus ] + ;
                [From SigCdGcr a ] + ;
                IIF(EMPTY(pTxt), [], IIF(llLik, IIF(pTip = [C], ;
                [ Where Codigos Like '%] + ALLTRIM(pTxt) + [%'], [ Where Descrs Like '%] + ALLTRIM(pTxt) + [%']), + ;
                IIF(pTip = [C], [ Where Codigos Between '] + pTxt + [' And '] + PADR(ALLTRIM(pTxt), LEN(pTxt), CHR(254)) + ['], ;
                [ Where Descrs Between '] + pTxt + [' And '] + PADR(ALLTRIM(pTxt), LEN(pTxt), CHR(254)) + [']))) + ;
                [ Order By 1]

        IF USED([crAr4])
            USE IN crAr4
        ENDIF
        IF (lnErr > 0)
            lnErr = IIF(SQLEXEC(gnConnHandle, lcQry, [crAr4]) >= 1, 1, -1)
        ENDIF
    ENDIF

    IF USED([crAr4]) AND laArr
        SELECT GrContbs FROM crAr4 GROUP BY 1 INTO ARRAY pArr
    ENDIF

    IF NOT llRet AND NOT laArr
        IF USED([crAr4])
            SELECT crAr4
            INDEX ON GrContbs TAG GrContbs

            IF USED([crAr5])
                USE IN crAr5
            ENDIF
            USE DBF([crAr4]) AGAIN ALIAS crAr5 IN 0
            SELECT crAr5
            INDEX ON Descrs TAG Descrs

            IF (TYPE([pCod]) = [O] OR TYPE([pDsc]) = [O])
                SET NEAR ON
                IF (pTip = [C])
                    IF NOT SEEK(pTxt, [crAr5], [GrContbs])
                        loc_oBusca = CREATEOBJECT("FormBuscaSimples", "crAr5", "Grupos")
                        loc_oBusca.mAddColuna("GrContbs", REPLICATE("x", 10), "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs", REPLICATE("x", 40), "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show(1)
                        llClr = (LASTKEY() = 27)
                        IF TYPE("loc_oBusca") = "O" AND NOT ISNULL(loc_oBusca)
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    IF NOT SEEK(pTxt, [crAr5], [Descrs])
                        loc_oBusca = CREATEOBJECT("FormBuscaSimples", "crAr5", "Grupos")
                        loc_oBusca.mAddColuna("Descrs", REPLICATE("x", 40), "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("GrContbs", REPLICATE("x", 10), "C" + CHR(243) + "digo")
                        loc_oBusca.Show(1)
                        llClr = (LASTKEY() = 27)
                        IF TYPE("loc_oBusca") = "O" AND NOT ISNULL(loc_oBusca)
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ENDIF
                SET NEAR OFF
            ELSE
                =SEEK(pTxt, [crAr5], IIF(pTip = [C], [GrContbs], [Descrs]))
            ENDIF
            lcGpr = crAr5.GrContbs
            ldDsr = crAr5.ddretros
            ldDsf = crAr5.ddfutus
            llRet = (NOT EOF([crAr5]) AND NOT EMPTY(lcGpr))

            IF (TYPE([pCod]) = [O])
                pCod.Value = IIF(llClr, [], crAr5.GrContbs)
                pCod.Refresh
            ENDIF
            IF (TYPE([pDsc]) = [O])
                pDsc.Value = IIF(llClr, [], crAr5.Descrs)
                pDsc.Refresh
            ENDIF
        ENDIF
    ELSE
        IF (TYPE([pCod]) = [O])
            pCod.Value = []
            pCod.Refresh
        ENDIF
        IF (TYPE([pDsc]) = [O])
            pDsc.Value = []
            pDsc.Refresh
        ENDIF
        llRet = llRst
        IF USED([crAr4])
            ldDsr = crAr4.ddretros
            ldDsf = crAr4.ddfutus
        ENDIF
    ENDIF

    IF NOT EMPTY(pCta)
        IF USED([crAr6])
            USE IN crAr6
        ENDIF
        IF (lnErr > 0)
            lnErr = IIF(SQLEXEC(gnConnHandle, [Select IClis, Vinculas, Grupos From SigCdCli Where IClis = '] + pCta + [' Order By 1], [crAr6]) >= 1, 1, -1)
        ENDIF
        IF USED([crAr6])
            SELECT crAr6
            SET ORDER TO ''
            GO TOP
            IF (crAr6.Vinculas = 1)
                llRet = (lcGpr = crAr6.Grupos)
                IF NOT llRet
                    =MESSAGEBOX([Este ] + CHR(233) + [ Um Grupo Vinculado!!! Verifique o Acesso Dele!!!], 0+48, [Grupo Vinculado])
                    IF (TYPE([pCod]) = [O])
                        pCod.Value = []
                        pCod.Refresh
                    ENDIF
                    IF (TYPE([pDsc]) = [O])
                        pDsc.Value = []
                        pDsc.Refresh
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDIF

    IF (llRet) AND NOT EMPTY(pDat) AND (ldDsr > 0 OR ldDsf > 0) AND NOT laArr
        LOCAL lnRet
        lnRet = 0
        IF (pDat < (DATE() - ldDsr))
            lnRet = -1
        ENDIF
        IF (pDat > (DATE() + ldDsf))
            lnRet = 1
        ENDIF
        IF (lnRet <> 0)
            =MESSAGEBOX([Per] + CHR(237) + [odo Bloqueado Para Este Grupo!!!], 0+48, [Bloqueio do Grupo: ] + lcGpr)
            IF (TYPE([pCod]) = [O])
                pCod.Value = []
                pCod.Refresh
            ENDIF
            IF (TYPE([pDsc]) = [O])
                pDsc.Value = []
                pDsc.Refresh
            ENDIF
            llRet = .F.
        ENDIF
    ENDIF

    IF USED([crAc1])
        USE IN crAc1
    ENDIF
    IF USED([crAc2])
        USE IN crAc2
    ENDIF
    IF USED([crAc3])
        USE IN crAc3
    ENDIF
    IF USED([crAr4])
        USE IN crAr4
    ENDIF
    IF USED([crAr5])
        USE IN crAr5
    ENDIF
    IF USED([crAr6])
        USE IN crAr6
    ENDIF
    IF (lnSel > 0)
        SELECT (lnSel)
    ENDIF

    SET ESCAPE &lcEsc.

    goSistema.BuscaP = .F.

    RETURN IIF(laArr, pArr, llRet)
ENDFUNC

*==============================================================================
* fAcessoContas - Verifica acesso do usuario a contas correntes (SigCdCli)
* Portada de Framework\sigacess.PRG - adaptada para nova arquitetura
* Usa gnConnHandle (SQLEXEC) em vez de loCnx.SQLExecute
*
* Parametros:
*   pUsu - Usuario
*   pGrp - Grupo contabil
*   pTip - Tipo busca: 'C'=Codigo, 'D'=Descricao
*   pTxt - Texto de busca (codigo ou descricao da conta)
*   pSt1 - Objeto TextBox codigo (opcional, para lookup)
*   pSt2 - Objeto TextBox descricao (opcional, para lookup)
*   pInd - Flag de busca indexada (opcional)
*   pGrc - Grupo complementar (opcional)
*   pFil - Filtro adicional (opcional)
*   pNtp - Tipo numerico para filtro Coletors (opcional)
*   pDig - Digito classificacao (opcional)
*
* Retorno: .T. se tem acesso, .F. se nao tem
*==============================================================================
FUNCTION fAcessoContas(pUsu, pGrp, pTip, pTxt, pSt1, pSt2, pInd, pGrc, pFil, pNtp, pDig)
    LOCAL lcEsc, llRet, lcCta, llRst, llTot, lnSel, lnErr
    LOCAL lcQry, lcInf, lcCpo, lcTab, loc_oBusca

    pUsu = PADR(IIF(TYPE([pUsu]) = [C], pUsu, []), 10)
    pGrp = PADR(IIF(TYPE([pGrp]) = [C], pGrp, []), 10)
    pTip = UPPER(IIF(TYPE([pTip]) = [C] AND INLIST(pTip, [C], [D]), pTip, [C]))
    pTxt = IIF(TYPE([pTxt]) = [C], pTxt, [])
    pFil = IIF(TYPE([pFil]) = [C], pFil, [])
    pInd = IIF(TYPE([pInd]) = [L], pInd, .F.)
    pGrc = IIF(TYPE([pGrc]) = [C], pGrc, pGrp)
    pDig = IIF(TYPE([pDig]) = [C], ALLTRIM(pDig), [])

    LOCAL pLik
    pLik = goSistema.BuscaP

    lcCpo = ALLTRIM(IIF(TYPE([goSistema.BuscaNome]) = [C], goSistema.BuscaNome, "RClis"))
    llRet = EMPTY(pTxt)
    lcCta = SPACE(10)
    lnSel = SELECT(0)
    lcEsc = SET([Escape])
    llRst = .F.
    llTot = .F.
    lnErr = IIF(gnConnHandle > 0, 1, -1)
    lcInf = IIF(EMPTY(pDig), [], [ a.Grupos In (Select Codigos From SigCdGcr Where Classes In (Select Classes From SigCdCss Where Substring(Classes, 1, 1) = '] + pDig + [')) And ])
    SET ESCAPE OFF

    IF (lnErr > 0)
        lnErr = IIF(SQLEXEC(gnConnHandle, [Select * From SigCdPac], [crPac1]) >= 1, 1, -1)
        IF TYPE([crPac1.BuscaNome]) = [N] AND crPac1.BuscaNome = 2
            pLik = .T.
        ENDIF
    ENDIF

    IF USED([crAc1])
        USE IN ([crAc1])
    ENDIF
    IF (lnErr > 0)
        lnErr = IIF(SQLEXEC(gnConnHandle, [Select a.Usuarios, a.Supervis From SigCdUsu a Where a.Usuarios = '] + pUsu + ['], [crAc1]) >= 1, 1, -1)
    ENDIF

    IF USED([crAc1])
        SELECT crAc1
        GO TOP IN crAc1
        llTot = (NOT EOF([crAc1]) AND (UPPER(crAc1.Usuarios) = [4CONTROL]))
    ENDIF

    lcQry = [Select Distinct a.GrContbs, a.GrContas, a.CdContas ] + ;
            [From SigSyAgc a ] + ;
            [Left Join SigCdAcG b On b.Grupos = a.GrAcess And b.Usuarios = '] + pUsu + [' ] + ;
            [Where (a.UsuAcess = '] + pUsu + [' Or b.Usuarios = '] + pUsu + [') ] + ;
            [Order By 1]

    IF (lnErr > 0)
        IF USED([crAc2])
            USE IN crAc2
        ENDIF
        lnErr = IIF(SQLEXEC(gnConnHandle, lcQry, [crAc2]) >= 1, 1, -1)
    ENDIF

    lcQry = [Select Distinct a.GrContas, a.CdContas ] + ;
            [From SigSyAcc a ] + ;
            [Left Join SigCdAcG b On b.Grupos = a.GrAcess And b.Usuarios = '] + pUsu + [' ] + ;
            [Where (a.UsuAcess = '] + pUsu + [' Or b.Usuarios = '] + pUsu + [') ] + ;
            [Order By 1]

    IF (lnErr > 0)
        IF USED([crAc3])
            USE IN crAc3
        ENDIF
        lnErr = IIF(SQLEXEC(gnConnHandle, lcQry, [crAc3]) >= 1, 1, -1)
    ENDIF

    *-- Mena - 25/10/2017 - inclui conta contabil para checar acesso
    IF USED([crAc3]) AND USED([crAc2])
        SELECT GrContas, CdContas FROM crAc3 UNION (SELECT GrContbs, CdContas FROM crAc2 WHERE cdContas <> ' ' AND GrContbs = pGrp) INTO CURSOR crAc3 READWRITE
    ENDIF

    IF USED([crAc3])
        SELECT crAc3
        INDEX ON GrContas + CdContas TAG Ordem
    ENDIF
    llRst = ((USED([crAc3]) AND RECCOUNT([crAc3]) = 0) OR llTot)

    IF NOT llRet
        IF (TYPE([pSt1]) = [O] OR TYPE([pSt2]) = [O])
            *-- Busca com lookup UI (quando objetos TextBox sao passados)
            LOCAL laFil
            laFil = .F.
            IF pInd
                IF pLik
                    laFil = ([Grupos = '] + pGrc + [' And ] + IIF(pTip = [C], [IClis], lcCpo) + [ Like '%] + ALLTRIM(pTxt) + [%'])
                ELSE
                    laFil = [Grupos = '] + pGrc + [']
                ENDIF
            ELSE
                IF pLik
                    laFil = IIF(pTip = [C], [IClis], lcCpo) + [ Like '%] + ALLTRIM(pTxt) + [%']
                ENDIF
            ENDIF

            IF NOT EMPTY(pFil)
                IF NOT TYPE([laFil]) = [C]
                    laFil = [1=1]
                ENDIF
                laFil = laFil + [ And ] + ALLTRIM(pFil)
            ENDIF

            *-- Montar query de busca
            LOCAL loc_cWhere
            loc_cWhere = []
            IF TYPE([laFil]) = [C]
                loc_cWhere = [ Where ] + laFil
            ENDIF

            IF (pTip = [C])
                lcQry = [Select a.IClis, a.] + lcCpo + [ as Descr, a.Grupos, a.Situas, a.Cpfs, a.Inativas ] + ;
                        [From SigCdCli a ] + ;
                        [Inner Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
                        IIF(EMPTY(pGrp), [], [ And a.Grupos = '] + PADR(pGrp, 10) + [']) + ;
                        loc_cWhere + ;
                        [ Order By a.IClis]
            ELSE
                lcQry = [Select a.IClis, a.] + lcCpo + [ as Descr, a.Grupos, a.Situas, a.Cpfs, a.Inativas ] + ;
                        [From SigCdCli a ] + ;
                        [Inner Join SigCdGcr b On a.Grupos = b.Codigos ] + ;
                        IIF(EMPTY(pGrp), [], [ And a.Grupos = '] + PADR(pGrp, 10) + [']) + ;
                        loc_cWhere + ;
                        [ Order By a.] + lcCpo
            ENDIF

            IF USED([crAc4])
                USE IN crAc4
            ENDIF
            IF (lnErr > 0)
                lnErr = IIF(SQLEXEC(gnConnHandle, lcQry, [crAc4]) >= 1, 1, -1)
            ENDIF

            IF USED([crAc4]) AND NOT EOF([crAc4])
                *-- Verificar se achou direto
                LOCAL loc_lAchou
                loc_lAchou = .F.
                SELECT crAc4
                IF pTip = [C]
                    LOCATE FOR crAc4.IClis = pTxt
                ELSE
                    LOCATE FOR UPPER(ALLTRIM(crAc4.Descr)) = UPPER(ALLTRIM(pTxt))
                ENDIF
                loc_lAchou = NOT EOF([crAc4])

                IF NOT loc_lAchou
                    *-- Abrir lookup
                    loc_oBusca = CREATEOBJECT("FormBuscaSimples", "crAc4", "Contas")
                    IF (pTip = [C])
                        loc_oBusca.mAddColuna("IClis", REPLICATE("x", 10), "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descr", REPLICATE("x", 50), "Descri" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_oBusca.mAddColuna("Descr", REPLICATE("x", 50), "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.mAddColuna("IClis", REPLICATE("x", 10), "C" + CHR(243) + "digo")
                    ENDIF
                    loc_oBusca.mAddColuna("Grupos", REPLICATE("x", 10), "Grupo")
                    loc_oBusca.mAddColuna("Cpfs", REPLICATE("x", 20), "CPF/CNPJ")
                    loc_oBusca.Show(1)
                    IF TYPE("loc_oBusca") = "O" AND NOT ISNULL(loc_oBusca)
                        loc_oBusca.Release()
                    ENDIF
                ENDIF
            ENDIF

            IF (TYPE([pSt1]) = [O])
                pSt1.Value = IIF(USED([crAc4]) AND NOT EOF([crAc4]), EVALUATE([crAc4.IClis]), [])
                pSt1.Refresh
            ENDIF
            IF (TYPE([pSt2]) = [O])
                pSt2.Value = IIF(USED([crAc4]) AND NOT EOF([crAc4]), EVALUATE([crAc4.Descr]), [])
                pSt2.Refresh
            ENDIF
        ELSE
            *-- Busca sem UI (apenas verifica acesso)
            lcQry = [Select a.IClis, a.Grupos ] + ;
                    [From SigCdCli a ] + ;
                    [Where ] + IIF(pInd, [a.Grupos = '] + pGrc + [' And ], []) + [a.IClis = '] + pTxt + [']

            IF (lnErr > 0)
                IF USED([crAc4])
                    USE IN crAc4
                ENDIF
                lnErr = IIF(SQLEXEC(gnConnHandle, lcQry, [crAc4]) >= 1, 1, -1)
            ENDIF
        ENDIF

        IF (USED([crAc4]) AND NOT EOF([crAc4]))
            llRet = (llTot OR llRst)
            lcCta = crAc4.IClis

            IF NOT llRet
                IF USED([crAc2])
                    SELECT crAc2
                    SET ORDER TO ''
                    LOCATE FOR crAc2.GrContbs = pGrp
                ENDIF
                IF (EMPTY(pGrp) OR (USED([crAc2]) AND (EOF([crAc2]) OR EMPTY(crAc2.GrContas + crAc2.CdContas))))
                    llRet = (NOT EOF([crAc4]) AND crAc4.IClis = lcCta AND (SEEK(SPACE(10) + crAc4.Iclis, [crAc3], [Ordem]) OR ;
                            SEEK(crAc4.Grupos + crAc4.IClis, [crAc3], [Ordem]) OR SEEK(crAc4.Grupos + SPACE(10), [crAc3], [Ordem])))
                ELSE
                    SELECT crAc2
                    SET ORDER TO ''
                    LOCATE FOR crAc2.GrContbs = pGrp
                    SCAN WHILE (llRet = .F. AND crAc2.GrContbs = pGrp)
                        DO CASE
                            CASE NOT EMPTY(crAc2.CdContas)
                                llRet = (crAc2.CdContas = lcCta)
                            CASE (NOT EMPTY(crAc2.GrContas) AND EMPTY(crAc2.CdContas))
                                SELECT crAc4
                                SET ORDER TO ''
                                LOCATE FOR (crAc4.Grupos = crAc2.GrContas AND crAc4.IClis = lcCta)
                                llRet = NOT EOF([crAc4])
                        ENDCASE
                    ENDSCAN
                ENDIF
            ENDIF
        ENDIF
    ELSE
        IF (TYPE([pSt1]) = [O])
            pSt1.Value = []
            pSt1.Refresh
        ENDIF
        IF (TYPE([pSt2]) = [O])
            pSt2.Value = []
            pSt2.Refresh
        ENDIF
        llRet = llRst
    ENDIF

    IF llRet AND NOT EMPTY(lcCta)
        IF USED([crAc4])
            USE IN crAc4
        ENDIF
        IF (lnErr > 0)
            lnErr = IIF(SQLEXEC(gnConnHandle, [Select a.IClis, a.Grupos, a.Vinculas From SigCdCli a Where a.IClis = '] + lcCta + [' Order By 1], [crAc4]) >= 1, 1, -1)
        ENDIF
        IF USED([crAc4])
            SELECT crAc4
            SET ORDER TO ''
            GO TOP IN crAc4
            IF (crAc4.Vinculas = 1)
                llRet = (crAc4.Grupos = pGrp OR (NOT EMPTY(goSistema.Transitorio) AND goSistema.Transitorio = pGrp) OR EMPTY(pGrp))
            ENDIF
        ENDIF
    ENDIF

    IF USED([crAc1])
        USE IN crAc1
    ENDIF
    IF USED([crAc2])
        USE IN crAc2
    ENDIF
    IF USED([crAc3])
        USE IN crAc3
    ENDIF
    IF USED([crAc4])
        USE IN crAc4
    ENDIF
    IF USED([crPac1])
        USE IN crPac1
    ENDIF
    IF (lnSel > 0)
        SELECT (lnSel)
    ENDIF
    SET ESCAPE &lcEsc.

    RETURN llRet
ENDFUNC

*==============================================================================
* fVerificaBloqueio - Verifica se data esta em periodo bloqueado
* Portada de Framework\sigfuncs.PRG - adaptada para nova arquitetura
* Usa gnConnHandle (SQLEXEC) em vez de pCnx.SQLExecute
*
* Parametros:
*   pDat - Data a verificar
*   pCnx - Handle de conexao (gnConnHandle) - mantido para compatibilidade
*
* Retorno: 0=Ok, -1=Retroativo bloqueado, 1=Futuro bloqueado
*==============================================================================
FUNCTION fVerificaBloqueio(pDat, pCnx)
    LOCAL lnRet, ldDtm, ldDat, lnConn
    lnRet = 0
    ldDtm = DATETIME()
    ldDat = IIF(TYPE([pDat]) = [T], TTOD(pDat), IIF(TYPE([pDat]) = [D], pDat, TTOD(ldDtm)))

    *-- Usar conexao passada ou global
    lnConn = IIF(TYPE([pCnx]) = [N] AND pCnx > 0, pCnx, gnConnHandle)

    IF (SQLEXEC(lnConn, [Select * From SigSyBlq], [crAv1]) < 1)
        =MESSAGEBOX([Favor Reinicializar o Processo!!!], 16, [Falha na Conex] + CHR(227) + [o - fVerificaBloqueio])
        RETURN 1
    ENDIF

    SELECT DdRetros, DdFutus, TTOD(Datafs) as Datafs, TTOD(Datais) as Datais, TTOD(DtiConts) as DtIConts ;
      FROM crAv1 ;
      INTO CURSOR crAv2
    GO TOP IN crAv2

    IF NOT EOF([crAv2])
        lnRet = 0
        IF NOT EMPTY(crAv2.DtIConts)
            IF (ldDat <= crAv2.DtIConts)
                lnRet = -1
            ENDIF
        ELSE
            IF EMPTY(crAv2.DdRetros) AND EMPTY(crAv2.DdFutus)
                IF (ldDat < crAv2.DataIs)
                    lnRet = -1
                ENDIF
                IF (ldDat > crAv2.DataFs)
                    lnRet = 1
                ENDIF
            ELSE
                IF (ldDat < (TTOD(ldDtm) - crAv2.DdRetros))
                    lnRet = -1
                ENDIF
                IF (ldDat > (TTOD(ldDtm) + crAv2.DdFutus))
                    lnRet = 1
                ENDIF
            ENDIF
        ENDIF
    ENDIF
    IF USED([crAv1])
        USE IN crAv1
    ENDIF
    IF USED([crAv2])
        USE IN crAv2
    ENDIF
    RETURN lnRet
ENDFUNC

*==============================================================================
* fUniqueIds - Gera identificador unico para registros
* Portada de Framework\sigfuncs.PRG - adaptada para nova arquitetura
* Usa go_4c_Sistema.cCodEmpresa em vez de _EMPR
*
* Parametros:
*   pPar - Prefixo opcional (ate 10 chars)
*
* Retorno: String unica (empresa + SYS(2015) + random)
*==============================================================================
FUNCTION fUniqueIds(pPar)
    LOCAL lcRet
    pPar = IIF((TYPE([pPar]) = [C] AND NOT EMPTY(pPar)), pPar, [])
    pPar = STRTRAN(PADR(STRTRAN(pPar, [ ], []), 10), [ ], [])
    lcRet = []
    IF (TYPE([go_4c_Sistema.cCodEmpresa]) = [C])
        lcRet = (lcRet + go_4c_Sistema.cCodEmpresa)
    ENDIF
    lcRet = lcRet + RIGHT(SYS(2015), 9) + ;
            TRANSFORM(INT(RAND() * RAND() * 100), [@L 99]) + TRANSFORM(INT(RAND() * RAND() * 100), [@L 99]) + ;
            TRANSFORM(INT(RAND() * RAND() * 100), [@L 99]) + TRANSFORM(INT(RAND() * RAND() * 100), [@L 99])
    RETURN lcRet
ENDFUNC

*==============================================================================
* fDtoSQL - Converte data/hora para datetime VFP no formato SQL
* Portada de Framework\sigfuncs.PRG
*
* Parametros:
*   pDat - Data (Date ou DateTime)
*   pHor - Hora opcional (string "HH:MM:SS" ou "HHMMSS")
*
* Retorno: DateTime
*==============================================================================
FUNCTION fDtoSQL(pDat, pHor)
    LOCAL ldDat, lcHor

    pDat = IIF(ISNULL(pDat), CTOD([]), pDat)
    ldDat = IIF(TYPE([pDat]) = [D], pDat, IIF(TYPE([pDat]) = [T], TTOD(pDat), CTOD([01/01/1900])))

    lcHor = [000000]
    IF (TYPE([pHor]) = [C])
        lcHor = IIF(INLIST(LEN(ALLTRIM(pHor)), 5, 8), pHor, lcHor)
        lcHor = PADR(STRTRAN(pHor, [:], []), 6, [0])
    ENDIF
    RETURN EVALUATE([{^] + TRANSFORM((DTOS(MAX(ldDat, CTOD([01/01/1900]))) + lcHor), [@R 9999-99-99 99:99:99]) + [}])
ENDFUNC

*==============================================================================
* fRecalculaS - Recalcula saldos de contas correntes
* Portada de Framework\sigfuncs.PRG - adaptada para nova arquitetura
* Usa SQLEXEC(gnConnHandle) em vez de loCnx.SqlExecute
*
* Parametros:
*   pGru - Grupo (string) ou conexao (object) para processar
*   pCta - Conta (string) ou conexao secundaria (object)
*   pDat - Data ou conexao secundaria (object)
*   pMoe - Moeda (string)
*   pCnx - Handle conexao (gnConnHandle) ou nao informado
*   pAut - Flag automatico (opcional)
*   pObj - Objeto form (opcional)
*   pBkg - Flag background (opcional)
*
* Retorno: .T. se sucesso
*==============================================================================
FUNCTION fRecalculaS(pGru, pCta, pDat, pMoe, pCnx, pAut, pObj, pBkg)
    LOCAL llFc1, llFc2, llAut, llRet, lnTot
    LOCAL lcKey, lcGrp, lcCta, lcMoe, lcGcm, lcQry
    LOCAL llNtv, llNis, llNow, lcIdk, llOks, llSeg, lnFlt, lnNbq, lnVtf
    PRIVATE ldDat, ldDts

    llFc1 = .F.
    llFc2 = .F.
    llAut = .F.
    llRet = .T.

    *-- Determinar conexao
    LOCAL lnConn
    IF (TYPE([pCta]) = [O])
        *-- Chamada com objeto conexao como 2o param (modo legado)
        IF (TYPE([pDat]) <> [O])
            llAut = pDat
        ENDIF
    ENDIF
    lnConn = IIF(TYPE([pCnx]) = [N] AND pCnx > 0, pCnx, gnConnHandle)

    IF NOT USED([crRecalculaS])
        SET NULL ON
        CREATE CURSOR crRecalculaS (Grupo C(10), Conta C(10), Moeda C(3), Data D NULL, OnLines N(1))
        SET NULL OFF
        INDEX ON Grupo + Conta + Moeda TAG GruConMoe
    ENDIF

    IF (TYPE([pGru]) = [C])
        *-- Modo registro: acumula entradas no cursor
        IF NOT SEEK(pGru + pCta + pMoe, [crRecalculaS], [GruConMoe])
            INSERT INTO crRecalculaS (Grupo, Conta, Moeda, Data) VALUES (pGru, pCta, pMoe, pDat)
        ENDIF
        IF (EMPTY(crRecalculaS.Data)) OR (NOT EMPTY(crRecalculaS.Data) AND crRecalculaS.Data > pDat)
            REPLACE Data WITH pDat IN crRecalculaS
        ENDIF
    ELSE
        *-- Modo processamento: recalcula saldos acumulados
        LOCAL lnConnW
        lnConnW = lnConn

        IF USED([crRecalculaS])
            WAIT WINDOW [Processando Rec] + CHR(225) + [lculo de Saldos...] NOWAIT

            SELECT crRecalculaS
            SET ORDER TO

            SQLEXEC(lnConn, [Select GrupoRecs, GrupoPags, ContaRecs, ContaPags From SigCdPam], [crAi1])
            GO TOP IN crAi1

            SELECT crRecalculaS
            SCAN
                IF (crRecalculaS.Grupo = crAi1.GrupoRecs AND crRecalculaS.Conta = crAi1.ContaRecs) OR ;
                   (crRecalculaS.Grupo = crAi1.GrupoPags AND crRecalculaS.Conta = crAi1.ContaPags)
                    DELETE
                ENDIF
            ENDSCAN

            SELECT crRecalculaS
            COUNT TO lnTot

            SELECT crRecalculaS
            GO TOP IN crRecalculaS
            lnNbq = 0
            IF (lnTot > 0)
                DO WHILE NOT EOF([crRecalculaS])
                    llSeg = .T.
                    lnVtf = 0
                    DO WHILE llSeg
                        lnFlt = SQLEXEC(lnConn, [Select CalcSalds From SigCdGcr Where Codigos = '] + crRecalculaS.Grupo + ['], [crAi2])
                        llSeg = (lnFlt < 1)
                        IF llSeg AND (pAut OR lnVtf = 3)
                            RETURN .F.
                        ENDIF
                        lnVtf = lnVtf + 1
                    ENDDO

                    llNtv = .F.
                    llNis = .F.
                    lcGrp = crRecalculaS.Grupo
                    lcCta = crRecalculaS.Conta
                    lcMoe = crRecalculaS.Moeda
                    ldDat = crRecalculaS.Data
                    lcKey = fUniqueIds()
                    lcGcm = lcGrp + lcCta + lcMoe

                    IF (crAi2.CalcSalds = 2 AND NOT llAut) OR pBkg
                        llNow = STR(IIF(crAi2.CalcSalds = 2, 2, 1), 1)

                        lcQry = [Insert Into SigOpCls (Grupos, Contas, Moedas, cIdChaves, GruConMoes, Datas, Usuars, OnLines) ] + ;
                                [Values ('] + lcGrp + [', '] + lcCta + [', '] + lcMoe + [', '] + lcKey + [', ] + ;
                                ['] + lcGcm + [', ?ldDat, '] + gc_4c_UsuarioLogado + [', ] + llNow + [)]

                        lnFlt = SQLEXEC(lnConn, lcQry)
                        IF (lnFlt < 1)
                            llNis = .T.
                        ENDIF
                        lnNbq = lnNbq + 1
                        SELECT crRecalculaS
                        IF llNis
                            IF (lnNbq >= 3)
                                RETURN .F.
                            ENDIF
                            SELECT crRecalculaS
                            LOOP
                        ENDIF
                        lnNbq = 0
                    ELSE
                        lcIdk = lcKey
                        llSeg = .T.
                        lnVtf = 0
                        DO WHILE llSeg
                            lnFlt = SQLEXEC(lnConn, [Select Cidchaves From SigMvSlc Where GruConMoes = '] + lcGcm + ['], [crAi3])
                            llSeg = (lnFlt < 1)
                            IF llSeg AND (pAut OR lnVtf = 3)
                                RETURN .F.
                            ENDIF
                            lnVtf = lnVtf + 1
                        ENDDO

                        SELECT crAi3
                        IF (RECCOUNT([crAi3]) = 0)
                            lcQry = [Insert Into SigMvSlc (Emps, Grupos, Contas, Moedas, Saldos, cIdChaves, GruConMoes) ] + ;
                                    [Values ('] + go_4c_Sistema.cCodEmpresa + [', '] + lcGrp + [', '] + lcCta + [', '] + lcMoe + [', ] + ;
                                    STR(0) + [, '] + lcKey + [', '] + lcGcm + [')]

                            lnFlt = SQLEXEC(lnConnW, lcQry)
                            IF (lnFlt < 1)
                                llNis = .T.
                                llNtv = .T.
                            ENDIF
                        ELSE
                            SELECT crAi3
                            lcIdk = crAi3.cIdChaves
                        ENDIF

                        lnFlt = SQLEXEC(lnConn, [Update SigMvSlc Set Saldos = Saldos Where cIdChaves = '] + lcIdk + ['])
                        IF (lnFlt < 1)
                            llNtv = .T.
                        ENDIF
                        lnNbq = lnNbq + 1
                        SELECT crRecalculaS
                        IF (llNtv OR llNis)
                            IF pAut OR (lnNbq >= 3)
                                RETURN .F.
                            ENDIF
                            SELECT crRecalculaS
                            LOOP
                        ENDIF
                        SELECT crRecalculaS
                        REPLACE OnLines WITH 1 IN crRecalculaS
                    ENDIF
                    SELECT crRecalculaS
                    SKIP IN crRecalculaS
                ENDDO
            ENDIF

            SELECT crRecalculaS
            SCAN
                IF (crRecalculaS.OnLines = 1)
                    ldDts = DTOC(NVL(crRecalculaS.Data, CTOD([01/01/1900])))

                    llOks = fProcessarS(crRecalculaS.Grupo, crRecalculaS.Conta, crRecalculaS.Moeda, crRecalculaS.Data, .F., lnConn, llAut, pAut, pObj)
                    IF NOT llOks
                        llRet = .F.
                        EXIT
                    ENDIF

                    llOks = fProcessarS(crRecalculaS.Grupo, crRecalculaS.Conta, crRecalculaS.Moeda, crRecalculaS.Data, .T., lnConn, llAut, pAut, pObj)
                    IF NOT llOks
                        llRet = .F.
                        EXIT
                    ENDIF

                    SELECT crRecalculaS
                    DELETE
                ENDIF
            ENDSCAN
            USE IN crRecalculaS
        ENDIF
    ENDIF
    WAIT CLEAR
    RETURN llRet
ENDFUNC

*==============================================================================
* fProcessarS - Processa recalculo de saldos (chamada por fRecalculaS)
* Portada de Framework\sigfuncs.PRG - adaptada para nova arquitetura
*
* Parametros:
*   pGru - Grupo
*   pCta - Conta
*   pMoe - Moeda
*   pDat - Data base
*   pTip - .F.=saldos normais, .T.=saldos conciliados
*   pCnx - Handle conexao (numerico)
*   pExt - Flag externo
*   pAut - Flag automatico
*   pFrm - Objeto form (opcional)
*
* Retorno: .T. se sucesso
*==============================================================================
FUNCTION fProcessarS(pGru, pCta, pMoe, pDat, pTip, pCnx, pExt, pAut, pFrm)
    LOCAL llOks, lcGcm, lnFlt, lnSde, lnErr, lnTot, lnSdo, lnSld, lnSlc
    LOCAL lcQry, lcEmp, lnConn
    PRIVATE llCon, ldDat

    lnConn = IIF(TYPE([pCnx]) = [N] AND pCnx > 0, pCnx, gnConnHandle)
    ldDat = fDtoSQL(pDat)
    lcGcm = pGru + pCta + pMoe
    lcEmp = SPACE(3)
    lnErr = 0
    lnSde = 0

    IF NOT pTip
        llCon = .F.

        lcQry = [Select Distinct Emps, GruConMoes, Valors, Saldos, Saldons, ] + ;
                [Concs, Opers, cIdChaves, Nopers, Datas ] + ;
                [From SigMvCcr ] + ;
                [Where GruConMoes = '] + lcGcm + [' And Datas >= ?ldDat]

        llOks = .T.
        lnTot = 0
        DO WHILE llOks
            lnErr = SQLEXEC(lnConn, lcQry, [crAj1])
            llOks = (lnErr < 1)
            IF llOks AND (pAut OR lnTot = 3)
                RETURN .F.
            ENDIF
            lnTot = lnTot + 1
        ENDDO

        lcQry = [Select Top 1 GruConMoes, Saldos, Saldons ] + ;
                [From SigMvCcr ] + ;
                [Where GruConMoes = '] + lcGcm + [' And Datas < ?ldDat ] + ;
                [Order By GruConMoes Asc, cIdChaves Desc]

        llOks = .T.
        lnTot = 0
        DO WHILE llOks
            lnSde = SQLEXEC(lnConn, lcQry, [crAj2])
            llOks = (lnSde < 1)
            IF llOks AND (pAut OR lnTot = 3)
                RETURN .F.
            ENDIF
            lnTot = lnTot + 1
        ENDDO
        WAIT CLEAR

        SELECT crAj2
        GO TOP IN crAj2
        lnSdo = crAj2.Saldos
        lnSld = crAj2.Saldons
        IF (lnErr > 0) AND (lnSde > 0)
            SELECT crAj1
            INDEX ON GruConMoes + cIdChaves TAG GruConMoe

            SELECT crAj1
            SET ORDER TO GruConMoe ASCENDING
            GO TOP IN crAj1
            lcEmp = crAj1.Emps
            SCAN
                SELECT crAj1
                IF (crAj1.Opers = [D])
                    lnSdo = lnSdo + crAj1.Valors
                    IF NOT crAj1.Concs
                        lnSld = lnSld + crAj1.Valors
                    ENDIF
                ELSE
                    lnSdo = lnSdo - crAj1.Valors
                    IF NOT crAj1.Concs
                        lnSld = lnSld - crAj1.Valors
                    ENDIF
                ENDIF

                lcQry = [Update SigMvCcr Set Saldos = ] + STR(lnSdo, 16, 2) + [ , Saldons = ] + STR(lnSld, 16, 2) + [ Where cIdChaves = '] + crAj1.cIdChaves + [']
                lnFlt = SQLEXEC(lnConn, lcQry)
                IF (lnFlt = -2)
                    RETURN .F.
                ENDIF
                IF (lnFlt < 1)
                    SELECT crAj1
                    IF (crAj1.Opers <> [D])
                        lnSdo = lnSdo + crAj1.Valors
                        IF NOT crAj1.Concs
                            lnSld = lnSld + crAj1.Valors
                        ENDIF
                    ELSE
                        lnSdo = lnSdo - crAj1.Valors
                        IF NOT crAj1.Concs
                            lnSld = lnSld - crAj1.Valors
                        ENDIF
                    ENDIF
                    LOOP
                ENDIF

                IF (SQLEXEC(lnConn, [Select Count(*) as Soma From SigMvCcr Where cIdChaves = '] + crAj1.cIdChaves + ['], [crAj3]) < 1) OR (crAj3.Soma = 0)
                    SELECT crAj1
                    IF (crAj1.Opers <> [D])
                        lnSdo = lnSdo + crAj1.Valors
                        IF NOT crAj1.Concs
                            lnSld = lnSld + crAj1.Valors
                        ENDIF
                    ELSE
                        lnSdo = lnSdo - crAj1.Valors
                        IF NOT crAj1.Concs
                            lnSld = lnSld - crAj1.Valors
                        ENDIF
                    ENDIF
                    LOOP
                ENDIF
            ENDSCAN

            lnFlt = SQLEXEC(lnConn, [Update SigMvSlc Set Saldos = ] + STR(lnSdo, 14, 2) + [, Emps = '] + lcEmp + [' Where GruConMoes = '] + lcGcm + ['])
            IF (lnFlt < 1)
                RETURN .F.
            ENDIF
            IF (lnSdo = 0)
                IF (SQLEXEC(lnConn, [Select Count(*) as Soma From SigMvCcr Where GruConMoes = '] + lcGcm + ['], [crAj5]) > 0) AND (crAj5.Soma = 0)
                    lnFlt = SQLEXEC(lnConn, [Delete From SigMvSlc Where GruConMoes = '] + lcGcm + ['])
                    IF (lnFlt = -2)
                        RETURN .F.
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ELSE
        llCon = .T.

        lcQry = [Select Distinct GruConMoes, Valors, Saldos, Saldons, Concs, ] + ;
                [Opers, cIdChaves, Saldocs, DataConcs, Nopers ] + ;
                [From SigMvCcr ] + ;
                [Where GruConMoes = '] + lcGcm + [' And ] + ;
                [DataConcs >= ?ldDat And ] + ;
                [Concs = ?llCon]

        llOks = .T.
        lnTot = 0
        DO WHILE llOks
            lnErr = SQLEXEC(lnConn, lcQry, [crAj1])
            llOks = (lnErr < 1)
            IF llOks AND (pAut OR lnTot = 3)
                RETURN .F.
            ENDIF
            lnTot = lnTot + 1
        ENDDO

        lcQry = [Select Top 1 GruConMoes, Saldocs ] + ;
                [From SigMvCcr ] + ;
                [Where GruConMoes = '] + lcGcm + [' And ] + ;
                [DataConcs < ?ldDat And ] + ;
                [Concs = ?llCon ] + ;
                [Order By GruConMoes Asc, DataConcs Desc, cIdChaves Desc]

        llOks = .T.
        lnTot = 0
        DO WHILE llOks
            lnSde = SQLEXEC(lnConn, lcQry, [crAj6])
            llOks = (lnSde < 1)
            IF llOks AND (pAut OR lnTot = 3)
                RETURN .F.
            ENDIF
            lnTot = lnTot + 1
        ENDDO

        SELECT crAj6
        GO TOP IN crAj6
        lnSlc = crAj6.Saldocs
        IF (lnErr > 0) AND (lnSde > 0)
            SELECT crAj1
            INDEX ON GruConMoes + DTOS(DataConcs) + cIdChaves TAG GruConMoec FOR Concs
            SELECT crAj1
            SET ORDER TO GruConMoec ASCENDING
            GO TOP IN crAj1
            SCAN
                SELECT crAj1
                IF crAj1.Concs
                    IF (crAj1.Opers = [D])
                        lnSlc = lnSlc + crAj1.Valors
                    ELSE
                        lnSlc = lnSlc - crAj1.Valors
                    ENDIF
                ENDIF

                lnFlt = SQLEXEC(lnConn, [Update SigMvCcr Set Saldocs = ] + STR(lnSlc, 16, 2) + [ Where cIdChaves = '] + crAj1.cIdChaves + ['])
                IF (lnFlt = -2)
                    RETURN .F.
                ENDIF
                IF (lnFlt < 1)
                    SELECT crAj1
                    IF crAj1.Concs
                        IF (crAj1.Opers <> [D])
                            lnSlc = lnSlc + crAj1.Valors
                        ELSE
                            lnSlc = lnSlc - crAj1.Valors
                        ENDIF
                    ENDIF
                    LOOP
                ENDIF

                IF (SQLEXEC(lnConn, [Select Count(*) as Soma From SigMvCcr Where cIdChaves = '] + crAj1.cIdChaves + ['], [crAj4]) < 1) OR (crAj4.Soma = 0)
                    SELECT crAj1
                    IF crAj1.Concs
                        IF (crAj1.Opers <> [D])
                            lnSlc = lnSlc + crAj1.Valors
                        ELSE
                            lnSlc = lnSlc - crAj1.Valors
                        ENDIF
                    ENDIF
                    LOOP
                ENDIF
            ENDSCAN
        ENDIF
    ENDIF
    WAIT CLEAR
    IF USED([crAj1])
        USE IN crAj1
    ENDIF
    IF USED([crAj2])
        USE IN crAj2
    ENDIF
    IF USED([crAj3])
        USE IN crAj3
    ENDIF
    IF USED([crAj4])
        USE IN crAj4
    ENDIF
    IF USED([crAj5])
        USE IN crAj5
    ENDIF
    IF USED([crAj6])
        USE IN crAj6
    ENDIF
    RETURN .T.
ENDFUNC

*------------------------------------------------------------------------------
* fAltBar2de5 - Codifica string numerica para fonte de codigo de barras I2of5
*   Intercalado 2 de 5 (Interleaved 2 of 5): pares de digitos codificados
*   simultaneamente em barras e espacos. Resultado compativel com fontes
*   barcode I2of5/Int2of5 que reconhecem "(" como start e ")" como stop.
*
* Parametros: par_cDados - string numerica a codificar (ex: "00012345678901")
* Retorno: string no formato "(dados)" para renderizacao pela fonte barcode
*------------------------------------------------------------------------------
FUNCTION fAltBar2de5(par_cDados)
    LOCAL loc_cDados
    loc_cDados = ALLTRIM(STRTRAN(par_cDados, " ", ""))
    IF EMPTY(loc_cDados)
        RETURN ""
    ENDIF
    IF MOD(LEN(loc_cDados), 2) <> 0
        loc_cDados = "0" + loc_cDados
    ENDIF
    RETURN "(" + loc_cDados + ")"
ENDFUNC

*------------------------------------------------------------------------------
* fBuscarCotacao - Retorna taxa de cambio de uma moeda para a data informada
*   Tabela: SigCdCot (cmoes, datas, horas, valos)
*   Terceiro parametro (conn) aceito por compatibilidade mas usa gnConnHandle global.
*   Retorna 1.0 se moeda vazia, "R$", ou nao encontrada.
*
* Parametros: par_cMoeda - codigo da moeda (ex: "USD", "EUR")
*             par_dData  - data de referencia (tipo D ou .NULL. = hoje)
*             par_xConn  - aceito por compatibilidade (ignorado; usa gnConnHandle)
* Retorno: taxa numerica (1.0 se nao encontrada)
*------------------------------------------------------------------------------
FUNCTION fBuscarCotacao(par_cMoeda, par_dData, par_xConn)
    LOCAL loc_nTaxa, loc_cSQL, loc_nResult, loc_cMoeda, loc_cFiltroData

    loc_nTaxa  = 1.0
    loc_cMoeda = ALLTRIM(NVL(par_cMoeda, ""))

    IF EMPTY(loc_cMoeda) OR UPPER(ALLTRIM(loc_cMoeda)) = "R"
        RETURN loc_nTaxa
    ENDIF

    IF VARTYPE(par_dData) = "D" AND !EMPTY(par_dData)
        loc_cFiltroData = "datas <= DATEADD(day, 1, " + FormatarDataSQL(par_dData) + ")"
    ELSE
        loc_cFiltroData = "datas <= GETDATE()"
    ENDIF

    loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot " + ;
               "WHERE cmoes = " + EscaparSQL(loc_cMoeda) + ;
               " AND " + loc_cFiltroData + ;
               " ORDER BY datas DESC, horas DESC"

    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_fBusCot")
    IF loc_nResult > 0 AND !EOF("cursor_4c_fBusCot")
        SELECT cursor_4c_fBusCot
        IF NVL(valos, 0) > 0
            loc_nTaxa = valos
        ENDIF
    ENDIF

    IF USED("cursor_4c_fBusCot")
        USE IN cursor_4c_fBusCot
    ENDIF

    RETURN loc_nTaxa
ENDFUNC

*==============================================================================
* FUNCTION fLimpaTexto
* Remove acentos e caracteres especiais para gerar arquivos CNAB (ASCII puro)
* Par: par_cTexto - texto a limpar
* Ret: texto sem acentuacao
*==============================================================================
FUNCTION fLimpaTexto(par_cTexto)
    LOCAL loc_cTexto
    loc_cTexto = NVL(par_cTexto, "")

    *-- Minusculas acentuadas
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(224)+CHR(225)+CHR(226)+CHR(227)+CHR(228), "aaaaa")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(232)+CHR(233)+CHR(234)+CHR(235), "eeee")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(236)+CHR(237)+CHR(238)+CHR(239), "iiii")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(242)+CHR(243)+CHR(244)+CHR(245)+CHR(246), "ooooo")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(249)+CHR(250)+CHR(251)+CHR(252), "uuuu")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(231), "c")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(241), "n")

    *-- Maiusculas acentuadas
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(192)+CHR(193)+CHR(194)+CHR(195)+CHR(196), "AAAAA")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(200)+CHR(201)+CHR(202)+CHR(203), "EEEE")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(204)+CHR(205)+CHR(206)+CHR(207), "IIII")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(210)+CHR(211)+CHR(212)+CHR(213)+CHR(214), "OOOOO")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(217)+CHR(218)+CHR(219)+CHR(220), "UUUU")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(199), "C")
    loc_cTexto = CHRTRAN(loc_cTexto, CHR(209), "N")

    RETURN loc_cTexto
ENDFUNC

*==============================================================================
* FUNCTION fGerUniqueKey
* Gera numero sequencial unico por prefixo de chave (escopo de sessao)
* Par: par_cChave - prefixo identificador do contador (ex: "ITAUENV", "BRNOSSONUM")
* Ret: numero sequencial (numerico)
* Obs: BRNOSSONUM semente = MAX(nopers) de SigMvCcr para continuidade
*==============================================================================
FUNCTION fGerUniqueKey(par_cChave)
    LOCAL loc_cChave, loc_i, loc_nNovo
    loc_cChave = UPPER(ALLTRIM(NVL(par_cChave, "")))

    IF TYPE('gnUniqueKeyLen_4c') = 'U'
        PUBLIC gnUniqueKeyLen_4c
        gnUniqueKeyLen_4c = 0
        PUBLIC ga_UniqueKeys_4c[1, 2]
        ga_UniqueKeys_4c[1, 1] = ""
        ga_UniqueKeys_4c[1, 2] = 0
    ENDIF

    *-- Busca chave existente e incrementa
    FOR loc_i = 1 TO gnUniqueKeyLen_4c
        IF UPPER(ALLTRIM(ga_UniqueKeys_4c[loc_i, 1])) = loc_cChave
            ga_UniqueKeys_4c[loc_i, 2] = ga_UniqueKeys_4c[loc_i, 2] + 1
            RETURN ga_UniqueKeys_4c[loc_i, 2]
        ENDIF
    ENDFOR

    *-- Nova chave: define semente inicial
    loc_nNovo = 1
    IF loc_cChave = "BRNOSSONUM" AND TYPE('gnConnHandle') = 'N' AND gnConnHandle > 0
        LOCAL loc_nSeedSQL
        loc_nSeedSQL = SQLEXEC(gnConnHandle, "SELECT ISNULL(MAX(nopers),0) AS maxval FROM SigMvCcr", "cursor_4c_fGUKSeed")
        IF loc_nSeedSQL > 0 AND !EOF("cursor_4c_fGUKSeed")
            loc_nNovo = IIF(cursor_4c_fGUKSeed.maxval > 0, cursor_4c_fGUKSeed.maxval + 1, 1)
        ENDIF
        IF USED("cursor_4c_fGUKSeed")
            USE IN cursor_4c_fGUKSeed
        ENDIF
    ENDIF

    *-- Adiciona nova entrada ao array
    gnUniqueKeyLen_4c = gnUniqueKeyLen_4c + 1
    IF ALEN(ga_UniqueKeys_4c, 1) < gnUniqueKeyLen_4c
        DIMENSION ga_UniqueKeys_4c[gnUniqueKeyLen_4c, 2]
    ENDIF
    ga_UniqueKeys_4c[gnUniqueKeyLen_4c, 1] = par_cChave
    ga_UniqueKeys_4c[gnUniqueKeyLen_4c, 2] = loc_nNovo

    RETURN loc_nNovo
ENDFUNC

*==============================================================================
* FUNCTION fGerMascara
* Formata numero sequencial como mascara de 10 digitos com zeros a esquerda
* Par: par_nNum - numero inteiro gerado por fGerUniqueKey
* Ret: string de 10 caracteres (ex: "0000000001")
*==============================================================================
FUNCTION fGerMascara(par_nNum)
    RETURN PADL(ALLTRIM(STR(INT(NVL(par_nNum, 0)))), 10, "0")
ENDFUNC
