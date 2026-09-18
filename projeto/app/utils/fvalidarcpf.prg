*==============================================================================
* fvalidarcpf.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* clsconta (classresp.vcx) chama fValidarCpf() em 4 pontos do Cadastro de
* Cliente - getCPF.Valid, getCPFCGC.Valid, getCPF.When e mGravaDados:
*
*     If Not fValidarCpf(Alltrim(This.Value)) Or At(' ', Alltrim(This.Value)) > 0
*         =MessageBox('CPF Invalido!!!', 0+64, 'Atencao!!!')
*
* Nenhum desses sites tem TRY/CATCH nem guard, e dois deles sao Valid/When: sem
* o arquivo, o VFP procura 'fvalidarcpf.prg' no PATH e estoura
*
*     File 'fvalidarcpf.prg' does not exist.
*
* como excecao NAO TRATADA, derrubando a tela - o mesmo modo de falha do campo
* UF (ver fsqlexec.prg). Mesma familia de isempty.prg / fconfiggeral.prg.
*
* O contrato aqui eh fechado pelos call sites: recebe o CPF (com ou sem
* pontuacao) e devolve LOGICO - .T. valido, .F. invalido. Delegar ao
* ValidarCPF() de utils\validators.prg (algoritmo dos 2 digitos verificadores,
* ja usado em todo o sistema novo) eh reimplementacao do MESMO algoritmo
* publico, nao invencao de regra de negocio.
*
* ATENCAO: nao foi possivel comparar com o fonte legado (nao veio no acervo).
* Se aparecer divergencia de borda - CPF com todos os digitos iguais, CPF com
* menos de 11 digitos - o criterio a valer eh o do legado, e o conserto eh em
* validators.prg, nao aqui.
*
* Regra #13 do CLAUDE.md: em codigo NOSSO use ValidarCPF() direto. Este arquivo
* existe APENAS para binario legado.
*
* Origem: Erro163_Aba1 (2026-09-18, Cadastro de Cliente).
*==============================================================================
LPARAMETERS par_cCPF

IF VARTYPE(par_cCPF) <> "C"
    RETURN .F.
ENDIF

RETURN ValidarCPF(par_cCPF)
