*==============================================================================
* fgravarlog.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* clsconta.mGravaDados (classresp.vcx) encerra a gravacao com:
*
*     =fGravarLog('C', ThisForm.Name, ThisForm.pcEscolha, ;
*                 'Tabela(SigCdCli) C.P.(ICLIS)=' + Alltrim(lcIclis), ;
*                 goSistema.Usuario)
*     ThisForm.pnRetGravacao = lnErro1
*     Return (lnErro1)
*
* Fica DEPOIS do Commit/RollBack, entao a gravacao em si ja terminou - mas a
* linha estoura antes do `Return`, e o retorno da gravacao nunca chega ao form:
*
*     File 'fgravarlog.prg' does not exist.
*
* POR QUE NO-OP, E POR QUE NAO GRAVAR NA SigOpLog "no chute"
* ---------------------------------------------------------
* O retorno eh descartado (`=fGravarLog(...)`), entao o no-op restabelece o
* fluxo inteiro sem efeito colateral.
*
* A tabela de destino mais provavel eh dbo.SigOpLog (usuaredes, datars, horas,
* progs, opers, usuasis, parametros, transacaos, cversaos, cidchaves, copias) -
* os 5 argumentos encaixam nela de forma plausivel, MAS eh so plausibilidade: o
* fonte legado de fGravarLog nao veio no acervo e o 1o argumento ('C') nao tem
* mapeamento obvio. Gravar linha em tabela de auditoria de producao com
* de-para adivinhado eh exatamente o tipo de invencao que a regra #17 do
* CLAUDE.md proibe - o dado errado nao da erro na tela e ninguem reporta.
*
* A auditoria do sistema novo (BusinessBase.RegistrarAuditoria -> LogAuditoria)
* eh independente desta funcao e continua valendo onde ja existe.
*
* Para IMPLEMENTAR de verdade: confirmar o de-para dos 5 argumentos contra o
* fonte legado (sig.prg / SIGFUNCS.PRG) e so entao trocar o RETURN por INSERT.
*
* Origem: Erro163_Aba1 (2026-09-18, Cadastro de Cliente).
*==============================================================================
LPARAMETERS par_cTipo, par_cPrograma, par_cOperacao, par_cTransacao, par_cUsuario

RETURN .T.
