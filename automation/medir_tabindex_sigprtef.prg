*==============================================================================
* medir_tabindex_sigprtef.prg
*
* Mede a ordem de tabulacao EFETIVA do SIGPRTEF.SCX legado (task682).
*
* Por que simular em vez de ler o dump: o SCX guarda TabIndex para apenas 3
* objetos (lido do .scx como DBF - Get_redetef = 1, Say1 = 6, CntTefTxt = 8),
* mas o VFP aplica cada valor NO MOMENTO em que cria o objeto e CLAMPA ao total
* de controles existentes naquele instante. Quando Say1 nasce (3o objeto) o 6
* nao cabe; quando CntTefTxt nasce (5o) o 8 nao cabe. Transcrever 6 e 8 ao pe
* da letra para o migrado seria FIEL AO ARQUIVO e INFIEL A TELA.
*
* O script recria os objetos na ORDEM DOS REGISTROS do SCX, aplicando o
* TabIndex armazenado logo apos cada AddObject - exatamente o que o VFP faz ao
* carregar o formulario - e le de volta a ordem resultante.
*
* Resultado medido em 2026-10-20 (VFP9):
*   Get_redetef=1  oModem=2  Say1=3  CntTefTxt=4
*   Sair=5         TefAdm=6  Command1=7  TefAtv=8
* Ou seja: so o 1 do campo digitavel sobrevive; o resto fica na ordem de
* criacao do SCX. Esses sao os numeros reproduzidos em
* Formsigprtef.ConfigurarPaginaDados().
*
* Saida: automation\medir_tabindex_sigprtef.txt
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
LOCAL lcOut, loF
lcOut = ""

loF = CREATEOBJECT("Form")
loF.AddObject("Shape1", "Shape")
loF.AddObject("oModem", "Container")        && olecontrol no legado (sem TabIndex no SCX)
loF.AddObject("Say1", "Label")
loF.Say1.TabIndex = 6                       && SCX: Say1.TabIndex = 6
loF.AddObject("Get_redetef", "TextBox")
loF.Get_redetef.TabIndex = 1                && SCX: Get_redetef.TabIndex = 1
loF.AddObject("CntTefTxt", "Container")
loF.CntTefTxt.TabIndex = 8                  && SCX: CntTefTxt.TabIndex = 8
loF.AddObject("Sair", "CommandButton")
loF.AddObject("TefAdm", "CommandButton")
loF.AddObject("Command1", "CommandButton")
loF.AddObject("TefAtv", "CommandButton")

lcOut = lcOut + "=== LEGADO SIMULADO (ordem dos registros do SCX) ===" + CHR(13) + CHR(10)
lcOut = lcOut + "oModem="      + TRANSFORM(loF.oModem.TabIndex)      + CHR(13) + CHR(10)
lcOut = lcOut + "Say1="        + TRANSFORM(loF.Say1.TabIndex)        + CHR(13) + CHR(10)
lcOut = lcOut + "Get_redetef=" + TRANSFORM(loF.Get_redetef.TabIndex) + CHR(13) + CHR(10)
lcOut = lcOut + "CntTefTxt="   + TRANSFORM(loF.CntTefTxt.TabIndex)   + CHR(13) + CHR(10)
lcOut = lcOut + "Sair="        + TRANSFORM(loF.Sair.TabIndex)        + CHR(13) + CHR(10)
lcOut = lcOut + "TefAdm="      + TRANSFORM(loF.TefAdm.TabIndex)      + CHR(13) + CHR(10)
lcOut = lcOut + "Command1="    + TRANSFORM(loF.Command1.TabIndex)    + CHR(13) + CHR(10)
lcOut = lcOut + "TefAtv="      + TRANSFORM(loF.TefAtv.TabIndex)      + CHR(13) + CHR(10)
lcOut = lcOut + "Shape1_tem_TabIndex=" + TRANSFORM(PEMSTATUS(loF.Shape1, "TabIndex", 5)) + CHR(13) + CHR(10)

STRTOFILE(lcOut, "C:\4c\automation\medir_tabindex_sigprtef.txt")
QUIT
