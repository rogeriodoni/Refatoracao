*==============================================================================
* SIGPRALEBO.PRG
* Business Object do formulario SIGPRALE (dialogo de aguarde/mensagem)
* Responsabilidade: manter os dados exibidos no dialogo de espera exibido
* durante a finalizacao da Reducao Z da impressora fiscal.
*
* SIGPRALE e um dialogo de PROGRESSO/AVISO, sem tabela associada no legado
* (o Init original apenas recebia parametros para popular Imagem/Mensagens).
* Por isso this_cTabela e this_cCampoChave permanecem vazios.
*==============================================================================

DEFINE CLASS SIGPRALEBO AS BusinessBase

    *-- Propriedades (espelham os parametros do Init legado: _BitMap, _Msg1, _msg2, _msg3)
    this_cBitmap    = ""    && Caminho da imagem exibida no dialogo (Imagem.Picture)
    this_cMensagem1 = ""    && Texto da 1a linha de mensagem (mensagem.Caption)
    this_cMensagem2 = ""    && Texto da 2a linha de mensagem (mensagem2.Caption)
    this_cMensagem3 = ""    && Texto da 3a linha de mensagem (mensagem3.Caption)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- SIGPRALE nao possui tabela no banco de dados (dialogo de aguarde)
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        DODEFAULT()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - SIGPRALE nao tem cursor nem tabela. As unicas
    * "colunas" do form legado sao os 4 parametros recebidos pelo proprio
    * Init (_BitMap, _Msg1, _msg2, _msg3 - ver comportamento.json), que ja
    * sao atribuidos diretamente as properties this_cBitmap/this_cMensagem1/
    * this_cMensagem2/this_cMensagem3 pelo Form (FormParaBO). Nao ha SELECT,
    * nao ha cursor a percorrer - o comportamento padrao herdado de
    * BusinessBase (no-op, RETURN .T.) ja eh o correto.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGPRALE nao grava registro nenhum (dialogo de
    * aguarde exibido durante a Reducao Z da impressora fiscal). Nao existe
    * chave primaria porque nao existe tabela; retornar vazio mantem
    * RegistrarAuditoria() inofensivo (ela ja aborta quando a chave vem
    * vazia - ver BusinessBase.RegistrarAuditoria).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGPRALE eh um dialogo de
    * PROGRESSO/AVISO (SIGPRALE.SCX), sem AddCursor, sem SQL e sem tabela
    * associada no legado - o Init original apenas recebia 4 parametros e
    * populava Imagem/Mensagens (ver comportamento.json: temSQL=false,
    * totalQueries=0). O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto - nao ha necessidade de
    * sobrescrever esses tres metodos aqui, e RegistrarAuditoria() nunca
    * roda porque Inserir/Atualizar/ExecutarExclusao nunca sao chamados.
    *==========================================================================

ENDDEFINE
