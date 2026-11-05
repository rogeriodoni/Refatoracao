*-- probe738f8.prg - Fase 8/8 da task738 (SIGOPGAR -> Formsigopgar)
*-- Prova em RUNTIME: (a) o form instancia; (b) CarregarLista monta o estado
*-- inicial do Init legado; (c) ChkXmlClick alterna pelos dois funis novos;
*-- (d) FormParaBO/BOParaForm/LimparCampos EXISTEM e rodam, e o escopo
*-- PROTECTED delas eh o real (nao alargado pela subclasse).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET ESCAPE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe738f8_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL lcLog, loF
lcLog = "C:\4c\automation\probe738f8.txt"
STRTOFILE("CK00 inicio" + CHR(13)+CHR(10), lcLog)

CD "C:\4c\projeto\app\start"
DO config.prg
gnConnHandle = -1

SET PROCEDURE TO (gc_4c_CaminhoUtils + "functions.prg")  ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "messages.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "validators.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopgarBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigopgar.prg") ADDITIVE
STRTOFILE("CK01 SET PROCEDURE OK" + CHR(13)+CHR(10), lcLog, 1)

*-- A subclasse de teste expoe os tres hooks PROTECTED: chamar de FORA da
*-- classe falharia (regra #51); de DENTRO da hierarquia eh o escopo legitimo.
loF = CREATEOBJECT("Sonda738F8")
STRTOFILE("CK02 CREATEOBJECT VARTYPE=" + VARTYPE(loF) + CHR(13)+CHR(10), lcLog, 1)
IF VARTYPE(loF) != "O"
    STRTOFILE("FALHOU - form nao instanciou" + CHR(13)+CHR(10), lcLog, 1)
    QUIT
ENDIF

STRTOFILE("== 1) estado inicial (Init legado, via CarregarLista) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE(loF.Estado() + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 2) CarregarLista de FORA da classe, apos sujar a tela ==" + CHR(13)+CHR(10), lcLog, 1)
loF.cnt_4c_TXT.txt_4c_ArqTXT.Value      = "C:\LIXO\A.TXT"
loF.cnt_4c_Xml.txt_4c_Dirs.Value        = "C:\LIXO\B.XML"
loF.cnt_4c_Xml.txt_4c_Arquivo.Value     = "ZZZ"
loF.cnt_4c_TXT.chk_4c_ChkImagens.Value  = 0
loF.chk_4c_ChkXml.Value                 = 1
STRTOFILE("  antes : " + loF.Estado() + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  retorno CarregarLista = " + TRANSFORM(loF.CarregarLista()) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  depois: " + loF.Estado() + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 3) ChkXmlClick (toggle do legado, pelos dois funis) ==" + CHR(13)+CHR(10), lcLog, 1)
loF.cnt_4c_TXT.txt_4c_ArqTXT.Value = "C:\LIXO\C.TXT"
loF.chk_4c_ChkXml.Value = 1
loF.ChkXmlClick()
STRTOFILE("  marcado   : " + loF.Estado() + CHR(13)+CHR(10), lcLog, 1)
loF.cnt_4c_Xml.txt_4c_Dirs.Value = "C:\LIXO\D.XML"
loF.chk_4c_ChkXml.Value = 0
loF.ChkXmlClick()
STRTOFILE("  desmarcado: " + loF.Estado() + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 4) FormParaBO (tela -> BO, os CINCO controles) ==" + CHR(13)+CHR(10), lcLog, 1)
loF.cnt_4c_TXT.txt_4c_ArqTXT.Value     = "C:\SAIDA\PROD.TXT"
loF.cnt_4c_Xml.txt_4c_Dirs.Value       = "C:\SAIDA\PROD.XML"
loF.cnt_4c_Xml.txt_4c_Arquivo.Value    = "ABC123"
loF.cnt_4c_TXT.chk_4c_ChkImagens.Value = 0
loF.chk_4c_ChkXml.Value                = 1
STRTOFILE("  retorno FormParaBO = " + TRANSFORM(loF.ExpoeFormParaBO()) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  BO: " + loF.EstadoBO() + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 5) BOParaForm (BO -> tela; painel por consequencia) ==" + CHR(13)+CHR(10), lcLog, 1)
loF.cnt_4c_TXT.txt_4c_ArqTXT.Value     = ""
loF.cnt_4c_Xml.txt_4c_Dirs.Value       = ""
loF.cnt_4c_Xml.txt_4c_Arquivo.Value    = ""
loF.cnt_4c_TXT.chk_4c_ChkImagens.Value = 1
loF.chk_4c_ChkXml.Value                = 0
loF.AplicarPainelPorModo()
STRTOFILE("  tela zerada: " + loF.Estado() + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  retorno BOParaForm = " + TRANSFORM(loF.ExpoeBOParaForm()) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  tela       : " + loF.Estado() + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 6) LimparCampos (zera tela E BO) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  retorno LimparCampos = " + TRANSFORM(loF.ExpoeLimparCampos()) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  tela: " + loF.Estado() + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  BO  : " + loF.EstadoBO() + CHR(13)+CHR(10), lcLog, 1)

STRTOFILE("== 7) escopo MEDIDO (atributo 2 = Protected) ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  FormParaBO           prot=" + TRANSFORM(PEMSTATUS(loF, "FormParaBO", 2)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  BOParaForm           prot=" + TRANSFORM(PEMSTATUS(loF, "BOParaForm", 2)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  LimparCampos         prot=" + TRANSFORM(PEMSTATUS(loF, "LimparCampos", 2)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  CarregarLista        prot=" + TRANSFORM(PEMSTATUS(loF, "CarregarLista", 2)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  AplicarPainelPorModo prot=" + TRANSFORM(PEMSTATUS(loF, "AplicarPainelPorModo", 2)) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("  BtnCancelarClick     prot=" + TRANSFORM(PEMSTATUS(loF, "BtnCancelarClick", 2)) + ;
    "  existe=" + TRANSFORM(PEMSTATUS(loF, "BtnCancelarClick", 5)) + CHR(13)+CHR(10), lcLog, 1)

*-- O passo 8 (AEVENTS sobre cmd_4c_Cancela) foi RETIRADO: medido em
*-- 2026-11-05, AEVENTS(array, <CommandButton>, 1) PENDURA o processo nesta
*-- sessao (o probe nao chegava ao CK99 e o vfp9.exe tinha de ser morto).
*-- A ligacao do botao ja esta provada sem ele: o BINDEVENT de
*-- cmd_4c_Cancela esta no fonte apontando para o handler renomeado, e o
*-- passo 7 mostra o handler EXISTINDO e PUBLIC no objeto instanciado.
loF.Release()
loF = .NULL.
STRTOFILE("CK99 FIM OK" + CHR(13)+CHR(10), lcLog, 1)
QUIT


DEFINE CLASS Sonda738F8 AS Formsigopgar
    *-- Wrappers de DENTRO da hierarquia: o unico escopo de onde os hooks
    *-- PROTECTED podem ser chamados (regra #51).
    PROCEDURE ExpoeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ExpoeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ExpoeLimparCampos()
        RETURN THIS.LimparCampos()
    ENDPROC

    PROCEDURE Estado()
        RETURN "xml=" + TRANSFORM(THIS.chk_4c_ChkXml.Value) + ;
            " img="    + TRANSFORM(THIS.cnt_4c_TXT.chk_4c_ChkImagens.Value) + ;
            " visTXT=" + TRANSFORM(THIS.cnt_4c_TXT.Visible) + ;
            " visXML=" + TRANSFORM(THIS.cnt_4c_Xml.Visible) + ;
            " arqTXT=[" + ALLTRIM(THIS.cnt_4c_TXT.txt_4c_ArqTXT.Value) + "]" + ;
            " dirs=["   + ALLTRIM(THIS.cnt_4c_Xml.txt_4c_Dirs.Value) + "]" + ;
            " cod=["    + ALLTRIM(THIS.cnt_4c_Xml.txt_4c_Arquivo.Value) + "]"
    ENDPROC

    PROCEDURE EstadoBO()
        RETURN "GeraXml=" + TRANSFORM(THIS.this_oBusinessObject.this_lGeraXml) + ;
            " Imagens=" + TRANSFORM(THIS.this_oBusinessObject.this_lExportarImagens) + ;
            " ArqTxt=[" + ALLTRIM(THIS.this_oBusinessObject.this_cArquivoTxt) + "]" + ;
            " ArqXml=[" + ALLTRIM(THIS.this_oBusinessObject.this_cArquivoXml) + "]" + ;
            " Cod=["    + ALLTRIM(THIS.this_oBusinessObject.this_cCodArquivo) + "]"
    ENDPROC
ENDDEFINE
