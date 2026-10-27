*==============================================================================
* ProbeFea254.prg - Erro254: "Erro em AbrirLookupGrupo: Variable 'BALCODIGO'
* is not found." ao digitar o Grupo na pagina Dados do FormFea.
*
* BalCodigo / BalNome / BalDescrs sao nomes de TAG de INDICE no legado
* (Index On Codigos Tag BalCodigo), nunca colunas. mAddColuna() vira
* ControlSource = "<cursor>.<campo>", entao passar o nome do TAG estoura.
*
* MEDE em VFP9, sem banco: recria TmpGccr/TmpCli/TmpPro com exatamente as
* colunas que o SELECT de CarregarDadosAuxiliares produz, e verifica que
*   1) todo <cursor>.<coluna> citado no .prg resolve
*   2) o ControlSource que mAddColuna monta para cada lookup resolve
*   3) os TAGs continuam existindo para o SET ORDER TO / SEEK
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
#DEFINE OUT "C:\4c\automation\probe_fea254.txt"

LOCAL loc_nFalhas, loc_oE, loc_nI, loc_cExpr, loc_oF, loc_oG
LOCAL ARRAY loc_aRef[16]
loc_nFalhas = 0
STRTOFILE("=== PROBE Erro254 - lookups do FormFea ===" + CHR(13)+CHR(10), OUT)

TRY
    *-- colunas EXATAS dos SELECT de CarregarDadosAuxiliares (= legado)
    CREATE CURSOR TmpGccr (Codigos C(10), Descrs C(40), UnifBals N(1), GruFals C(10))
    INDEX ON Codigos TAG BalCodigo
    INDEX ON Descrs  TAG BalDescrs
    SET ORDER TO BalCodigo

    CREATE CURSOR TmpCli (IClis C(10), RClis C(40), Grupos C(10), PagFals C(10), ;
                          RecFals C(10), GruFals C(10), Inativas N(1))
    INDEX ON IClis TAG BalCodigo
    INDEX ON RClis TAG BalNome
    SET ORDER TO BalCodigo

    CREATE CURSOR TmpPro (CPros C(14), DPros C(40), CUnis C(3), Cgrus C(10), ;
                          Varias N(1), Custofs N(12,3), MoeCusfs C(3), ;
                          MatPrincs C(14), cUniPs C(3))

    *-- 1) toda coluna citada no .prg
    loc_aRef[1]  = "TmpGccr.Codigos"
    loc_aRef[2]  = "TmpGccr.Descrs"
    loc_aRef[3]  = "TmpGccr.UnifBals"
    loc_aRef[4]  = "TmpCli.IClis"
    loc_aRef[5]  = "TmpCli.RClis"
    loc_aRef[6]  = "TmpCli.PagFals"
    loc_aRef[7]  = "TmpCli.RecFals"
    loc_aRef[8]  = "TmpPro.CUnis"
    loc_aRef[9]  = "TmpPro.Cgrus"
    loc_aRef[10] = "TmpPro.Custofs"
    loc_aRef[11] = "TmpPro.MatPrincs"
    loc_aRef[12] = "TmpPro.MoeCusfs"
    loc_aRef[13] = "TmpPro.Varias"
    loc_aRef[14] = "TmpPro.cUniPs"
    loc_aRef[15] = "TmpGccr.BalCodigo"
    loc_aRef[16] = "TmpCli.BalNome"
    STRTOFILE("1) colunas referenciadas no .prg:" + CHR(13)+CHR(10), OUT, 1)
    FOR loc_nI = 1 TO 16
        loc_cExpr = loc_aRef[loc_nI]
        STRTOFILE("   " + PADR(loc_cExpr, 22) + " -> TYPE=" + TYPE(loc_cExpr) + ;
            IIF(loc_nI >= 15, "   (era o nome do TAG - TEM de falhar)", "") + CHR(13)+CHR(10), OUT, 1)
        IF loc_nI <= 14 AND TYPE(loc_cExpr) == "U"
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        IF loc_nI >= 15 AND TYPE(loc_cExpr) != "U"
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
    ENDFOR

    *-- 2) o ControlSource que mAddColuna monta (FormBuscaAuxiliar.ConfigurarGrid)
    loc_oF = CREATEOBJECT("Form")
    loc_oF.AddObject("g", "Grid")
    loc_oG = loc_oF.g
    loc_oG.RecordSource = "TmpGccr"
    loc_oG.ColumnCount  = 2
    loc_oG.Columns(1).ControlSource = "TmpGccr.Codigos"
    loc_oG.Columns(2).ControlSource = "TmpGccr.Descrs"
    STRTOFILE("2) lookup Grupo  -> [" + loc_oG.Columns(1).ControlSource + "] [" + ;
        loc_oG.Columns(2).ControlSource + "]" + CHR(13)+CHR(10), OUT, 1)
    loc_oG.RecordSource = "TmpCli"
    loc_oG.ColumnCount  = 2
    loc_oG.Columns(1).ControlSource = "TmpCli.IClis"
    loc_oG.Columns(2).ControlSource = "TmpCli.RClis"
    STRTOFILE("   lookup Conta  -> [" + loc_oG.Columns(1).ControlSource + "] [" + ;
        loc_oG.Columns(2).ControlSource + "]" + CHR(13)+CHR(10), OUT, 1)

    *-- 3) os TAGs continuam servindo SET ORDER TO / SEEK
    SELECT TmpGccr
    SET ORDER TO BalDescrs
    SET ORDER TO BalCodigo
    SELECT TmpCli
    SET ORDER TO BalNome
    SET ORDER TO BalCodigo
    STRTOFILE("3) TAGs BalCodigo/BalDescrs/BalNome respondem a SET ORDER TO: OK" + CHR(13)+CHR(10), OUT, 1)

    STRTOFILE("PROBE_FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + " (linha " + TRANSFORM(loc_oE.LineNo) + ")" + CHR(13)+CHR(10), OUT, 1)
    STRTOFILE("PROBE_FALHAS=EXCECAO" + CHR(13)+CHR(10), OUT, 1)
ENDTRY
QUIT
