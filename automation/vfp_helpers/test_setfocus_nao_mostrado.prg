*==============================================================================
* test_setfocus_nao_mostrado.prg - MEDE se TextBox.SetFocus() estoura quando o
* form NAO foi mostrado (caso do harness headless) e quando o controle esta
* Enabled = .F. Serve para decidir se o TRY/CATCH em BtnCancelarClick eh
* necessario (regra CLAUDE.md #9 proibe CATCH silencioso - se o SetFocus nao
* estoura, o TRY sai e o problema desaparece).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL lcLog, loFrm, loErr, lcCRLF
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\vfp_helpers\test_setfocus_nao_mostrado_resultado.txt"

STRTOFILE("=== SetFocus em form NAO mostrado ===" + lcCRLF, lcLog, 0)

loFrm = CREATEOBJECT("Form")
loFrm.AddObject("txt1", "TextBox")
loFrm.txt1.Visible = .T.
loFrm.txt1.Enabled = .T.

*-- 1) form NUNCA mostrado, controle habilitado e visivel
TRY
    loFrm.txt1.SetFocus()
    STRTOFILE("1) form nao mostrado, Enabled=.T. : OK (nao estourou)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("1) form nao mostrado, Enabled=.T. : ESTOUROU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 2) controle Enabled = .F. (o guard do BtnCancelarClick ja cobriria)
loFrm.txt1.Enabled = .F.
TRY
    loFrm.txt1.SetFocus()
    STRTOFILE("2) Enabled=.F.                    : OK (nao estourou)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("2) Enabled=.F.                    : ESTOUROU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 3) controle Visible = .F.
loFrm.txt1.Enabled = .T.
loFrm.txt1.Visible = .F.
TRY
    loFrm.txt1.SetFocus()
    STRTOFILE("3) Visible=.F.                    : OK (nao estourou)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("3) Visible=.F.                    : ESTOUROU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 4) form MOSTRADO (nao-modal) e controle ok - caminho normal do usuario
loFrm.txt1.Visible = .T.
TRY
    loFrm.Show(0)
    loFrm.txt1.SetFocus()
    STRTOFILE("4) form mostrado, Enabled=.T.     : OK (nao estourou)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("4) form mostrado, Enabled=.T.     : ESTOUROU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

loFrm.Release()
loFrm = .NULL.

STRTOFILE(lcCRLF + "=== FIM ===" + lcCRLF, lcLog, 1)
QUIT
