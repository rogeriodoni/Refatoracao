*-- Probe de instanciacao do FormSigOpHis (Fase 6 - task745).
*-- NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (o probe
*-- morreria por timeout antes do CREATEOBJECT). Carrega a mao so o que o
*-- form usa.
*--
*-- O que este probe PROVA:
*--   1. o Init/InicializarForm roda inteiro (a tela abre);
*--   2. os 12 handlers de lookup existem e NAO sao PROTECTED (BINDEVENT so
*--      funciona com metodo PUBLIC - regra #3);
*--   3. os 12 BINDEVENT estao de fato ligados (AEVENTS no controle);
*--   4. AjustarCamposDependentes reproduz o When do legado (.Enabled do
*--      campo de descricao x campo de codigo preenchido);
*--   5. o funil <X>LostFocus com campo VAZIO limpa o campo par e NAO abre
*--      picker (ramo Else do Valid legado);
*--   6. a guarda de reentrancia this_lEmLookup corta a reentrada;
*--   7. o guard de .Enabled dos AbrirLookup* devolve sem abrir dialogo.
*-- Se o processo TERMINAR dentro do timeout, nenhum Show() modal rodou -
*-- e eh exatamente isso que se quer provar (regra #37).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, loForm, lcSaida, lcMet, lnI, lnJ, lnEv, lcCk
LOCAL ARRAY laEv[1]
lcSaida = "C:\4c\automation\_probe745f6_resultado.txt"
lcCk    = "C:\4c\automation\_probe745f6_ck.txt"
lcOut   = ""

STRTOFILE("CK01 antes do config" + CHR(13) + CHR(10), lcCk)
DO ("C:\4c\projeto\app\start\config.prg")
STRTOFILE("CK02 config ok" + CHR(13) + CHR(10), lcCk, 1)

*-- SET PATH com UMA string concatenada: varias expressoes entre parenteses
*-- honram SO a primeira (regra #26)
SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpHisBO.prg")        ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\FormSigOpHis.prg") ADDITIVE

*-- O PAR eh obrigatorio: sem gc_4c_ArquivoErroTeste o MsgErro cai no
*-- MESSAGEBOX real e o processo fica pendurado sem gravar nada
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe745f6_dialogs.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
STRTOFILE("", gc_4c_ArquivoErroTeste)

STRTOFILE("CK03 set procedure ok" + CHR(13) + CHR(10), lcCk, 1)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigOpHis")
CATCH TO loErro
    lcOut = lcOut + "EXCECAO NO CREATEOBJECT: " + loErro.Message + ;
            " LN=" + TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE("CK04 createobject voltou" + CHR(13) + CHR(10), lcCk, 1)
lcOut = lcOut + "VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcOut = lcOut + "INSTANCIACAO     = OK" + CHR(13) + CHR(10)
    lcOut = lcOut + "BaseClass        = " + loForm.BaseClass + CHR(13) + CHR(10)
    lcOut = lcOut + "Caption          = " + loForm.Caption + CHR(13) + CHR(10)
    lcOut = lcOut + "Width x Height   = " + TRANSFORM(loForm.Width) + " x " + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)

    *-- (1) os oito campos de filtro existem
    lcOut = lcOut + "--- (1) campos de filtro ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 8
        lcMet = GETWORDNUM("txt_4c_Grupo txt_4c_Dgrupo txt_4c_Est txt_4c_Dest " + ;
                           "txt_4c_Cod txt_4c_Dcod txt_4c_DataIni txt_4c_DataFin", lnI)
        lcOut = lcOut + "  " + PADR(lcMet, 16) + " existe=" + ;
                TRANSFORM(PEMSTATUS(loForm, lcMet, 5))
        IF PEMSTATUS(loForm, lcMet, 5)
            lcOut = lcOut + "  VARTYPE(.Value)=" + ;
                    VARTYPE(EVALUATE("loForm." + lcMet + ".Value")) + ;
                    "  MaxLength=" + TRANSFORM(EVALUATE("loForm." + lcMet + ".MaxLength"))
        ENDIF
        lcOut = lcOut + CHR(13) + CHR(10)
    ENDFOR
    lcOut = lcOut + "  DataIni.Value = " + TRANSFORM(loForm.txt_4c_DataIni.Value) + ;
            "   DataFin.Value = " + TRANSFORM(loForm.txt_4c_DataFin.Value) + CHR(13) + CHR(10)

    STRTOFILE("CK05 campos lidos" + CHR(13) + CHR(10), lcCk, 1)

    *-- (2) os 12 handlers de lookup + os 6 AbrirLookup* tem de ser PUBLIC
    lcOut = lcOut + "--- (2) handlers de lookup: existe / protegido ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 19
        lcMet = GETWORDNUM("GrupoLostFocus GrupoKeyPress DgrupoLostFocus DgrupoKeyPress " + ;
                           "EstLostFocus EstKeyPress DestLostFocus DestKeyPress " + ;
                           "CodLostFocus CodKeyPress DcodLostFocus DcodKeyPress " + ;
                           "AbrirLookupGrupoCodigo AbrirLookupGrupoDescricao " + ;
                           "AbrirLookupContaCodigo AbrirLookupContaDescricao " + ;
                           "AbrirLookupProdutoCodigo AbrirLookupProdutoDescricao " + ;
                           "AjustarCamposDependentes", lnI)
        lcOut = lcOut + "  " + PADR(lcMet, 28) + " existe=" + ;
                TRANSFORM(PEMSTATUS(loForm, lcMet, 5)) + ;
                "  protegido=" + TRANSFORM(PEMSTATUS(loForm, lcMet, 2)) + CHR(13) + CHR(10)
    ENDFOR

    STRTOFILE("CK06 pemstatus ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (3) os BINDEVENT estao ligados? AEVENTS com 2 argumentos devolve os
    *-- eventos delegados ligados AO OBJETO passado
    lcOut = lcOut + "--- (3) BINDEVENT ligados por controle ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 6
        lcMet = GETWORDNUM("txt_4c_Grupo txt_4c_Dgrupo txt_4c_Est txt_4c_Dest " + ;
                           "txt_4c_Cod txt_4c_Dcod", lnI)
        lnEv = AEVENTS(laEv, EVALUATE("loForm." + lcMet))
        *-- so a CONTAGEM: com 1 evento ligado o AEVENTS devolve array 1-D e
        *-- laEv[n,2] estouraria (mesma armadilha de ADIR/AFIELDS)
        lcOut = lcOut + "  " + PADR(lcMet, 16) + " eventos=" + TRANSFORM(lnEv)
        lcOut = lcOut + CHR(13) + CHR(10)
    ENDFOR

    STRTOFILE("CK07 aevents ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (4) AjustarCamposDependentes = o When do legado
    lcOut = lcOut + "--- (4) When do legado via .Enabled ---" + CHR(13) + CHR(10)
    loForm.txt_4c_Grupo.Value = ""
    loForm.txt_4c_Est.Value   = ""
    loForm.txt_4c_Cod.Value   = ""
    loForm.AjustarCamposDependentes()
    lcOut = lcOut + "  codigos VAZIOS   -> Dgrupo.Enabled=" + TRANSFORM(loForm.txt_4c_Dgrupo.Enabled) + ;
            " Dest.Enabled=" + TRANSFORM(loForm.txt_4c_Dest.Enabled) + ;
            " Dcod.Enabled=" + TRANSFORM(loForm.txt_4c_Dcod.Enabled) + CHR(13) + CHR(10)
    loForm.txt_4c_Grupo.Value = "001"
    loForm.txt_4c_Est.Value   = "0000000001"
    loForm.txt_4c_Cod.Value   = "PRO1"
    loForm.AjustarCamposDependentes()
    lcOut = lcOut + "  codigos CHEIOS   -> Dgrupo.Enabled=" + TRANSFORM(loForm.txt_4c_Dgrupo.Enabled) + ;
            " Dest.Enabled=" + TRANSFORM(loForm.txt_4c_Dest.Enabled) + ;
            " Dcod.Enabled=" + TRANSFORM(loForm.txt_4c_Dcod.Enabled) + CHR(13) + CHR(10)

    STRTOFILE("CK08 ajustar ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (5) funil com campo VAZIO: limpa o par e NAO abre picker
    lcOut = lcOut + "--- (5) funil com campo vazio (ramo Else do Valid) ---" + CHR(13) + CHR(10)
    loForm.txt_4c_Grupo.Value  = ""
    loForm.txt_4c_Dgrupo.Value = "LIXO"
    loForm.GrupoLostFocus()
    lcOut = lcOut + "  GrupoLostFocus  -> Dgrupo.Value=[" + ALLTRIM(loForm.txt_4c_Dgrupo.Value) + "]" + CHR(13) + CHR(10)
    loForm.txt_4c_Est.Value  = ""
    loForm.txt_4c_Dest.Value = "LIXO"
    loForm.EstLostFocus()
    lcOut = lcOut + "  EstLostFocus    -> Dest.Value=[" + ALLTRIM(loForm.txt_4c_Dest.Value) + "]" + CHR(13) + CHR(10)
    loForm.txt_4c_Cod.Value  = ""
    loForm.txt_4c_Dcod.Value = "LIXO"
    loForm.CodLostFocus()
    lcOut = lcOut + "  CodLostFocus    -> Dcod.Value=[" + ALLTRIM(loForm.txt_4c_Dcod.Value) + "]" + CHR(13) + CHR(10)
    loForm.txt_4c_Dcod.Value = ""
    loForm.txt_4c_Cod.Value  = "LIXO"
    loForm.DcodLostFocus()
    lcOut = lcOut + "  DcodLostFocus   -> Cod.Value=[" + ALLTRIM(loForm.txt_4c_Cod.Value) + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "  this_lEmLookup apos os funis = " + TRANSFORM(loForm.this_lEmLookup) + CHR(13) + CHR(10)

    STRTOFILE("CK09 funis ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (6) guarda de reentrancia: com a flag ligada o funil devolve na hora
    lcOut = lcOut + "--- (6) guarda de reentrancia ---" + CHR(13) + CHR(10)
    loForm.this_lEmLookup      = .T.
    loForm.txt_4c_Grupo.Value  = ""
    loForm.txt_4c_Dgrupo.Value = "NAO DEVE LIMPAR"
    loForm.GrupoLostFocus()
    lcOut = lcOut + "  flag=.T. -> Dgrupo.Value=[" + ALLTRIM(loForm.txt_4c_Dgrupo.Value) + ;
            "] (esperado NAO DEVE LIMPAR)" + CHR(13) + CHR(10)
    loForm.this_lEmLookup = .F.

    *-- (7) guard de .Enabled dos AbrirLookup*: campo desabilitado devolve
    *-- sem abrir dialogo nenhum
    lcOut = lcOut + "--- (7) guard de .Enabled dos AbrirLookup* ---" + CHR(13) + CHR(10)
    loForm.txt_4c_Dgrupo.Enabled = .F.
    loForm.txt_4c_Dest.Enabled   = .F.
    loForm.txt_4c_Dcod.Enabled   = .F.
    loForm.AbrirLookupGrupoDescricao()
    loForm.AbrirLookupContaDescricao()
    loForm.AbrirLookupProdutoDescricao()
    lcOut = lcOut + "  tres AbrirLookup*Descricao com campo desabilitado -> retornaram sem picker" + CHR(13) + CHR(10)

    STRTOFILE("CK10 guards ok" + CHR(13) + CHR(10), lcCk, 1)

    loForm.Release()
    loForm = .NULL.
ELSE
    lcOut = lcOut + "INSTANCIACAO     = FALHOU" + CHR(13) + CHR(10)
ENDIF

lcOut = lcOut + "--- dialogos suprimidos ---" + CHR(13) + CHR(10)
IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + FILETOSTR(gc_4c_ArquivoErroTeste)
ENDIF
lcOut = lcOut + "--- FIM DO PROBE ---" + CHR(13) + CHR(10)

STRTOFILE(lcOut, lcSaida)
STRTOFILE("CK11 fim" + CHR(13) + CHR(10), lcCk, 1)
QUIT
