*==============================================================================
* ProbeSigOpCpo710F6.prg - Prova a Fase 6 do FormSigOpCpo (task710) SEM banco:
* o SQL Server (192.168.200.10) nao eh alcancavel nesta maquina, entao o
* InicializarForm() real nao passa de CarregarProduto(). A subclasse abaixo
* troca APENAS a carga por SQL por cursores locais e chama os MESMOS metodos
* Configurar* do form real - inclusive os BINDEVENT da Fase 6, que estouram no
* proprio bind quando o delegate nao existe.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON
SET EXACT ON

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_710_f6_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_710_f6_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCpoBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCpo.prg ADDITIVE

LOCAL lcOut, loF, loErr, lnI, lnJ
LOCAL ARRAY laEv[1,5]
lcOut = ""

lcOut = lcOut + "=== PROBE Fase 6 - FormSigOpCpo (task710) ===" + CHR(13) + CHR(10)

loF = .NULL.
TRY
    loF = CREATEOBJECT("ProbeSigOpCpo")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO NA INSTANCIACAO: " + loErr.Message + ;
            " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10)
ENDTRY

lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + "  (esperado O)" + CHR(13) + CHR(10)

IF VARTYPE(loF) = "O"

    lcOut = lcOut + CHR(13) + CHR(10) + ;
        "--- 1) ESCOPO dos handlers (PEMSTATUS ...,2: .F. = PUBLIC, exigido por BINDEVENT) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarFiltroTipo         prot=" + TRANSFORM(PEMSTATUS(loF, "ValidarFiltroTipo", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarFiltroTipoExec     prot=" + TRANSFORM(PEMSTATUS(loF, "ValidarFiltroTipoExec", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarFocoRodape         prot=" + TRANSFORM(PEMSTATUS(loF, "ValidarFocoRodape", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarTagRodapeGotFocus  prot=" + TRANSFORM(PEMSTATUS(loF, "ValidarTagRodapeGotFocus", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  ValidarTagRodapeLostFocus prot=" + TRANSFORM(PEMSTATUS(loF, "ValidarTagRodapeLostFocus", 2)) + CHR(13) + CHR(10)
    lcOut = lcOut + "  AtualizarRodape           prot=" + TRANSFORM(PEMSTATUS(loF, "AtualizarRodape", 2)) + ;
            " (interno: .T. esperado)" + CHR(13) + CHR(10)

    lcOut = lcOut + CHR(13) + CHR(10) + "--- 2) BINDEVENT efetivamente ligados (AEVENTS) ---" + CHR(13) + CHR(10)
    lnI = AEVENTS(laEv, loF.cbo_4c_CmbTipos)
    lcOut = lcOut + "  cbo_4c_CmbTipos           = " + TRANSFORM(lnI) + " (esperado 2)" + CHR(13) + CHR(10)
    FOR lnJ = 1 TO lnI
        lcOut = lcOut + "     [" + laEv[lnJ,3] + " -> " + laEv[lnJ,4] + "]" + CHR(13) + CHR(10)
    ENDFOR
    lnI = AEVENTS(laEv, loF.grd_4c_Rodape.Column1.Text1)
    lcOut = lcOut + "  grd_4c_Rodape.Col1.Text1  = " + TRANSFORM(lnI) + " (esperado 1)" + CHR(13) + CHR(10)
    FOR lnJ = 1 TO lnI
        lcOut = lcOut + "     [" + laEv[lnJ,3] + " -> " + laEv[lnJ,4] + "]" + CHR(13) + CHR(10)
    ENDFOR
    lnI = AEVENTS(laEv, loF.grd_4c_Rodape.Column2.Text1)
    lcOut = lcOut + "  grd_4c_Rodape.Col2.Text1  = " + TRANSFORM(lnI) + " (esperado 2)" + CHR(13) + CHR(10)
    FOR lnJ = 1 TO lnI
        lcOut = lcOut + "     [" + laEv[lnJ,3] + " -> " + laEv[lnJ,4] + "]" + CHR(13) + CHR(10)
    ENDFOR

    lcOut = lcOut + CHR(13) + CHR(10) + "--- 3) estado inicial do filtro ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  cbo.Value             = [" + TRANSFORM(loF.cbo_4c_CmbTipos.Value) + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "  this_cTipoFiltroAtual = [" + ALLTRIM(loF.this_cTipoFiltroAtual) + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "  this_lEmFiltroTipo    = " + TRANSFORM(loF.this_lEmFiltroTipo) + " (esperado .F.)" + CHR(13) + CHR(10)
    SELECT cursor_4c_Grade
    lcOut = lcOut + "  RECNO() atual         = " + TRANSFORM(RECNO()) + ;
            "  Tipos=[" + ALLTRIM(cursor_4c_Grade.Tipos) + "] (esperado TIPO A)" + CHR(13) + CHR(10)

    lcOut = lcOut + CHR(13) + CHR(10) + "--- 4) ValidarFiltroTipo: TROCA de tipo (A -> B) ---" + CHR(13) + CHR(10)
    loF.cbo_4c_CmbTipos.Value = PADR("TIPO B", 20)
    loF.ValidarFiltroTipo()
    lcOut = lcOut + "  this_cTipoFiltroAtual = [" + ALLTRIM(loF.this_cTipoFiltroAtual) + "] (esperado TIPO B)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  this_lEmFiltroTipo    = " + TRANSFORM(loF.this_lEmFiltroTipo) + ;
            " (esperado .F. - flag liberada)" + CHR(13) + CHR(10)
    SELECT cursor_4c_Grade
    lcOut = lcOut + "  RECNO() apos (GO TOP) = " + TRANSFORM(RECNO()) + "  EOF=" + TRANSFORM(EOF()) + CHR(13) + CHR(10)
    lcOut = lcOut + "  Tipos linha corrente  = [" + ALLTRIM(cursor_4c_Grade.Tipos) + "] (esperado TIPO B)" + CHR(13) + CHR(10)
    SELECT cursor_4c_Rodape
    GO TOP
    lcOut = lcOut + "  rodape.Totas          = " + TRANSFORM(cursor_4c_Rodape.Totas) + ;
            "  (BO.this_nTotalTotas = " + TRANSFORM(loF.this_oBusinessObject.this_nTotalTotas) + ")" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Buttons(1).Enabled    = " + TRANSFORM(loF.cmg_4c_Botoes.Buttons(1).Enabled) + ;
            "  (BO.this_lPermiteConfirmar = " + ;
            TRANSFORM(loF.this_oBusinessObject.this_lPermiteConfirmar) + ")" + CHR(13) + CHR(10)

    lcOut = lcOut + CHR(13) + CHR(10) + ;
        "--- 5) guarda de valor-nao-mudou: 2a chamada no MESMO tipo nao refiltra ---" + CHR(13) + CHR(10)
    SELECT cursor_4c_Grade
    GO BOTTOM
    lnI = RECNO()
    loF.ValidarFiltroTipo()
    SELECT cursor_4c_Grade
    lcOut = lcOut + "  RECNO antes/depois    = " + TRANSFORM(lnI) + " / " + TRANSFORM(RECNO()) + ;
            " (iguais = nao refiltrou nem deu GO TOP)" + CHR(13) + CHR(10)

    lcOut = lcOut + CHR(13) + CHR(10) + ;
        "--- 6) guarda de reentrancia: flag ligada faz o handler sair na hora ---" + CHR(13) + CHR(10)
    loF.this_lEmFiltroTipo    = .T.
    loF.cbo_4c_CmbTipos.Value = PADR("TIPO A", 20)
    loF.ValidarFiltroTipo()
    lcOut = lcOut + "  this_cTipoFiltroAtual = [" + ALLTRIM(loF.this_cTipoFiltroAtual) + ;
            "] (esperado TIPO B - nao mexeu)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  this_lEmFiltroTipo    = " + TRANSFORM(loF.this_lEmFiltroTipo) + ;
            " (esperado .T. - preservada)" + CHR(13) + CHR(10)
    loF.this_lEmFiltroTipo = .F.

    lcOut = lcOut + CHR(13) + CHR(10) + ;
        "--- 7) AtualizarRodape(RECNO): caminho do CHECKBOX nao salta de linha ---" + CHR(13) + CHR(10)
    loF.cbo_4c_CmbTipos.Value = PADR("TIPO B", 20)
    loF.ValidarFiltroTipo()
    SELECT cursor_4c_Grade
    GO TOP
    SKIP
    lnI = RECNO()
    REPLACE Marcas WITH !Marcas
    loF.ChamarAtualizarRodape(lnI)
    SELECT cursor_4c_Grade
    lcOut = lcOut + "  RECNO antes/depois    = " + TRANSFORM(lnI) + " / " + TRANSFORM(RECNO()) + ;
            " (iguais = linha corrente preservada)" + CHR(13) + CHR(10)
    SELECT cursor_4c_Rodape
    GO TOP
    lcOut = lcOut + "  rodape.Totas espelhado= " + TRANSFORM(cursor_4c_Rodape.Totas) + ;
            " / BO = " + TRANSFORM(loF.this_oBusinessObject.this_nTotalTotas) + CHR(13) + CHR(10)

    lcOut = lcOut + CHR(13) + CHR(10) + ;
        "--- 8) ValidarTagRodape: GotFocus guarda, LostFocus restaura ---" + CHR(13) + CHR(10)
    loF.grd_4c_Rodape.Column2.Text1.Value = "ORIGINAL"
    loF.ValidarTagRodapeGotFocus()
    lcOut = lcOut + "  Tag apos GotFocus     = [" + ALLTRIM(loF.grd_4c_Rodape.Column2.Text1.Tag) + "]" + CHR(13) + CHR(10)
    loF.grd_4c_Rodape.Column2.Text1.Value = "ALTERADO"
    loF.ValidarTagRodapeLostFocus()
    lcOut = lcOut + "  Value apos LostFocus  = [" + ALLTRIM(loF.grd_4c_Rodape.Column2.Text1.Value) + ;
            "] (esperado ORIGINAL)" + CHR(13) + CHR(10)

    lcOut = lcOut + CHR(13) + CHR(10) + ;
        "--- 9) ValidarFocoRodape nao estoura (devolve foco a grade de itens) ---" + CHR(13) + CHR(10)
    TRY
        loF.ValidarFocoRodape()
        lcOut = lcOut + "  executou SEM excecao" + CHR(13) + CHR(10)
    CATCH TO loErr
        lcOut = lcOut + "  EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + CHR(13) + CHR(10)
    ENDTRY

    lcOut = lcOut + CHR(13) + CHR(10) + ;
        "--- 10) img_4c_ImgFigJpg continua OCULTA apos TornarControlesVisiveis ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Visible               = " + TRANSFORM(loF.img_4c_ImgFigJpg.Visible) + ;
            " (esperado .F.)" + CHR(13) + CHR(10)

    loF.Release()
    loF = .NULL.
ENDIF

lcOut = lcOut + CHR(13) + CHR(10) + "=== DIALOGOS / ERROS CAPTURADOS ===" + CHR(13) + CHR(10)
IF FILE("C:\4c\automation\probe_710_f6_dialogs.txt")
    lcOut = lcOut + FILETOSTR("C:\4c\automation\probe_710_f6_dialogs.txt")
ELSE
    lcOut = lcOut + "(nenhum dialogo)" + CHR(13) + CHR(10)
ENDIF

= STRTOFILE(lcOut, "C:\4c\automation\probe_710_f6.txt")
QUIT


*==============================================================================
* ProbeSigOpCpo - subclasse de teste: troca SO a carga por SQL por cursores
* locais com 2 tipos ("TIPO A" com 2 linhas, "TIPO B" com 3), e chama os
* MESMOS metodos Configurar* do form real.
*==============================================================================
DEFINE CLASS ProbeSigOpCpo AS FormSigOpCpo

    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_oErro
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpCpoBO")
            THIS.this_oBusinessObject.this_cCpros        = PADR("PROD-PROBE", 14)
            THIS.this_oBusinessObject.this_cDprosProduto = "PRODUTO DE PROBE"

            THIS.MontarCursoresProbe()

            THIS.Caption = "Composi" + CHR(231) + CHR(227) + "o de Produtos - PROBE"
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            THIS.ConfigurarGridItens()
            THIS.ConfigurarGridRodape()
            THIS.ConfigurarFiltroTipo()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarImagem()
            THIS.TornarControlesVisiveis(THIS)
        CATCH TO loc_oErro
            STRTOFILE("InicializarForm PROBE: " + loc_oErro.Message + ;
                      " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                      " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), ;
                      "C:\4c\automation\probe_710_f6_dialogs.txt", 1)
        ENDTRY

        RETURN .T.
    ENDPROC

    PROCEDURE MontarCursoresProbe()
        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Grade ;
            (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
             Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
             Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
             FigJpgs M, Tipos C(20))
        SET NULL OFF

        INSERT INTO cursor_4c_Grade (Marcas, Mats, Dpros, Qtds, Totas, Tipos) ;
            VALUES (.T., "MAT-A1", "COMPONENTE A1", 2, 10, PADR("TIPO A", 20))
        INSERT INTO cursor_4c_Grade (Marcas, Mats, Dpros, Qtds, Totas, Tipos) ;
            VALUES (.F., "MAT-A2", "COMPONENTE A2", 3, 20, PADR("TIPO A", 20))
        INSERT INTO cursor_4c_Grade (Marcas, Mats, Dpros, Qtds, Totas, Tipos) ;
            VALUES (.T., "MAT-B1", "COMPONENTE B1", 4, 40, PADR("TIPO B", 20))
        INSERT INTO cursor_4c_Grade (Marcas, Mats, Dpros, Qtds, Totas, Tipos) ;
            VALUES (.T., "MAT-B2", "COMPONENTE B2", 5, 50, PADR("TIPO B", 20))
        INSERT INTO cursor_4c_Grade (Marcas, Mats, Dpros, Qtds, Totas, Tipos) ;
            VALUES (.F., "MAT-B3", "COMPONENTE B3", 6, 60, PADR("TIPO B", 20))

        IF USED("cursor_4c_Tipos")
            USE IN cursor_4c_Tipos
        ENDIF
        CREATE CURSOR cursor_4c_Tipos (Tipos C(20))
        INSERT INTO cursor_4c_Tipos (Tipos) VALUES (PADR("TIPO A", 20))
        INSERT INTO cursor_4c_Tipos (Tipos) VALUES (PADR("TIPO B", 20))

        IF USED("cursor_4c_Rodape")
            USE IN cursor_4c_Rodape
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Rodape (Descrs C(100), Usuars C(10), Totas N(12,2))
        SET NULL OFF
        APPEND BLANK
        REPLACE Totas WITH 0

        THIS.this_oBusinessObject.this_nQtdeComponentes = 5
        THIS.this_oBusinessObject.AplicarFiltroTipo(PADR("TIPO A", 20))
    ENDPROC

    *-- AtualizarRodape eh PROTECTED no form real (so o proprio form chama).
    *-- Esta ponte existe SO para o probe exercitar o caminho do checkbox.
    PROCEDURE ChamarAtualizarRodape(par_nReg)
        THIS.AtualizarRodape(par_nReg)
    ENDPROC

ENDDEFINE
