*==============================================================================
* impexceldriver.prg - Wrapper de compatibilidade para a funcao GLOBAL
* ImpExcelDriver() do framework legado Fortyus (SIGFUNCS.PRG), que nao veio
* no acervo migrado - nao ha o fonte dela em lugar nenhum do repositorio.
*
* Chamada direta (fora de VCX, direto do codigo do form legado):
*
*     FormSIGPRVTX.Processamento:  If Not ImpExcelDriver(lcArquivo)
*     FormDES.ImportaPlan:         If !ImpExcelDriver(loc_lcArq, "Cota Desconto")
*
* Nome desconhecido seguido de "(" nao eh erro de compilacao (regra #13 do
* CLAUDE.md) - o VFP procura 'impexceldriver.prg' no PATH e so estoura em
* RUNTIME, ao clicar o botao: File 'impexceldriver.prg' does not exist.
*
* CONTRATO (determinado pelos call sites, nao chutado)
* ------------------------------------------------------
* Os dois call sites exigem que a funcao:
*   1. Receba o caminho do arquivo .xls (par_cArquivo) e, opcionalmente, o
*      nome da aba a ler (par_cAba) - sem par_cAba, le a 1a aba da planilha.
*   2. Abra o arquivo e deixe o resultado no cursor GLOBAL "xlResults",
*      ABERTO (quem chama fecha com USE IN xlResults - nao fechar aqui).
*   3. Uma coluna do cursor por coluna de dado da planilha:
*        - FormSIGPRVTX le por NOME (Planilha.skuid, Planilha.nomesku, ...),
*          entao o titulo da linha 1 da planilha TEM de virar o nome do
*          campo no cursor.
*        - FormDES le por POSICAO (FIELD(1), FIELD(2), FIELD(3)), que
*          continua funcionando igual com colunas nomeadas por titulo.
*   4. Retorne .T. em sucesso (com xlResults aberto) e .F. em qualquer falha
*      (arquivo inexistente, aba inexistente, planilha vazia, Excel nao
*      instalado) - SEM exibir mensagem, porque os DOIS chamadores JA
*      exibem o proprio MsgAviso/MsgErro quando recebem .F. (duplicar
*      mensagem aqui criaria dialogo repetido).
*
* IMPLEMENTACAO
* -------------
* Usa automacao COM do Excel (Excel.Application), com Visible=.F. e
* DisplayAlerts=.F. para nao travar o pipeline unattended (regra #6) com
* dialogo modal do proprio Excel (ex.: aviso de macro, formato antigo).
* A linha 1 da planilha fornece os titulos de coluna; linhas 2..N sao os
* dados. Titulos sao sanitizados para nome de campo VFP valido (letra
* inicial, so alfanumerico/underscore, max 10 chars - limite classico de
* DBF/cursor) e desambiguados se repetidos.
*
* Celulas vem sempre como CHARACTER no cursor resultado (TRANSFORM), porque
* os dois chamadores ja tratam o valor com Type()/InList('C','M') + Val()
* como fallback para numerico - um cursor 100% character preserva esse
* comportamento sem regressao.
*
* ATENCAO: nao foi possivel comparar com o fonte legado (SIGFUNCS.PRG nao veio
* no acervo). Se aparecer divergencia de borda (aba sem titulo na linha 1,
* planilha .xlsx em vez de .xls, celula com formula) o criterio a valer eh o
* do legado - mesma ressalva de fvalidarcpf.prg/fvalidarcnpj.prg.
*
* Origem: Erro200 (2026-10-20, FormSIGPRVTX "Cadastro de Testes" - fase 6,
* Processar nunca funcionava porque a funcao nunca existiu no acervo).
*==============================================================================
LPARAMETERS par_cArquivo, par_cAba

LOCAL loc_lSucesso, loc_oExcel, loc_oLivro, loc_oAba, loc_oErro, loc_lTemDados
LOCAL loc_nLinhas, loc_nCols, loc_nCol, loc_nLin, loc_cCampos
LOCAL loc_cNomeCol, loc_cNomeFinal, loc_nDup, loc_cValor
LOCAL loc_cBruto, loc_nI, loc_cChar, loc_cLimpo
LOCAL ARRAY loc_aNomes(1)

loc_lSucesso = .F.
loc_oExcel   = .NULL.

IF VARTYPE(par_cArquivo) <> "C" OR EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
    RETURN .F.
ENDIF

IF USED("xlResults")
    USE IN xlResults
ENDIF

TRY
    loc_oExcel = CREATEOBJECT("Excel.Application")
    loc_oExcel.Visible       = .F.
    loc_oExcel.DisplayAlerts = .F.

    loc_oLivro = loc_oExcel.Workbooks.Open(par_cArquivo, .F., .T.)

    IF VARTYPE(par_cAba) = "C" AND !EMPTY(par_cAba)
        loc_oAba = loc_oLivro.Worksheets.Item(ALLTRIM(par_cAba))
    ELSE
        loc_oAba = loc_oLivro.Worksheets.Item(1)
    ENDIF

    loc_nLinhas = loc_oAba.UsedRange.Rows.Count
    loc_nCols   = loc_oAba.UsedRange.Columns.Count

    *-- so cabecalho (ou vazia) - nao ha dado para importar
    loc_lTemDados = (loc_nLinhas >= 2 AND loc_nCols >= 1)

    IF loc_lTemDados
        *-- Monta a lista de campos a partir da linha 1 (titulos das
        *-- colunas), sanitizando para nome de campo VFP valido e
        *-- desambiguando repeticao
        DIMENSION loc_aNomes(loc_nCols)
        loc_cCampos = ""
        FOR loc_nCol = 1 TO loc_nCols
            loc_cBruto = ALLTRIM(TRANSFORM(loc_oAba.Cells(1, loc_nCol).Value))

            *-- sanitiza o titulo para nome de campo VFP valido: so
            *-- [A-Za-z0-9_], max 10 chars (limite classico de cursor/DBF)
            loc_cLimpo = ""
            FOR loc_nI = 1 TO LEN(loc_cBruto)
                loc_cChar = SUBSTR(loc_cBruto, loc_nI, 1)
                IF (loc_cChar >= "A" AND loc_cChar <= "Z") OR ;
                   (loc_cChar >= "a" AND loc_cChar <= "z") OR ;
                   (loc_cChar >= "0" AND loc_cChar <= "9") OR loc_cChar = "_"
                    loc_cLimpo = loc_cLimpo + loc_cChar
                ENDIF
            ENDFOR
            loc_cLimpo = LEFT(loc_cLimpo, 10)

            IF EMPTY(loc_cLimpo) OR (loc_cLimpo >= "0" AND loc_cLimpo <= "9")
                loc_cLimpo = "FIELD" + TRANSFORM(loc_nCol)
            ENDIF

            loc_cNomeCol   = UPPER(loc_cLimpo)
            loc_cNomeFinal = loc_cNomeCol
            loc_nDup = 1
            DO WHILE ASCAN(loc_aNomes, loc_cNomeFinal, 1, loc_nCol - 1) > 0
                loc_nDup = loc_nDup + 1
                loc_cNomeFinal = LEFT(loc_cNomeCol, 8) + TRANSFORM(loc_nDup)
            ENDDO

            loc_aNomes(loc_nCol) = loc_cNomeFinal
            loc_cCampos = loc_cCampos + loc_cNomeFinal + " C(100)" + ;
                IIF(loc_nCol < loc_nCols, ",", "")
        ENDFOR

        CREATE CURSOR xlResults (&loc_cCampos)

        FOR loc_nLin = 2 TO loc_nLinhas
            APPEND BLANK IN xlResults
            FOR loc_nCol = 1 TO loc_nCols
                loc_cValor = ALLTRIM(TRANSFORM(loc_oAba.Cells(loc_nLin, loc_nCol).Value))
                REPLACE (loc_aNomes(loc_nCol)) WITH loc_cValor IN xlResults
            ENDFOR
        ENDFOR

        GO TOP IN xlResults
    ENDIF

    loc_oLivro.Close(.F.)
    loc_oExcel.Quit()
    loc_oExcel = .NULL.

    loc_lSucesso = loc_lTemDados
CATCH TO loc_oErro
    IF VARTYPE(loc_oExcel) = "O"
        TRY
            loc_oExcel.Quit()
        CATCH
        ENDTRY
        loc_oExcel = .NULL.
    ENDIF

    IF TYPE("gc_4c_CaminhoBase") = "C"
        STRTOFILE("[" + TTOC(DATETIME()) + "] " + loc_oErro.Message + CHR(13) + CHR(10) + ;
                  "  Arquivo: " + par_cArquivo + CHR(13) + CHR(10), ;
                  ADDBS(gc_4c_CaminhoBase) + "ImpExcelDriver_Erro.log", 1)
    ENDIF

    loc_lSucesso = .F.
ENDTRY

RETURN loc_lSucesso
