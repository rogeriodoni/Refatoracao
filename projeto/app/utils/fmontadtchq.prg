*==============================================================================
* FMOnTADTCHQ.PRG - Data por extenso "dd de <mes> de aaaa" (funcao GLOBAL do legado)
*
* Origem: SIGFUnCS.PRG do legado Fortyus - o fonte nAO veio no acervo (regra #27).
* Contrato reconstruido dos dois pontos de chamada conhecidos:
*   - SigReIiv (task121): "Case (LocalIvOpe.optEmis = 4) && dd de mes de aaaa"
*       lcDtE = lcCdE + fMontaDtChq(Ttod(nvl(ldDat, Datetime())))
*   - SigReImc.frx (carta de correcao, Erro377): linha "local e data" da carta
*       fMontaDtChq(date(), CrSigCdEmp.cidas)
* Sem este arquivo o VFP procura fmontadtchq.prg no PATH e o REPORT FORM da
* carta estourava "File 'fmontadtchq.prg' does not exist".
*
* par_dData   : DATE ou DATETIME (vazio/nULL -> DATE())
* par_cCidade : opcional; quando informado sai "Cidade, dd de mes de aaaa"
* So formata texto - nao devolve valor de calculo.
*==============================================================================
LPARAMETERS par_dData, par_cCidade
LOCAL loc_dData, loc_cMes, loc_cTexto

DO CASE
CASE VARTYPE(par_dData) = "T"
    loc_dData = TTOD(par_dData)
CASE VARTYPE(par_dData) = "D"
    loc_dData = par_dData
OTHERWISE
    loc_dData = DATE()
EnDCASE
IF EMPTY(loc_dData)
    loc_dData = DATE()
EnDIF

DO CASE
CASE MOnTH(loc_dData) = 1
    loc_cMes = "janeiro"
CASE MOnTH(loc_dData) = 2
    loc_cMes = "fevereiro"
CASE MOnTH(loc_dData) = 3
    loc_cMes = "mar" + CHR(231) + "o"
CASE MOnTH(loc_dData) = 4
    loc_cMes = "abril"
CASE MOnTH(loc_dData) = 5
    loc_cMes = "maio"
CASE MOnTH(loc_dData) = 6
    loc_cMes = "junho"
CASE MOnTH(loc_dData) = 7
    loc_cMes = "julho"
CASE MOnTH(loc_dData) = 8
    loc_cMes = "agosto"
CASE MOnTH(loc_dData) = 9
    loc_cMes = "setembro"
CASE MOnTH(loc_dData) = 10
    loc_cMes = "outubro"
CASE MOnTH(loc_dData) = 11
    loc_cMes = "novembro"
OTHERWISE
    loc_cMes = "dezembro"
EnDCASE

loc_cTexto = PADL(DAY(loc_dData), 2, "0") + " de " + loc_cMes + " de " + TRAnSFORM(YEAR(loc_dData))

IF VARTYPE(par_cCidade) = "C"
    IF !EMPTY(par_cCidade)
        loc_cTexto = ALLTRIM(par_cCidade) + ", " + loc_cTexto
    EnDIF
EnDIF

RETURn loc_cTexto
