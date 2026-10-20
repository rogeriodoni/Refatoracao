*==============================================================================
* ProbeTam680F6b.prg - Probe das FORMULAS das celulas de calculo da Fase 6
* de Formsigprtam (task680).
*
* MEDE em VFP9 a transcricao LITERAL das duas formulas do legado (regra #17),
* sobre um cursor_4c_Dados real criado aqui:
*   Column4.Valid: lnValor = PVens + (PVens * (lnPerc/100))
*   Column5.Valid: lnPerc  = ((lnValor - PVens)/PVens)*100
* e a persistencia local de Peso/Entrega (Column3/Column6), que no legado
* vinha do TableUpdate do form pai.
*
* As linhas ficam com CodTams VAZIO de proposito: GravarLinhaAtual devolve
* .F. logo no inicio nesse caso, entao nada vai para o SQL Server (que nao
* esta alcancavel nesta maquina) e o que sobra medido eh so o calculo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_tam680b.txt"
#DEFINE OUT "C:\4c\automation\probe_tam680_f6b.txt"

LOCAL loc_oForm, loc_nFalhas, loc_oE, loc_oTxt
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 6b - formulas Percentual<->Valor (task680) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprtamBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprtam.prg") ADDITIVE

    gnConnHandle    = -1
    gb_4c_ModoTeste = .T.

    loc_oForm = CREATEOBJECT("Formsigprtam", .NULL., "ALTERAR", "PRODTESTE")

    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE("FALHA: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        *-- O form tem DataSession = 2 (PRIVADA): cursor criado na sessao do
        *-- probe seria INVISIVEL para os metodos do form (USED() daria .F. e
        *-- o probe acusaria falha falsa). Entrar na sessao do form.
        SET DATASESSION TO loc_oForm.DataSessionId
        STRTOFILE("0) DataSessionId do form = " + TRANSFORM(loc_oForm.DataSessionId) + CHR(13) + CHR(10), OUT, 1)

        *-- cursor com a mesma estrutura do que o BO devolve
        CREATE CURSOR cursor_4c_Dados ( ;
            cidchaves C(20), codtams C(4), cpros C(14), ;
            dataalts  T,     datatrans T,  dtmovs T,    ;
            pesoms    N(7,3), percs N(5,2), valor N(11,5), diasprz N(2,0), ;
            descs     C(20))
        INSERT INTO cursor_4c_Dados (cidchaves, codtams, cpros) ;
            VALUES ("CID0000000000000001", "", "PRODTESTE")
        GO TOP IN cursor_4c_Dados

        loc_oForm.this_nPrecoVenda = 100

        *-- 1) Percentual -> Valor: 100 + (100 * (10/100)) = 110
        STRTOFILE("1) Percentual -> Valor (PVens=100, Percs=10)" + CHR(13) + CHR(10), OUT, 1)
        loc_oTxt = loc_oForm.grd_4c_Dados.Column4.txt_4c_CelPerc
        loc_oTxt.Value = 0
        loc_oForm.CelulaGradeEditavel("PERC", loc_oTxt)
        loc_oTxt.Value = 10
        loc_oForm.ValidarCelulaGradeExec("PERC", loc_oTxt)
        STRTOFILE("   percs=" + TRANSFORM(cursor_4c_Dados.percs) + ;
                  "  valor=" + TRANSFORM(cursor_4c_Dados.valor) + CHR(13) + CHR(10), OUT, 1)
        IF cursor_4c_Dados.percs != 10 OR cursor_4c_Dados.valor != 110
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado percs=10 valor=110" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 2) Valor -> Percentual: ((150-100)/100)*100 = 50
        STRTOFILE("2) Valor -> Percentual (PVens=100, Valor=150)" + CHR(13) + CHR(10), OUT, 1)
        loc_oTxt = loc_oForm.grd_4c_Dados.Column5.txt_4c_CelValor
        loc_oTxt.Value = 0
        loc_oForm.CelulaGradeEditavel("VALOR", loc_oTxt)
        loc_oTxt.Value = 150
        loc_oForm.ValidarCelulaGradeExec("VALOR", loc_oTxt)
        STRTOFILE("   percs=" + TRANSFORM(cursor_4c_Dados.percs) + ;
                  "  valor=" + TRANSFORM(cursor_4c_Dados.valor) + CHR(13) + CHR(10), OUT, 1)
        IF cursor_4c_Dados.percs != 50 OR cursor_4c_Dados.valor != 150
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado percs=50 valor=150" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 3) Percentual ZERADO nao zera o Valor (ramo "If Not Empty" do legado)
        STRTOFILE("3) Percentual zerado NAO zera o Valor (fiel ao legado)" + CHR(13) + CHR(10), OUT, 1)
        loc_oTxt = loc_oForm.grd_4c_Dados.Column4.txt_4c_CelPerc
        loc_oTxt.Value = 50
        loc_oForm.CelulaGradeEditavel("PERC", loc_oTxt)
        loc_oTxt.Value = 0
        loc_oForm.ValidarCelulaGradeExec("PERC", loc_oTxt)
        STRTOFILE("   percs=" + TRANSFORM(cursor_4c_Dados.percs) + ;
                  "  valor=" + TRANSFORM(cursor_4c_Dados.valor) + CHR(13) + CHR(10), OUT, 1)
        IF cursor_4c_Dados.percs != 0 OR cursor_4c_Dados.valor != 150
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado percs=0 valor=150 (valor intacto)" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 4) Peso Medio e Entrega chegam ao cursor (persistencia local)
        STRTOFILE("4) Peso Medio / Entrega -> cursor" + CHR(13) + CHR(10), OUT, 1)
        loc_oTxt = loc_oForm.grd_4c_Dados.Column3.txt_4c_CelPeso
        loc_oTxt.Value = 0
        loc_oForm.CelulaGradeEditavel("PESO", loc_oTxt)
        loc_oTxt.Value = 2.345
        loc_oForm.ValidarCelulaGradeExec("PESO", loc_oTxt)

        loc_oTxt = loc_oForm.grd_4c_Dados.Column6.txt_4c_CelPrazo
        loc_oTxt.Value = 0
        loc_oForm.CelulaGradeEditavel("PRAZO", loc_oTxt)
        loc_oTxt.Value = 7
        loc_oForm.ValidarCelulaGradeExec("PRAZO", loc_oTxt)

        STRTOFILE("   pesoms=" + TRANSFORM(cursor_4c_Dados.pesoms) + ;
                  "  diasprz=" + TRANSFORM(cursor_4c_Dados.diasprz) + CHR(13) + CHR(10), OUT, 1)
        IF cursor_4c_Dados.pesoms != 2.345 OR cursor_4c_Dados.diasprz != 7
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: esperado pesoms=2.345 diasprz=7" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 5) Duplicidade: uma 2a linha com o mesmo CodTams faz o Valid
        *--    devolver .F. (unico "Return .F." dos Valid do legado) - e a
        *--    1a linha, sozinha, NAO conta como duplicata de si mesma
        STRTOFILE("5) duplicidade de Tamanho" + CHR(13) + CHR(10), OUT, 1)
        REPLACE codtams WITH "PP" IN cursor_4c_Dados
        INSERT INTO cursor_4c_Dados (cidchaves, codtams, cpros) ;
            VALUES ("CID0000000000000002", "", "PRODTESTE")
        LOCATE FOR ALLTRIM(cidchaves) == "CID0000000000000002"
        STRTOFILE("   linha corrente cidchaves=[" + ALLTRIM(cursor_4c_Dados.cidchaves) + "]" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.this_cLkpCodigo    = "PP"
        loc_oForm.this_cLkpDescricao = "PEQUENO"
        STRTOFILE("   (duplicidade real exige SQL - medida no probe de integracao)" + CHR(13) + CHR(10), OUT, 1)

        *-- 6) chave CURTA (padded pelo char(20) do cursor): o LOCATE de
        *--    GravarLinhaAtual tem de ACHAR a linha. Medido no VFP9:
        *--    "<padded> == <trimado>" eh .F. sempre, entao sem ALLTRIM dos
        *--    dois lados a gravacao devolvia .F. em silencio. Prova: com o
        *--    LOCATE passando, o fluxo chega ao SQL (indisponivel nesta
        *--    maquina) e o erro de conexao aparece no arquivo de erro; com
        *--    o LOCATE falhando, NADA eh registrado.
        STRTOFILE("6) LOCATE de GravarLinhaAtual com cidchaves CURTO" + CHR(13) + CHR(10), OUT, 1)
        IF FILE(gc_4c_ArquivoErroTeste)
            DELETE FILE (gc_4c_ArquivoErroTeste)
        ENDIF
        INSERT INTO cursor_4c_Dados (cidchaves, codtams, cpros) ;
            VALUES ("CID1", "GG", "PRODTESTE")
        LOCATE FOR ALLTRIM(cidchaves) == "CID1"
        STRTOFILE("   LEN(cidchaves no cursor) = " + TRANSFORM(LEN(cursor_4c_Dados.cidchaves)) + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.GravarLinhaAtual()
        IF FILE(gc_4c_ArquivoErroTeste)
            STRTOFILE("   fluxo ALCANCOU a gravacao (LOCATE achou a linha)" + CHR(13) + CHR(10), OUT, 1)
        ELSE
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: nada registrado - o LOCATE nao achou a linha" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        USE IN SELECT("cursor_4c_Dados")
        SET DATASESSION TO 1
        loc_oForm.Release()
    ENDIF
CATCH TO loc_oE
    loc_nFalhas = loc_nFalhas + 1
    STRTOFILE("EXCECAO: " + loc_oE.Message + " | LN=" + TRANSFORM(loc_oE.LineNo) + ;
              " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

STRTOFILE(CHR(13) + CHR(10) + "FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10), OUT, 1)
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("ERROS/AVISOS CAPTURADOS:" + CHR(13) + CHR(10) + ;
              FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF
QUIT
