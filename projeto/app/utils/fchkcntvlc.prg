*==============================================================================
* fchkcntvlc.prg - Wrapper de compatibilidade para os VCXs legado Fortyus.
*
* Irmao de fchkcpovlc.prg. clsconta.mGravaDados (classresp.vcx) roda, no caminho
* de INSERIR/ALTERAR, um laco por TODOS os controles da pagina:
*
*     For Each m.loObjRef1 In This.pgFrameDados.Objects
*         If m.loObjRef1.Enabled
*             m.leRetVlCam1 = fChkCntVlc(m.loObjRef1, 'SigCdCli.DBF', ;
*                                 Thisform.Name, m.lcGrupos, .T., 'cr', ;
*                                 Thisform.pcLstSemChk2)
*             If Type('m.leRetVlCam1')=='O'
*                 = Messagebox('Campo Obrigatorio Invalido' + m.leRetVlCam1.Tag + '.', 16, '')
*                 ... .SetFocus / Return (-1)
*
* Sem o arquivo, o VFP procura 'fchkcntvlc.prg' no PATH e estoura
*
*     File 'fchkcntvlc.prg' does not exist.
*
* no PRIMEIRO controle habilitado - ou seja, gravar um cliente quebraria do
* mesmo jeito que o campo UF quebrava (ver fsqlexec.prg). Nao chegou a ser
* reportado em Erro163_Aba1 porque o fChkCpoVlc, mais cedo, ja abortava mLeDados
* antes de qualquer gravacao.
*
* CONTRATO DO RETORNO
* -------------------
* O chamador so reage a `Type(retorno)=='O'`: OBJETO = achou campo obrigatorio
* invalido (e o objeto E o proprio controle, porque ele faz `.SetFocus` e le
* `.Tag`). Qualquer outro tipo = nada a reclamar. Devolver .F. (Logico) portanto
* significa "nenhum campo obrigatorio invalido" e libera a gravacao.
*
* O QUE SE PERDE
* --------------
* A validacao de obrigatoriedade POR GRUPO DE CONTA deixa de acontecer: o
* sistema passa a aceitar gravar com campo obrigatorio do grupo em branco. As
* obrigatoriedades codificadas direto no clsconta (CPF/CNPJ, UF, IE, CEP) NAO
* dependem desta funcao e continuam valendo.
*
* NAO inventar a regra: a lista de campos obrigatorios por grupo mora em dado
* (SigCdCli.DBF / parametros do grupo) que nao veio no acervo, e chutar quais
* sao daria erro de gravacao onde nao existia. Achar o fonte legado de
* fChkCntVlc/fChkCpoVlc eh a correcao de verdade - ate la, esta ausencia tem de
* ficar VISIVEL neste comentario, nao escondida.
*
* Origem: Erro163_Aba1 (2026-09-18, Cadastro de Cliente).
*==============================================================================
LPARAMETERS par_oControle, par_cTabela, par_cForm, par_cGrupo, ;
            par_lFlag1, par_cPrefixo, par_cListaSemCheck

RETURN .F.
