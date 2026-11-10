*-- Probe da FASE 8 do FormSigOpLcl (task757).
*--
*-- Exercita os tres funis canonicos entregues na fase:
*--   CarregarLista() - PUBLIC, chamado de FORA da classe (como o harness faz)
*--   FormParaBO() / BOParaForm() - PROTECTED herdado de FormBase, so alcancavel
*--     de DENTRO; por isso a instancia eh de uma SUBCLASSE de teste com
*--     wrappers publicos (ProbeFormParaBO/ProbeBOParaForm).
*--
*-- TRY/CATCH POR CHAMADA: sem ele, um "Property X is not found" em VFP headless
*-- abre um Program Error que ninguem fecha e o processo PENDURA ate o timeout,
*-- sem log nenhum.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut757f8
gcOut757f8 = "C:\4c\automation\probef8sigoplcl757.txt"
STRTOFILE("PROBE F8 task757 v1 INICIO" + CHR(13) + CHR(10), gcOut757f8)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpLcl")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef8sigoplcl757_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log757f8("ambiente OK")

*-- Cursor do form CHAMADOR (contrato externo - nome do legado)
CREATE CURSOR crTpmMvItn (cItens N(10,0), Cpros C(14), Dpros C(65), ;
                          Locals C(10), Localos C(10))
INSERT INTO crTpmMvItn VALUES (1, "PROD001", "PRODUTO UM",   "", "")
INSERT INTO crTpmMvItn VALUES (2, "PROD002", "PRODUTO DOIS", "", "")
INSERT INTO crTpmMvItn VALUES (3, "PROD003", "PRODUTO TRES", "", "")

LOCAL loForm, loErro

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("ProbeFormSigOpLcl757", .NULL., "INSERIR", "")
CATCH TO loErro
    Log757f8("CREATEOBJECT FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    loForm = .NULL.
ENDTRY

Log757f8("0) CREATEOBJECT (subclasse de teste) -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"

    *==============================================================
    * 1) ESCOPO REAL dos tres nomes (existe? / eh PROTECTED?)
    *    PEMSTATUS(...,5) responde "existe"; (...,2) responde "protected".
    *    O par existe=SIM protected=SIM num metodo declarado sem
    *    modificador nomeia a HERANCA como causa.
    *==============================================================
    Escopo757f8(loForm, "CarregarLista")
    Escopo757f8(loForm, "FormParaBO")
    Escopo757f8(loForm, "BOParaForm")

    *==============================================================
    * 2) CarregarLista PUBLIC - chamada de FORA da classe
    *==============================================================
    TRY
        Log757f8("2) CarregarLista() de fora -> " + TRANSFORM(loForm.CarregarLista()))
        Log757f8("   RECCOUNT(cursor_4c_Itens)=" + TRANSFORM(RECCOUNT("cursor_4c_Itens")) + ;
                 " (esperado 3)")
        Log757f8("   RecordSource=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
                 " ColumnCount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount))
        Log757f8("   Col1.CS=[" + loForm.grd_4c_Dados.Column1.ControlSource + "]" + ;
                 " Col3.CS=[" + loForm.grd_4c_Dados.Column3.ControlSource + "]" + ;
                 " Col3.CurrentControl=[" + loForm.grd_4c_Dados.Column3.CurrentControl + "]" + ;
                 " Col3.Sparse=" + TRANSFORM(loForm.grd_4c_Dados.Column3.Sparse))
        Log757f8("   Col1.Width=" + TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + ;
                 " Col1.Header=[" + loForm.grd_4c_Dados.Column1.Header1.Caption + "]" + ;
                 " Col5.Header=[" + loForm.grd_4c_Dados.Column5.Header1.Caption + "]")
        Log757f8("   ORDER corrente=[" + ORDER("cursor_4c_Itens") + "] (esperado CITENS)")
    CATCH TO loErro
        Log757f8("2) CarregarLista() FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 3) FormParaBO - round-trip tela -> BO (os OITO campos)
    *==============================================================
    loForm.txt_4c_Base.Value  = "01"
    loForm.txt_4c_DBase.Value = "DEPOSITO UM"
    loForm.txt_4c_Nvl2.Value  = "02"
    loForm.txt_4c_DNvl2.Value = "CORREDOR DOIS"
    loForm.txt_4c_Nvl3.Value  = "03"
    loForm.txt_4c_DNvl3.Value = "PRATELEIRA TRES"
    loForm.txt_4c_Nvl4.Value  = "0004"
    loForm.txt_4c_DNvl4.Value = "CAIXA QUATRO"

    TRY
        Log757f8("3) FormParaBO() -> " + TRANSFORM(loForm.ProbeFormParaBO()))
        WITH loForm.this_oBusinessObject
            Log757f8("   BO: Base=[" + .this_cBase + "] Desc=[" + .this_cDescBase + "]")
            Log757f8("   BO: Nvl2=[" + .this_cNvl2 + "] Desc=[" + .this_cDescNvl2 + "]")
            Log757f8("   BO: Nvl3=[" + .this_cNvl3 + "] Desc=[" + .this_cDescNvl3 + "]")
            Log757f8("   BO: Nvl4=[" + .this_cNvl4 + "] Desc=[" + .this_cDescNvl4 + "]")
            Log757f8("   MontarLocalizacao() -> [" + .MontarLocalizacao() + "]" + ;
                     " (esperado 010203 0004 colado = [01020300 04] sem espacos)")
        ENDWITH
    CATCH TO loErro
        Log757f8("3) FormParaBO() FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 4) BOParaForm - round-trip BO -> tela
    *    (a) com os valores de volta apos sujar a tela
    *    (b) depois de LimparNiveis(), que eh como os dois caminhos de
    *        limpeza do legado zeram os oito campos
    *==============================================================
    loForm.txt_4c_Base.Value  = "XX"
    loForm.txt_4c_DBase.Value = "SUJO"
    loForm.txt_4c_Nvl4.Value  = "YYYY"

    TRY
        Log757f8("4a) BOParaForm() -> " + TRANSFORM(loForm.ProbeBOParaForm()))
        Log757f8("    tela: Base=[" + loForm.txt_4c_Base.Value + "] (esperado 01)" + ;
                 " DBase=[" + loForm.txt_4c_DBase.Value + "] (esperado DEPOSITO UM)" + ;
                 " Nvl4=[" + loForm.txt_4c_Nvl4.Value + "] (esperado 0004)")
    CATCH TO loErro
        Log757f8("4a) BOParaForm() FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    TRY
        loForm.this_oBusinessObject.LimparNiveis()
        Log757f8("4b) LimparNiveis()+BOParaForm() -> " + TRANSFORM(loForm.ProbeBOParaForm()))
        Log757f8("    tela vazia nos OITO? " + TRANSFORM( ;
                 EMPTY(loForm.txt_4c_Base.Value)  AND EMPTY(loForm.txt_4c_DBase.Value) AND ;
                 EMPTY(loForm.txt_4c_Nvl2.Value)  AND EMPTY(loForm.txt_4c_DNvl2.Value) AND ;
                 EMPTY(loForm.txt_4c_Nvl3.Value)  AND EMPTY(loForm.txt_4c_DNvl3.Value) AND ;
                 EMPTY(loForm.txt_4c_Nvl4.Value)  AND EMPTY(loForm.txt_4c_DNvl4.Value)))
    CATCH TO loErro
        Log757f8("4b) FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 5) Fluxo REAL do btnLocalizar: marca 2 itens, Localizar, e confere
    *    que a localizacao foi para csLocals E que a tela foi limpa pelo
    *    par LimparNiveis()+BOParaForm()
    *==============================================================
    TRY
        SELECT cursor_4c_Itens
        GO TOP
        REPLACE Marcas WITH 1 FOR RECNO() <= 2

        loForm.txt_4c_Base.Value = "01"
        loForm.txt_4c_Nvl2.Value = "02"
        loForm.txt_4c_Nvl3.Value = "03"
        loForm.txt_4c_Nvl4.Value = "0004"

        loForm.BtnLocalizarClick()

        Log757f8("5) BtnLocalizarClick: itensGravados=" + ;
                 TRANSFORM(loForm.this_oBusinessObject.this_nItensGravados))
        IF USED("cursor_4c_Locais")
            SELECT cursor_4c_Locais
            GO TOP
            Log757f8("   cursor_4c_Locais RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Locais")) + ;
                     " 1a linha Locals=[" + cursor_4c_Locais.Locals + "]")
        ELSE
            Log757f8("   cursor_4c_Locais AUSENTE")
        ENDIF
        Log757f8("   tela limpa apos Localizar? " + TRANSFORM( ;
                 EMPTY(loForm.txt_4c_Base.Value) AND EMPTY(loForm.txt_4c_Nvl4.Value) AND ;
                 EMPTY(loForm.txt_4c_DBase.Value)))
    CATCH TO loErro
        Log757f8("5) BtnLocalizarClick FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo) + ;
                 " / PROC " + loErro.Procedure)
    ENDTRY

    *==============================================================
    * 6) BtnLimparClick - recarrega a grade e zera os oito campos
    *==============================================================
    TRY
        loForm.txt_4c_Base.Value  = "09"
        loForm.txt_4c_DBase.Value = "OUTRO"
        loForm.BtnLimparClick()
        Log757f8("6) BtnLimparClick: Base=[" + loForm.txt_4c_Base.Value + "]" + ;
                 " DBase=[" + loForm.txt_4c_DBase.Value + "] (esperado os dois vazios)")
        Log757f8("   grade religada? RecordSource=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
                 " Col3.CurrentControl=[" + loForm.grd_4c_Dados.Column3.CurrentControl + "]")
    CATCH TO loErro
        Log757f8("6) BtnLimparClick FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY

    *==============================================================
    * 7) Guard de modo: em PROCURAR, FormParaBO/CarregarLista seguem
    *    chamaveis mas o botao de acao nao age
    *==============================================================
    TRY
        loForm.Release()
    CATCH TO loErro
        Log757f8("Release FALHOU: " + loErro.Message)
    ENDTRY
    loForm = .NULL.
ENDIF

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("ProbeFormSigOpLcl757", .NULL., "PROCURAR", "ORIGEM")
CATCH TO loErro
    Log757f8("7) CREATEOBJECT PROCURAR FALHOU: " + loErro.Message)
    loForm = .NULL.
ENDTRY

IF VARTYPE(loForm) = "O"
    TRY
        loForm.txt_4c_Base.Value = "01"
        loForm.BtnLocalizarClick()
        Log757f8("7) PROCURAR: BtnLocalizarClick nao agiu? Base=[" + ;
                 loForm.txt_4c_Base.Value + "] (esperado 01 - guard bloqueou)")
        Log757f8("   CarregarLista() segue ok -> " + TRANSFORM(loForm.CarregarLista()))
        Log757f8("   FormParaBO() segue ok -> " + TRANSFORM(loForm.ProbeFormParaBO()) + ;
                 " BO.Base=[" + loForm.this_oBusinessObject.this_cBase + "]")
    CATCH TO loErro
        Log757f8("7) FALHOU: " + loErro.Message + " / LN " + TRANSFORM(loErro.LineNo))
    ENDTRY
    TRY
        loForm.Release()
    CATCH TO loErro
        Log757f8("Release PROCURAR FALHOU: " + loErro.Message)
    ENDTRY
ENDIF

Log757f8("PROBE F8 task757 FIM")
QUIT

PROCEDURE Log757f8(pcTexto)
    STRTOFILE(pcTexto + CHR(13) + CHR(10), gcOut757f8, 1)
ENDPROC

PROCEDURE Escopo757f8(poForm, pcNome)
    Log757f8("1) " + PADR(pcNome, 16) + " existe=" + ;
        IIF(PEMSTATUS(poForm, pcNome, 5), "SIM", "NAO") + ;
        " protected=" + IIF(PEMSTATUS(poForm, pcNome, 2), "SIM", "NAO"))
ENDPROC

*-- Subclasse de teste: wrappers PUBLIC para os hooks PROTECTED. Mora SO aqui,
*-- nunca em projeto\app\. Instanciada NO LUGAR do form (herda Init e tudo).
DEFINE CLASS ProbeFormSigOpLcl757 AS FormSigOpLcl

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
