*==============================================================================
* CRIARNOVOFRX.PRG
* Cria novo FRX baseado na estrutura do legado, com nomenclatura padronizada
*==============================================================================

LOCAL loc_cFRXLegado, loc_cFRXNovo, loc_cFRTLegado, loc_cFRTNovo

loc_cFRXLegado = "C:\4c\task4\SigRePlc.frx"
loc_cFRTLegado = "C:\4c\task4\SigRePlc.FRT"
loc_cFRXNovo = "C:\4c\projeto\app\reports\RelPlanoContas.frx"
loc_cFRTNovo = "C:\4c\projeto\app\reports\RelPlanoContas.frt"

IF !FILE(loc_cFRXLegado)
    MESSAGEBOX("FRX legado nao encontrado", 16, "Erro")
    RETURN
ENDIF

* Remover arquivos existentes
IF FILE(loc_cFRXNovo)
    DELETE FILE (loc_cFRXNovo)
ENDIF
IF FILE(loc_cFRTNovo)
    DELETE FILE (loc_cFRTNovo)
ENDIF

WAIT WINDOW "Copiando FRX legado..." NOWAIT

* Copiar arquivos primeiro
COPY FILE (loc_cFRXLegado) TO (loc_cFRXNovo)
IF FILE(loc_cFRTLegado)
    COPY FILE (loc_cFRTLegado) TO (loc_cFRTNovo)
ENDIF

WAIT WINDOW "Atualizando variaveis..." NOWAIT

* Abrir novo FRX para atualizar expressoes
USE (loc_cFRXNovo) EXCLUSIVE

SCAN
    IF !EMPTY(expr)
        loc_cExpr = expr

        * Substituir variaveis legadas
        loc_cExpr = STRTRAN(loc_cExpr, "gcLogoRel", "gc_4c_LogoRelatorio")
        loc_cExpr = STRTRAN(loc_cExpr, "gcCabRel", "gc_4c_CabecalhoRelatorio")
        loc_cExpr = STRTRAN(loc_cExpr, "gcRodRel", "gc_4c_RodapeRelatorio")
        loc_cExpr = STRTRAN(loc_cExpr, "gcUsuarioLogado", "gc_4c_UsuarioLogado")
        loc_cExpr = STRTRAN(loc_cExpr, "goSistema.", "go_4c_Sistema.")

        REPLACE expr WITH loc_cExpr
    ENDIF
ENDSCAN

USE

WAIT CLEAR
MESSAGEBOX("FRX atualizado com sucesso!" + CHR(13) + loc_cFRXNovo, 64, "Sucesso")

RETURN
