*==============================================================================
* Probe722F6b.prg - Complemento do Probe722F6: confirma que o CK23 anterior
* ("operas gravado no cursor" vazio) foi ARTEFATO DO PROBE e nao defeito do
* form. O probe anterior usou "COUNT TO" solto, que deixa o cursor em EOF, e
* GravarCelulaFase se recusa (certo) a gravar em EOF.
* Aqui o ponteiro e posicionado antes de cada validacao de celula.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe722f6b_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cSai, loc_oE
loc_cSai = "C:\4c\automation\probe722f6b.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE("A: inicio" + CHR(13) + CHR(10), loc_cSai)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + ;
                 gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpDmpBO.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormSigOpDmp.prg") ADDITIVE

    STRTOFILE(Exercitar() + CHR(13) + CHR(10), loc_cSai, 1)

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha: " + ;
        TRANSFORM(loc_oE.LineNo) + " | Proc: " + loc_oE.Procedure + ;
        CHR(13) + CHR(10), loc_cSai, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), loc_cSai, 1)
ELSE
    STRTOFILE("DIALOGOS SUPRIMIDOS: nenhum" + CHR(13) + CHR(10), loc_cSai, 1)
ENDIF

STRTOFILE("Z: fim" + CHR(13) + CHR(10), loc_cSai, 1)
QUIT


FUNCTION Exercitar()
    LOCAL loc_oForm, loc_oPg2, loc_cO, loc_oE2, loc_oCel, loc_nRec
    loc_cO = ""

    TRY
        loc_oForm = CREATEOBJECT("FormSigOpDmp")
        IF VARTYPE(loc_oForm) != "O"
            loc_cO = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm)
        ELSE
            loc_oPg2 = loc_oForm.pgf_4c_Paginas.Page2
            loc_oForm.this_cModoAtual  = "INCLUIR"
            loc_oPg2.txt_4c_Nome.Value = "DEMO B"
            loc_oForm.InserirLinhaFase()

            loc_oCel = CREATEOBJECT("CelulaFake")

            *-- Com o ponteiro numa linha real, GravarCelulaFase TEM de gravar
            GO TOP IN cursor_4c_Fases
            loc_oCel.Value = "t"
            loc_oForm.GradeFasesEsValid(loc_oCel)
            loc_cO = loc_cO + "B01 E/S [t]: .Value=[" + ;
                TRANSFORM(loc_oCel.Value) + "] cursor.operas=[" + ;
                ALLTRIM(cursor_4c_Fases.operas) + "]  (esperado T / T)" + ;
                CHR(13) + CHR(10)

            GO TOP IN cursor_4c_Fases
            loc_oCel.Value = "Q"
            loc_oForm.GradeFasesEsValid(loc_oCel)
            loc_cO = loc_cO + "B02 E/S [Q]: .Value=[" + ;
                TRANSFORM(loc_oCel.Value) + "] cursor.operas=[" + ;
                ALLTRIM(cursor_4c_Fases.operas) + "]  (esperado espaco / vazio)" + ;
                CHR(13) + CHR(10)

            *-- Ordem invalida tem de zerar .Value E a coluna do cursor
            GO TOP IN cursor_4c_Fases
            REPLACE ordems WITH 55 IN cursor_4c_Fases
            loc_oCel.Value = 4000
            loc_oForm.GradeFasesOrdemValid(loc_oCel)
            loc_cO = loc_cO + "B03 Ordem 4000: .Value=" + ;
                TRANSFORM(loc_oCel.Value) + " cursor.ordems=" + ;
                TRANSFORM(cursor_4c_Fases.ordems) + "  (esperado 0 / 0)" + ;
                CHR(13) + CHR(10)

            *-- Ordem valida NAO pode mexer na coluna (so valida)
            GO TOP IN cursor_4c_Fases
            REPLACE ordems WITH 55 IN cursor_4c_Fases
            loc_oCel.Value = 12
            loc_oForm.GradeFasesOrdemValid(loc_oCel)
            loc_cO = loc_cO + "B04 Ordem 12 valida: .Value=" + ;
                TRANSFORM(loc_oCel.Value) + " cursor.ordems=" + ;
                TRANSFORM(cursor_4c_Fases.ordems) + ;
                "  (esperado 12 / 55 - o valid nao grava o valor valido, o" + ;
                " VFP commita a celula)" + CHR(13) + CHR(10)

            *-- EOF: GravarCelulaFase tem de NAO estourar (foi o CK23)
            GO BOTTOM IN cursor_4c_Fases
            SKIP IN cursor_4c_Fases
            loc_nRec = IIF(EOF("cursor_4c_Fases"), 1, 0)
            loc_oCel.Value = "X"
            loc_oForm.GradeFasesEsValid(loc_oCel)
            loc_cO = loc_cO + "B05 em EOF(" + TRANSFORM(loc_nRec = 1) + ;
                "): nenhuma excecao, .Value=[" + TRANSFORM(loc_oCel.Value) + ;
                "]  (esperado .T. / espaco)" + CHR(13) + CHR(10)

            *-- NomeEditavel: com 1 linha em branco o Nome segue editavel;
            *-- preenchida a fase, trava (When do GetNome legado)
            GO TOP IN cursor_4c_Fases
            REPLACE grupos WITH SPACE(10), contas WITH SPACE(10) ;
                IN cursor_4c_Fases
            loc_oForm.this_cModoAtual = "INCLUIR"
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "B06 INCLUIR linha em branco: Nome.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Nome.ReadOnly) + ;
                "  (esperado .F.)" + CHR(13) + CHR(10)

            GO TOP IN cursor_4c_Fases
            REPLACE grupos WITH "G001" IN cursor_4c_Fases
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "B07 INCLUIR fase preenchida: Nome.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Nome.ReadOnly) + ;
                "  (esperado .T.)" + CHR(13) + CHR(10)

            loc_oForm.this_cModoAtual = "PROCURAR"
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "B08 PROCURAR: Nome.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Nome.ReadOnly) + ;
                "  (esperado .F.)" + CHR(13) + CHR(10)

            loc_oForm.this_cModoAtual = "ALTERAR"
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "B09 ALTERAR: Nome.RO=" + ;
                TRANSFORM(loc_oPg2.txt_4c_Nome.ReadOnly) + ;
                "  (esperado .T. - o nome e a chave de SigCdDpr)" + ;
                CHR(13) + CHR(10)

            *-- ContarLinhasFases nao pode MOVER o ponteiro (COUNT move)
            GO TOP IN cursor_4c_Fases
            loc_oForm.InserirLinhaFase()
            GO 1 IN cursor_4c_Fases
            loc_oForm.AtualizarEstadoCampos()
            loc_cO = loc_cO + "B10 RECNO apos AtualizarEstadoCampos=" + ;
                TRANSFORM(RECNO("cursor_4c_Fases")) + " EOF=" + ;
                TRANSFORM(EOF("cursor_4c_Fases")) + ;
                "  (esperado 1 / .F.)" + CHR(13) + CHR(10)

            *-- ValidarNomeLostFocus: nome vazio em modo de edicao avisa
            loc_oPg2.txt_4c_Nome.Value = ""
            loc_oForm.this_cModoAtual  = "INCLUIR"
            loc_oForm.ValidarNomeLostFocus()
            loc_cO = loc_cO + "B11 ValidarNomeLostFocus com nome vazio: OK" + ;
                CHR(13) + CHR(10)

            *-- Reentrancia: com a flag ligada o handler tem de SAIR na hora
            loc_oForm.this_lEmLookup = .T.
            loc_oPg2.txt_4c_Grupo.Value  = "AAA"
            loc_oPg2.txt_4c_DGrupo.Value = "FICA"
            loc_oForm.ValidarGrupoLostFocus()
            loc_cO = loc_cO + "B12 guarda de reentrancia: DGrupo=[" + ;
                ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value) + ;
                "]  (esperado FICA - handler saiu sem agir)" + CHR(13) + CHR(10)
            loc_oForm.this_lEmLookup = .F.

            *-- VincularGradeFases chamado DE NOVO: idempotente, celulas e
            *-- larguras preservadas (nao destroi o Column.AddObject)
            loc_oForm.VincularGradeFases()
            loc_cO = loc_cO + "B13 revinculo: Cols=" + ;
                TRANSFORM(loc_oPg2.grd_4c_Fases.ColumnCount) + ;
                " Col1.W=" + TRANSFORM(loc_oPg2.grd_4c_Fases.Column1.Width) + ;
                " Col4.W=" + TRANSFORM(loc_oPg2.grd_4c_Fases.Column4.Width) + ;
                " Col1.CurCtrl=[" + ;
                loc_oPg2.grd_4c_Fases.Column1.CurrentControl + "]" + ;
                " Col3.Hdr=[" + ;
                loc_oPg2.grd_4c_Fases.Column3.Header1.Caption + "]" + ;
                "  (esperado 5 / 40 / 100 / TXT_4C_CEL / Funcionario)" + ;
                CHR(13) + CHR(10)

            loc_oForm.Release()
            loc_cO = loc_cO + "B14 Release OK" + CHR(13) + CHR(10)
        ENDIF

    CATCH TO loc_oE2
        loc_cO = loc_cO + "EXCEPTION NO EXERCICIO: " + loc_oE2.Message + ;
            " | Linha: " + TRANSFORM(loc_oE2.LineNo) + ;
            " | Proc: " + loc_oE2.Procedure + CHR(13) + CHR(10)
    ENDTRY

    RETURN loc_cO
ENDFUNC


DEFINE CLASS CelulaFake AS Custom
    Value = ""
ENDDEFINE
