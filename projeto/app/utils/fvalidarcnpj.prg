*==============================================================================
* fvalidarcnpj.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* Gemeo de fvalidarcpf.prg. clsconta (classresp.vcx) chama fValidarCNPJ() em 3
* pontos do Cadastro de Cliente - getCNPJ.Valid, getCPFCGC.Valid e mGravaDados:
*
*     If Not fValidarCNPJ(This.Value) Or At(' ', This.Value) > 0
*         =MessageBox('CNPJ Invalido!!!', 0+64, 'Atencao!!!')
*
* Sem o arquivo o VFP procura 'fvalidarcnpj.prg' no PATH e estoura
*
*     File 'fvalidarcnpj.prg' does not exist.
*
* dentro de um Valid, fora de TRY/CATCH -> a tela fecha (mesmo modo de falha do
* campo UF; ver fsqlexec.prg).
*
* Contrato fechado pelos call sites: CNPJ (com ou sem pontuacao) -> LOGICO.
* Delega ao ValidarCNPJ() de utils\validators.prg. Ver a ressalva sobre casos
* de borda no cabecalho de fvalidarcpf.prg - vale igual aqui.
*
* Regra #13 do CLAUDE.md: em codigo NOSSO use ValidarCNPJ() direto.
*
* Origem: Erro163_Aba1 (2026-09-18, Cadastro de Cliente).
*==============================================================================
LPARAMETERS par_cCNPJ

IF VARTYPE(par_cCNPJ) <> "C"
    RETURN .F.
ENDIF

RETURN ValidarCNPJ(par_cCNPJ)
