*==============================================================================
* TesteFormCargo.prg
* Teste automatizado para verificar inicializacao do FormCargo
*
* Uso: DO TesteFormCargo.prg
*==============================================================================
CLEAR
SET TALK OFF
SET SAFETY OFF

LOCAL loc_lSucesso, loc_oForm, loc_cErro
loc_lSucesso = .F.
loc_cErro = ""

*-- Flag para pular verificacao de conexao
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.

TRY
    ? "=== Teste FormCargo ==="
    ? ""

    *-- Carregar dependencias
    ? "1. Carregando config.prg..."
    CD C:\4c\projeto\app\start
    DO config.prg
    ? "   OK"

    *-- Tentar criar o form
    ? "2. Criando FormCargo..."
    loc_oForm = CREATEOBJECT("FormCargo")
    ? "   OK - Form criado"

    *-- Verificar propriedades basicas
    ? "3. Verificando propriedades..."

    IF TYPE("loc_oForm.pgf_4c_Paginas") != "O"
        loc_cErro = "PageFrame nao encontrado"
        THROW loc_cErro
    ENDIF
    ? "   - PageFrame: OK"

    IF TYPE("loc_oForm.this_oBusinessObject") != "O"
        loc_cErro = "BusinessObject nao encontrado"
        THROW loc_cErro
    ENDIF
    ? "   - BusinessObject: OK"

    *-- Verificar grid de centro de custo
    IF TYPE("loc_oForm.pgf_4c_Paginas.Page2.grd_4c_CentroCusto") != "O"
        loc_cErro = "Grid CentroCusto nao encontrado"
        THROW loc_cErro
    ENDIF
    ? "   - Grid CentroCusto: OK"

    *-- Verificar cursor
    IF !USED("cursor_4c_CCLocal")
        loc_cErro = "Cursor cursor_4c_CCLocal nao existe"
        THROW loc_cErro
    ENDIF
    ? "   - Cursor CCLocal: OK"

    *-- Verificar colunas do grid
    LOCAL loc_oGrid
    loc_oGrid = loc_oForm.pgf_4c_Paginas.Page2.grd_4c_CentroCusto

    IF loc_oGrid.ColumnCount < 4
        loc_cErro = "Grid deve ter 4 colunas, tem " + TRANSFORM(loc_oGrid.ColumnCount)
        THROW loc_cErro
    ENDIF
    ? "   - Colunas do Grid: OK (" + TRANSFORM(loc_oGrid.ColumnCount) + " colunas)"

    *-- Verificar ControlSource das colunas
    IF EMPTY(loc_oGrid.Column1.ControlSource)
        loc_cErro = "Column1.ControlSource vazio"
        THROW loc_cErro
    ENDIF
    ? "   - Column1.ControlSource: " + loc_oGrid.Column1.ControlSource

    *-- Sucesso!
    loc_lSucesso = .T.
    ? ""
    ? "=== TESTE PASSOU ==="

CATCH TO loException
    ? ""
    ? "=== TESTE FALHOU ==="
    ? "Linha: " + TRANSFORM(loException.LineNo)
    ? "Erro: " + loException.Message
    IF !EMPTY(loc_cErro)
        ? "Detalhe: " + loc_cErro
    ENDIF
FINALLY
    *-- Limpar
    IF VARTYPE(loc_oForm) = "O" AND !ISNULL(loc_oForm)
        loc_oForm.Release()
    ENDIF

    *-- Remover flag de teste
    RELEASE gb_4c_ValidandoUI
ENDTRY

? ""
? "Pressione qualquer tecla para sair..."
WAIT ""

RETURN loc_lSucesso
