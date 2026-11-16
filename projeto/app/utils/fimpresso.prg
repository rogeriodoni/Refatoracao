*==============================================================================
* FIMPRESSO.PRG - Marca que a impressao saiu (funcao GLOBAL do legado)
* Migrado de: SIGFUNCS.PRG:443 (Erro365).
* Chamada por: o FRX gerado em utils\sigprnfx.prg (Tag2 da banda Summary).
* MUDOU: goSistema.ControlaImp nao existe no go_4c_Sistema do projeto - sem a
*   guarda o REPORT FORM estouraria "Property CONTROLAIMP is not found".
*==============================================================================
IF TYPE("goSistema") = "O"
    IF !PEMSTATUS(goSistema, "ControlaImp", 5)
        ADDPROPERTY(goSistema, "ControlaImp", .F.)
    ENDIF
    IF WEXIST("Printing...")
        goSistema.ControlaImp = .T.
    ENDIF
ENDIF
RETURN .T.