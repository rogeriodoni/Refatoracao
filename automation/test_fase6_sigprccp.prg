*==============================================================================
* test_fase6_sigprccp.prg - Harness da Fase 6 do Formsigprccp (Recalculo de
* Precos). Prova que o form INSTANCIA com a superficie desta fase (campos
* restantes + lookups) e que os 17 AbrirLookup<X>() existem E sao CHAMAVEIS
* de fora (PEMSTATUS nao prova escopo - CLAUDE.md regra #3).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, i, lcM
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\tasks\task587\teste_fase6.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 6 Formsigprccp (campos restantes + lookups) ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoForms
PUBLIC gc_4c_CaminhoFramework, gc_4c_UsuarioLogado, go_4c_Sistema
PUBLIC gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoForms     = "C:\4c\projeto\app\forms\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task587\teste_fase6_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "sigprccpBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigprccp", .F.)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("ABORTADO: form nao instanciou (VARTYPE=" + VARTYPE(loForm) + ")." + lcCRLF, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + lcCRLF, lcLog, 1)
STRTOFILE("Caption           : [" + loForm.Caption + "]" + lcCRLF, lcLog, 1)
STRTOFILE("BaseClass         : [" + loForm.BaseClass + "]" + lcCRLF, lcLog, 1)
STRTOFILE("ControlCount      : " + TRANSFORM(loForm.ControlCount) + lcCRLF, lcLog, 1)

*-- Objetos que esta fase acrescentou (2a metade dos campos + area Dados + foto)
STRTOFILE(lcCRLF + "--- CONTROLES DA FASE 6 ---" + lcCRLF, lcLog, 1)
LOCAL ARRAY laC[14]
laC[1]  = "txt_4c_UnidadeI"
laC[2]  = "txt_4c_UnidadeF"
laC[3]  = "txt_4c_MoedaI"
laC[4]  = "txt_4c_MoedaF"
laC[5]  = "txt_4c_Variacao"
laC[6]  = "txt_4c_Feitio"
laC[7]  = "txt_4c_NovoMkp"
laC[8]  = "txt_4c_Reajuste"
laC[9]  = "txt_4c_NovoMarkup"
laC[10] = "txt_4c_NovoEncargo"
laC[11] = "obj_4c_Recalcula"
laC[12] = "obj_4c_Situacao"
laC[13] = "obj_4c_Compra"
laC[14] = "img_4c_FigJpg"
FOR i = 1 TO ALEN(laC)
    STRTOFILE(PADR(laC[i], 22) + ": existe=" + ;
        TRANSFORM(PEMSTATUS(loForm, laC[i], 5)) + lcCRLF, lcLog, 1)
ENDFOR

*-- A foto tem de NASCER OCULTA (FigJpg.Visible = .F. no SCX legado)
STRTOFILE(lcCRLF + "img_4c_FigJpg.Visible (esperado .F.): " + ;
    TRANSFORM(loForm.img_4c_FigJpg.Visible) + lcCRLF, lcLog, 1)

*-- Coluna checkbox da grade: controle desenhado de fato (regra #18)
STRTOFILE("Column1.CurrentControl: [" + loForm.grd_4c_Produtos.Column1.CurrentControl + "]" + lcCRLF, lcLog, 1)
STRTOFILE("Column1.Sparse        : " + TRANSFORM(loForm.grd_4c_Produtos.Column1.Sparse) + lcCRLF, lcLog, 1)

*-- CHAMADA REAL dos 17 AbrirLookup<X>(): PEMSTATUS devolve .T. mesmo para
*-- PROTECTED, so a chamada de fora prova o escopo. Sem conexao (gnConnHandle
*-- = -1) o SQLEXEC falha, mas o campo esta VAZIO, e o contrato do metodo e
*-- retornar sem tocar em SQL nesse caso - entao quem estourar aqui tem
*-- defeito de escopo/nome, nao de banco.
STRTOFILE(lcCRLF + "--- AbrirLookup<X>() CHAMADOS DE FORA (campo vazio) ---" + lcCRLF, lcLog, 1)
LOCAL ARRAY laL[17]
laL[1]  = "AbrirLookupGrupoI"
laL[2]  = "AbrirLookupGrupoF"
laL[3]  = "AbrirLookupGrandeGrupoI"
laL[4]  = "AbrirLookupGrandeGrupoF"
laL[5]  = "AbrirLookupColecaoI"
laL[6]  = "AbrirLookupColecaoF"
laL[7]  = "AbrirLookupSubGrupoI"
laL[8]  = "AbrirLookupSubGrupoF"
laL[9]  = "AbrirLookupLinhaI"
laL[10] = "AbrirLookupLinhaF"
laL[11] = "AbrirLookupUnidadeI"
laL[12] = "AbrirLookupUnidadeF"
laL[13] = "AbrirLookupMoedaI"
laL[14] = "AbrirLookupMoedaF"
laL[15] = "AbrirLookupFeitio"
laL[16] = "AbrirLookupNovoMkp"
laL[17] = "AbrirLookupFornecedor"
FOR i = 1 TO ALEN(laL)
    lcM = laL[i]
    TRY
        loForm.&lcM.()
        STRTOFILE(PADR(lcM, 26) + ": OK (chamavel)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE(PADR(lcM, 26) + ": FALHA - " + loErr.Message + ;
            " L" + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
    ENDTRY
ENDFOR

*-- Handlers de KeyPress ligados por BINDEVENT (tambem chamados de fora)
STRTOFILE(lcCRLF + "--- HANDLERS BINDEVENT CHAMADOS DE FORA ---" + lcCRLF, lcLog, 1)
TRY
    loForm.GrupoIKeyPress(115, 0)
    STRTOFILE("GrupoIKeyPress(F4)        : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("GrupoIKeyPress(F4)        : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY
TRY
    loForm.GrdProdutosAfterRowColChange(1)
    STRTOFILE("GrdProdutosAfterRowColChange: OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("GrdProdutosAfterRowColChange: FALHA - " + loErr.Message + ;
        " L" + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
ENDTRY
TRY
    loForm.FigJpgDblClick()
    STRTOFILE("FigJpgDblClick            : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("FigJpgDblClick            : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY
TRY
    loForm.ChkMarcaKeyPress(32, 0)
    loForm.ChkMarcaClick()
    loForm.ChkMarcaMouseDown(1, 0, 0, 0)
    STRTOFILE("ChkMarca* (4 handlers)    : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("ChkMarca* (4 handlers)    : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY
TRY
    loForm.RecalculaValorAlterado()
    STRTOFILE("RecalculaValorAlterado    : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("RecalculaValorAlterado    : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- Toggle real do checkbox: prova que o valor ALTERNA no cursor (o binding
*-- nativo nao alterna nada - por isso os 4 handlers existem)
STRTOFILE(lcCRLF + "--- TOGGLE REAL DO CHECKBOX (cursor da grade) ---" + lcCRLF, lcLog, 1)
LOCAL lnSesAnt, lnAntes, lnDepois
lnSesAnt = SET("DATASESSION")
SET DATASESSION TO loForm.DataSessionId
IF USED("cursor_4c_Produtos")
    SELECT cursor_4c_Produtos
    ZAP
    INSERT INTO cursor_4c_Produtos (lMarca, cpros, dpros) ;
        VALUES (0, "PROD000000001", "PRODUTO DE TESTE")
    GO TOP
    lnAntes = cursor_4c_Produtos.lMarca
    loForm.ChkMarcaKeyPress(32, 0)
    GO TOP
    lnDepois = cursor_4c_Produtos.lMarca
    STRTOFILE("lMarca antes/depois       : " + TRANSFORM(lnAntes) + " -> " + ;
        TRANSFORM(lnDepois) + IIF(lnAntes != lnDepois, "  (ALTERNOU OK)", ;
        "  (NAO ALTERNOU - DEFEITO)") + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("cursor_4c_Produtos        : AUSENTE" + lcCRLF, lcLog, 1)
ENDIF
SET DATASESSION TO (lnSesAnt)

STRTOFILE(lcCRLF + "--- ERROS REGISTRADOS PELO MODO TESTE ---" + lcCRLF, lcLog, 1)
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE(FILETOSTR(gc_4c_ArquivoErroTeste) + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("(nenhum dialogo de erro suprimido foi registrado)" + lcCRLF, lcLog, 1)
ENDIF

STRTOFILE(lcCRLF + "=== FIM ===" + lcCRLF, lcLog, 1)
QUIT
