*==============================================================================
* fconfiggeral.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* As classes-base do Framework legado chamam =fConfigGeral() no Load:
*     frmceps, fwcep, frmprod, frmcadastro, frmrelatorio
* (ver docs\FRAMEWORK_class_codigo_fonte.txt - 8 chamadas).
*
* No sistema legado fConfigGeral era uma funcao GLOBAL da aplicacao (sig.prg /
* SIGFUNCS.PRG), que nao veio no acervo migrado - nao ha o fonte dela em lugar
* nenhum do repositorio. Como o p-code dos VCX ja esta compilado e nao da para
* editar, o VFP procura 'fconfiggeral.prg' no PATH e estoura
*
*     Unhandled Structured Exception / File 'fconfiggeral.prg' does not exist
*
* fora de qualquer TRY/CATCH (a chamada esta num Load), derrubando a tela. Foi
* o que aconteceu ao digitar o CEP no Cadastro de Cliente: o clsconta abre o
* fwcep, cujo Load chama fConfigGeral.
*
* POR QUE UM NO-OP EH SEGURO AQUI
* --------------------------------
* O que fConfigGeral fazia no legado era configuracao global; na arquitetura
* nova isso esta distribuido e ja acontece antes:
*   - config.prg  -> SETs, paths, aliases globais (goSistema, _EMPR, Usuar...)
*   - main.prg    -> conexao, CarregarEmpresa
*   - cada BO     -> seus proprios cursores (ex.: COMBO.CarregarConfigGeral(),
*                    FormSIGREFXV cria o CsEstoque que o legado criava aqui)
*   - mIniConta() -> os ~25 cursores do clsconta via poDataMgr.AddCursor
*
* E o fwcep, que eh o caminho afetado, NAO depende de nada criado por
* fConfigGeral: ele monta o proprio cursor crCep com
* This.poDataMgr.SQLExecute([Select ceps, nomes, bairros, ...], 'crCep').
*
* NAO transformar isto em "inicializacao de verdade" sem antes achar o fonte
* legado: inventar o que a funcao fazia eh pior que nao fazer nada, porque
* mascara a ausencia em vez de mostra-la.
*
* Mesmo padrao de isempty.prg. Regra #2 do CLAUDE.md: em codigo NOSSO nunca se
* chama fConfigGeral - este arquivo existe APENAS para binario legado.
*
* Origem: Erro162_Aba1 (2026-09-17, Cadastro de Cliente, campo CEP).
*==============================================================================
RETURN .T.
