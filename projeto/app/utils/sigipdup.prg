*==============================================================================
* SIGIPDUP.PRG - Wrapper da funcao GLOBAL legado SigIpDup (impressao de duplicata)
*
* Chamada por: SIGREGDPBO.Imprimir() (Emissao Global de Duplicatas/Boletos),
*   transcrevendo o legado SIGREGDP.impressao:
*     =SigIpDup('', ThisForm.Get_Serie.Value, .T., ThisForm.poDataMgr)
*   Sem este arquivo o VFP procura sigipdup.prg no PATH e estoura
*   "File 'sigipdup.prg' does not exist" ao clicar Imprimir (regra #27).
*
* Parametros (mesmo contrato do legado C:\4install\FortyusMC\Fortyus\sigipdup.PRG):
*   par_cChave1 : EmpDopNums do documento (usado so quando par_lArqGer = .F.)
*   par_cSerie  : serie da NF -> escolhe a configuracao em SigCnFDu
*   par_lArqGer : .T. = usa o cursor TmpNFis JA montado pelo chamador
*   par_oCnx    : conector legado (ignorado - o projeto usa gnConnHandle)
*   par_cTipo   : "I" impressora (default) / "V" preview
*
* O QUE FOI TRANSCRITO (identico ao legado):
*   - leitura de SigCnFDu (configuracao de duplicata) e SigCdPam (fatores)
*   - "Nao Existe Configuracao de Duplicata no Sistema" quando SigCnFDu vazia
*   - escolha da configuracao pela serie (Seek; senao a primeira)
*   - validacao da impressora cNomeImps contra APRINTERS() com as mesmas mensagens
*   Conta as duplicatas marcadas (Flag) no TmpNFis do chamador. O modo
*   par_lArqGer = .F. (montar TmpNFis a partir da chave) NAO foi migrado: o unico
*   chamador do projeto passa .T.
*
* O QUE SE PERDE (AVISADO, nunca silencioso):
*   A impressao em si eh posicional (@ SAY ou o motor SigPrNfx.prg, 39 KB) e usa
*   fValorExtenso() para o valor por extenso - nenhum dos dois foi migrado.
*   Depois de passar pelas validacoes o wrapper avisa e devolve .F. em vez de
*   fingir que imprimiu (a ausencia tem de ficar visivel - regra #27).
*==============================================================================
LPARAMETERS par_cChave1, par_cSerie, par_lArqGer, par_oCnx, par_cTipo

LOCAL loc_lOk, loc_nResult, loc_nImpressoras, loc_nI, loc_cNomeImpressora, loc_nQtd
LOCAL ARRAY loc_aPrinters[1]
loc_lOk = .T.
loc_cNomeImpressora = ""
loc_nQtd = 0

IF VARTYPE(par_cSerie) != "C"
    par_cSerie = ""
ENDIF
IF VARTYPE(par_lArqGer) != "L"
    par_lArqGer = .F.
ENDIF

*-- Configuracao de duplicata
IF USED("CrTmpCfgDu")
    USE IN CrTmpCfgDu
ENDIF
loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCnFDu", "CrTmpCfgDu")
IF loc_nResult < 1
    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (CrTmpCfgDu)")
    RETURN .F.
ENDIF

IF USED("CrParam")
    USE IN CrParam
ENDIF
loc_nResult = SQLEXEC(gnConnHandle, "SELECT nnfftlns, nnfftcls FROM SigCdPam", "CrParam")
IF loc_nResult < 1
    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (CrParam)")
    RETURN .F.
ENDIF

SELECT CrTmpCfgDu
INDEX ON Series TAG Series
GO TOP

IF EOF("CrTmpCfgDu")
    MsgAviso("N" + CHR(227) + "o Existe Configura" + CHR(231) + CHR(227) + "o de Duplicata no Sistema !!!", ;
             "Imposs" + CHR(237) + "vel Imprimir Duplicata")
    loc_lOk = .F.
ENDIF

IF loc_lOk
    IF !SEEK(par_cSerie, "CrTmpCfgDu", "Series")
        GO TOP IN CrTmpCfgDu
    ENDIF

    IF EMPTY(CrTmpCfgDu.cNomeImps)
        MsgAviso("Nome da Impressora de Duplicata Inv" + CHR(225) + "lido." + CHR(13) + ;
                 "Corrija e tente a impress" + CHR(227) + "o novamente !!!", ;
                 "Imposs" + CHR(237) + "vel Imprimir Duplicata")
        loc_lOk = .F.
    ENDIF
ENDIF

IF loc_lOk
    loc_nImpressoras = APRINTERS(loc_aPrinters)
    IF loc_nImpressoras = 0
        MsgAviso("N" + CHR(227) + "o Existe Nenhuma Impressora no Painel de Controle !!!", ;
                 "Imposs" + CHR(237) + "vel Imprimir Duplicata")
        loc_lOk = .F.
    ELSE
        loc_lOk = .F.
        FOR loc_nI = 1 TO loc_nImpressoras
            IF ALLTRIM(UPPER(loc_aPrinters[loc_nI, 1])) == ALLTRIM(UPPER(CrTmpCfgDu.cNomeImps))
                loc_cNomeImpressora = ALLTRIM(loc_aPrinters[loc_nI, 1])
                loc_lOk = .T.
                EXIT
            ENDIF
        ENDFOR
        IF !loc_lOk
            MsgAviso("Impressora " + ALLTRIM(UPPER(CrTmpCfgDu.cNomeImps)) + ;
                     " n" + CHR(227) + "o est" + CHR(225) + " configurada no Painel de Controle do seu microcomputador." + ;
                     "Corrija e tente novamente a impress" + CHR(227) + "o da Duplicata.", ;
                     "Imposs" + CHR(237) + "vel Imprimir Duplicata")
        ENDIF
    ENDIF
ENDIF

IF loc_lOk
    IF USED("TmpNFis")
        SELECT TmpNFis
        COUNT FOR Flag TO loc_nQtd
    ENDIF
    IF loc_nQtd = 0
        MsgAviso("Nenhuma duplicata marcada para impress" + CHR(227) + "o.", "Duplicata")
        loc_lOk = .F.
    ELSE
        *-- Impressao posicional (SigPrNfx.prg / @ SAY + fValorExtenso) NAO migrada
        MsgErro("Configura" + CHR(231) + CHR(227) + "o e impressora '" + loc_cNomeImpressora + "' validadas." + CHR(13) + ;
                TRANSFORM(loc_nQtd) + " duplicata(s) marcada(s)." + CHR(13) + CHR(13) + ;
                "A impress" + CHR(227) + "o posicional de duplicata (SigPrNfx / valor por extenso) " + ;
                "ainda n" + CHR(227) + "o foi migrada para o sistema novo.", ;
                "Imprimir Duplicata")
        loc_lOk = .F.
    ENDIF
ENDIF

IF USED("CrParam")
    USE IN CrParam
ENDIF
RETURN loc_lOk
