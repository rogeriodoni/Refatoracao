* ProbeColunasPickerFpg782.prg
* Prova que zerar this_nColunas e remontar com mAddColuna produz as 4 colunas
* com os titulos/mascaras do legado (AddColuna de Get_fpg.Valid). NAO chama
* Show() - picker modal travaria o processo headless.
SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\automation\_probe782colpicker.txt"

PUBLIC gnConnHandle, gb_4c_ModoTeste
gnConnHandle    = 0
gb_4c_ModoTeste = .T.

DO (ADDBS("C:\4c\projeto\app\start") + "config.prg")
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE

LOCAL loc_oBusca, loc_cMsg, loc_nI, loc_oErro
loc_cMsg = ""

CREATE CURSOR cursor_4c_FormasPagamento ;
    (fpags C(10), descrs C(40), moefpgs C(5), fparcs N(2,0), situas C(1))
INSERT INTO cursor_4c_FormasPagamento (fpags, descrs, moefpgs, fparcs) ;
    VALUES ("DINHEIRO", "A VISTA", "R$", 1)
SELECT cursor_4c_FormasPagamento
INDEX ON fpags TAG fpags
GO TOP

TRY
    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")

    loc_oBusca.DefinirCursor("cursor_4c_FormasPagamento", "fpags", "descrs", ;
        "Cadastro de Forma de Pagamento")
    loc_cMsg = loc_cMsg + "APOS DefinirCursor: nColunas=" + ;
        TRANSFORM(loc_oBusca.this_nColunas) + CHR(13) + CHR(10)

    loc_oBusca.this_nColunas = 0
    loc_oBusca.mAddColuna("fpags", "", "C" + CHR(243) + "digo")
    loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
    loc_oBusca.mAddColuna("moefpgs", "XXXXX", "Moeda")
    loc_oBusca.mAddColuna("fparcs", "99", " #")

    loc_cMsg = loc_cMsg + "APOS remontagem: nColunas=" + ;
        TRANSFORM(loc_oBusca.this_nColunas) + CHR(13) + CHR(10)

    FOR loc_nI = 1 TO loc_oBusca.this_nColunas
        loc_cMsg = loc_cMsg + "  [" + TRANSFORM(loc_nI) + "] campo=[" + ;
            loc_oBusca.this_aColunas[loc_nI, 1] + "] masc=[" + ;
            loc_oBusca.this_aColunas[loc_nI, 2] + "] titulo=[" + ;
            loc_oBusca.this_aColunas[loc_nI, 3] + "]" + CHR(13) + CHR(10)
    ENDFOR

    loc_cMsg = loc_cMsg + "CampoCodigo=[" + loc_oBusca.this_cCampoCodigo + ;
        "] CampoDescricao=[" + loc_oBusca.this_cCampoDescricao + ;
        "] Cursor=[" + loc_oBusca.this_cCursorDestino + "]" + CHR(13) + CHR(10)
    loc_cMsg = loc_cMsg + "SEEK exato DINHEIRO = " + ;
        TRANSFORM(SEEK("DINHEIRO", "cursor_4c_FormasPagamento", "fpags")) + CHR(13) + CHR(10)
    loc_cMsg = loc_cMsg + "SEEK inexistente XX = " + ;
        TRANSFORM(SEEK("XX", "cursor_4c_FormasPagamento", "fpags")) + CHR(13) + CHR(10)
    loc_cMsg = loc_cMsg + "SET('EXACT')=" + SET("EXACT") + CHR(13) + CHR(10)

    loc_oBusca.Release()
    loc_cMsg = loc_cMsg + "OK" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cMsg = loc_cMsg + "ERRO: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cMsg, OUTFILE)
QUIT
