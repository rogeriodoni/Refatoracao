*==============================================================================
* VERIFICAR_SCHEMA.PRG
* Consulta o schema das tabelas para diagnostico
*==============================================================================

PROCEDURE VerificarSchemaSigCdPro()
    LOCAL loc_cSQL, loc_nResultado, loc_nArquivo

    * Consulta colunas da tabela SigCdPro
    loc_cSQL = "SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE " + ;
               "FROM INFORMATION_SCHEMA.COLUMNS " + ;
               "WHERE TABLE_NAME = 'SigCdPro' " + ;
               "AND COLUMN_NAME IN ('cgrus', 'cunis', 'cunips', 'linhas', 'colecoes', 'ifors', 'cpros') " + ;
               "ORDER BY COLUMN_NAME"

    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Schema")

    IF loc_nResultado < 0
        MESSAGEBOX("Erro ao consultar schema", 16, "Erro")
        RETURN
    ENDIF

    * Grava resultado em arquivo
    loc_nArquivo = FCREATE("C:\4c\schema_sigcdpro.txt")
    IF loc_nArquivo > 0
        FWRITE(loc_nArquivo, "=== SCHEMA SigCdPro ===" + CHR(13) + CHR(10))
        FWRITE(loc_nArquivo, CHR(13) + CHR(10))

        SELECT cursor_4c_Schema
        SCAN
            FWRITE(loc_nArquivo, "Coluna: " + ALLTRIM(cursor_4c_Schema.COLUMN_NAME) + CHR(13) + CHR(10))
            FWRITE(loc_nArquivo, "  Tipo: " + ALLTRIM(cursor_4c_Schema.DATA_TYPE) + CHR(13) + CHR(10))
            IF !ISNULL(cursor_4c_Schema.CHARACTER_MAXIMUM_LENGTH)
                FWRITE(loc_nArquivo, "  Tamanho: " + TRANSFORM(cursor_4c_Schema.CHARACTER_MAXIMUM_LENGTH) + CHR(13) + CHR(10))
            ENDIF
            FWRITE(loc_nArquivo, CHR(13) + CHR(10))
        ENDSCAN

        FCLOSE(loc_nArquivo)
        MESSAGEBOX("Schema gravado em C:\4c\schema_sigcdpro.txt", 64, "OK")
    ENDIF

    IF USED("cursor_4c_Schema")
        USE IN cursor_4c_Schema
    ENDIF
ENDPROC
