*-- Probe de instanciacao do FormSigOpHis (Fase 7 - task745).
*-- NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (o probe
*-- morreria por timeout antes do CREATEOBJECT). Carrega a mao so o que o
*-- form usa.
*--
*-- O que este probe PROVA:
*--   1. Init/InicializarForm continua rodando inteiro com o BINDEVENT novo;
*--   2. BtnConsultaClick/BtnEncerrarClick/FocarCampoRecusado existem e NAO
*--      sao PROTECTED (BINDEVENT so funciona com metodo PUBLIC - regra #3)
*--      e FormParaBO segue PROTECTED (FormBase o declara assim - regra #51);
*--   3. os 2 BINDEVENT de obj_4c_Sair.Buttons(1)/(2) estao ligados (AEVENTS);
*--   4. FormParaBO transfere os OITO campos da tela para o BO com o tipo e
*--      a largura certos (provado INDIRETAMENTE: ele eh PROTECTED, entao o
*--      probe chama BtnConsultaClick e le as properties do BO depois);
*--   5. a sequencia de consistencias recusa na ORDEM do legado e aponta o
*--      campo certo em this_cCampoFoco, com a mensagem LITERAL do legado;
*--   6. o form NAO fica desabilitado quando a validacao recusa (o
*--      Enabled = .F. do legado so acontece depois de validar);
*--   7. BtnEncerrarClick libera o form.
*-- Se o processo TERMINAR dentro do timeout, nenhum Show() modal rodou -
*-- isto eh, nenhuma recusa chegou a abrir FormSigPrHpr (regra #29/#37).
SET SAFETY OFF
SET RESOURCE OFF

LOCAL lcOut, loForm, lcSaida, lcMet, lnI, lnEv, lcCk, loErro
LOCAL ARRAY laEv[1]
lcSaida = "C:\4c\automation\_probe745f7_resultado.txt"
lcCk    = "C:\4c\automation\_probe745f7_ck.txt"
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

*-- O PAR eh obrigatorio: sem gc_4c_ArquivoErroTeste o MsgErro/MsgAviso cai
*-- no MESSAGEBOX real e o processo fica pendurado sem gravar nada
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe745f7_dialogs.txt"
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

    *-- (2) escopo dos metodos novos
    lcOut = lcOut + "--- (2) metodos da Fase 7: existe / protegido ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO 4
        lcMet = GETWORDNUM("BtnConsultaClick BtnEncerrarClick FocarCampoRecusado FormParaBO", lnI)
        lcOut = lcOut + "  " + PADR(lcMet, 22) + " existe=" + ;
                TRANSFORM(PEMSTATUS(loForm, lcMet, 5)) + ;
                "  protegido=" + TRANSFORM(PEMSTATUS(loForm, lcMet, 2)) + CHR(13) + CHR(10)
    ENDFOR
    lcOut = lcOut + "  (esperado: os 3 primeiros protegido=.F.; FormParaBO=.T.)" + CHR(13) + CHR(10)

    *-- (3) BINDEVENT dos dois botoes do CommandGroup
    lcOut = lcOut + "--- (3) BINDEVENT de obj_4c_Sair.Buttons(N) ---" + CHR(13) + CHR(10)
    lcOut = lcOut + "  obj_4c_Sair existe=" + TRANSFORM(PEMSTATUS(loForm, "obj_4c_Sair", 5)) + ;
            "  ButtonCount=" + TRANSFORM(loForm.obj_4c_Sair.ButtonCount) + CHR(13) + CHR(10)
    FOR lnI = 1 TO 2
        lnEv = AEVENTS(laEv, loForm.obj_4c_Sair.Buttons(lnI))
        lcOut = lcOut + "  Buttons(" + TRANSFORM(lnI) + ") Caption=[" + ;
                ALLTRIM(loForm.obj_4c_Sair.Buttons(lnI).Caption) + "]" + ;
                " eventos ligados=" + TRANSFORM(lnEv) + CHR(13) + CHR(10)
    ENDFOR

    STRTOFILE("CK05 aevents ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (5a) GRUPO vazio -> 1a recusa do legado
    lcOut = lcOut + "--- (5a) Grupo vazio ---" + CHR(13) + CHR(10)
    loForm.txt_4c_Grupo.Value = ""
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    TRY
        loForm.BtnConsultaClick()
        lcOut = lcOut + "  BtnConsultaClick voltou sem excecao" + CHR(13) + CHR(10)
    CATCH TO loErro
        lcOut = lcOut + "  EXCECAO: " + loErro.Message + " LN=" + ;
                TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
    ENDTRY
    lcOut = lcOut + "  this_cCampoFoco = [" + ALLTRIM(loForm.this_oBusinessObject.this_cCampoFoco) + "]" + ;
            "  (esperado Grupo)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  Form.Enabled    = " + TRANSFORM(loForm.Enabled) + "  (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  dialogo: " + STRTRAN(STRTRAN(FILETOSTR(gc_4c_ArquivoErroTeste), CHR(13), " "), CHR(10), " ") + CHR(13) + CHR(10)

    STRTOFILE("CK06 grupo vazio ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (4) + (5b) com os OITO campos preenchidos: sem conexao SQL o
    *-- ChkRegister de Conta recusa, e as properties do BO provam que o
    *-- FormParaBO transferiu tudo
    lcOut = lcOut + "--- (4) FormParaBO + (5b) Conta sem conexao ---" + CHR(13) + CHR(10)
    loForm.txt_4c_Grupo.Value   = "001"
    loForm.txt_4c_Dgrupo.Value  = "GRUPO UM"
    loForm.txt_4c_Est.Value     = "0000000001"
    loForm.txt_4c_Dest.Value    = "CONTA UM"
    loForm.txt_4c_Cod.Value     = "PRO1"
    loForm.txt_4c_Dcod.Value    = "PRODUTO UM"
    loForm.txt_4c_DataIni.Value = DATE() - 30
    loForm.txt_4c_DataFin.Value = DATE()
    STRTOFILE("", gc_4c_ArquivoErroTeste)
    TRY
        loForm.BtnConsultaClick()
        lcOut = lcOut + "  BtnConsultaClick voltou sem excecao" + CHR(13) + CHR(10)
    CATCH TO loErro
        lcOut = lcOut + "  EXCECAO: " + loErro.Message + " LN=" + ;
                TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
    ENDTRY
    WITH loForm.this_oBusinessObject
        lcOut = lcOut + "  BO.this_cGrupo    =[" + .this_cGrupo + "] LEN=" + TRANSFORM(LEN(.this_cGrupo)) + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_cDGrupo   =[" + .this_cDGrupo + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_cConta    =[" + .this_cConta + "] LEN=" + TRANSFORM(LEN(.this_cConta)) + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_cDConta   =[" + .this_cDConta + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_cProduto  =[" + .this_cProduto + "] LEN=" + TRANSFORM(LEN(.this_cProduto)) + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_cDProduto =[" + .this_cDProduto + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_dDataIni  =" + TRANSFORM(.this_dDataIni) + " VARTYPE=" + VARTYPE(.this_dDataIni) + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_dDataFin  =" + TRANSFORM(.this_dDataFin) + " VARTYPE=" + VARTYPE(.this_dDataFin) + CHR(13) + CHR(10)
        lcOut = lcOut + "  BO.this_cCampoFoco=[" + ALLTRIM(.this_cCampoFoco) + "]  (esperado Conta - sem conexao SQL)" + CHR(13) + CHR(10)
    ENDWITH
    lcOut = lcOut + "  Form.Enabled    = " + TRANSFORM(loForm.Enabled) + "  (esperado .T.)" + CHR(13) + CHR(10)
    lcOut = lcOut + "  dialogo: " + STRTRAN(STRTRAN(FILETOSTR(gc_4c_ArquivoErroTeste), CHR(13), " "), CHR(10), " ") + CHR(13) + CHR(10)

    STRTOFILE("CK07 formparabo ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (5c) periodo invertido direto no ValidarFiltro do BO (a sequencia do
    *-- legado barra antes em Conta, porque nao ha conexao nesta maquina)
    lcOut = lcOut + "--- (5c) ValidarFiltro com periodo invertido ---" + CHR(13) + CHR(10)
    WITH loForm.this_oBusinessObject
        .this_cGrupo   = "001"
        .this_cConta   = "0000000001"
        .this_cProduto = "PRO1"
        .this_dDataIni = DATE()
        .this_dDataFin = DATE() - 30
    ENDWITH
    lcOut = lcOut + "  ValidarFiltro = " + TRANSFORM(loForm.this_oBusinessObject.ValidarFiltro()) + CHR(13) + CHR(10)
    lcOut = lcOut + "  mensagem      = [" + ALLTRIM(loForm.this_oBusinessObject.this_cMensagemErro) + "]" + CHR(13) + CHR(10)
    lcOut = lcOut + "  campo foco    = [" + ALLTRIM(loForm.this_oBusinessObject.this_cCampoFoco) + "]" + CHR(13) + CHR(10)

    *-- FocarCampoRecusado isolado (form nunca foi mostrado - interessa saber
    *-- se o SetFocus estoura nesse estado)
    lcOut = lcOut + "--- FocarCampoRecusado isolado ---" + CHR(13) + CHR(10)
    TRY
        loForm.FocarCampoRecusado()
        lcOut = lcOut + "  voltou sem excecao" + CHR(13) + CHR(10)
    CATCH TO loErro
        lcOut = lcOut + "  EXCECAO: " + loErro.Message + " LN=" + ;
                TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
    ENDTRY

    STRTOFILE("CK08 foco ok" + CHR(13) + CHR(10), lcCk, 1)

    *-- (7) BtnEncerrarClick libera o form
    lcOut = lcOut + "--- (7) BtnEncerrarClick ---" + CHR(13) + CHR(10)
    TRY
        loForm.BtnEncerrarClick()
        lcOut = lcOut + "  voltou sem excecao; VARTYPE(loForm) apos = " + VARTYPE(loForm) + CHR(13) + CHR(10)
    CATCH TO loErro
        lcOut = lcOut + "  EXCECAO: " + loErro.Message + " LN=" + ;
                TRANSFORM(loErro.LineNo) + " PROC=" + loErro.Procedure + CHR(13) + CHR(10)
    ENDTRY
    loForm = .NULL.
ELSE
    lcOut = lcOut + "INSTANCIACAO     = FALHOU" + CHR(13) + CHR(10)
ENDIF

lcOut = lcOut + "--- FIM DO PROBE ---" + CHR(13) + CHR(10)

STRTOFILE(lcOut, lcSaida)
STRTOFILE("CK09 fim" + CHR(13) + CHR(10), lcCk, 1)
QUIT
