*==============================================================================
* TestarFormACE.prg - Erro312
*
* Abre o FormACE ("Acesso de Empresas") isolado, para conferir a faixa do
* cabecalho e o bloco de botoes Incluir / Visualizar / Alterar / Excluir /
* Buscar / Encerrar.
*
* COMO RODAR
*   duplo clique em  C:\4c\automation\erro312\TestarFormACE.bat
*   ou, dentro do VFP9:  DO "C:\4c\automation\erro312\TestarFormACE.prg"
*
* O QUE CONFERIR NA TELA
*   1. A faixa cinza escura corre de ponta a ponta, SEM interrupcao.
*   2. Os 6 botoes aparecem DIRETO sobre a faixa, sem retangulo/anel mais
*      escuro em volta do grupo Incluir..Buscar.
*   3. O bloco Incluir..Buscar e o Encerrar tem o MESMO fundo (o da faixa).
*   4. Nada do bloco de botoes ultrapassa a faixa por cima nem por baixo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET EXCLUSIVE OFF

LOCAL loForm, loException

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
GarantirClasse("FormACE")

*-- Regra #29: o CREATEOBJECT fica dentro do TRY; o Show() fica FORA.
*-- Com o Show() dentro do TRY, qualquer erro de runtime do usuario saltaria
*-- para o CATCH, abandonaria o bloco, derrubaria a referencia LOCAL e a tela
*-- fecharia sozinha.
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormACE")
CATCH TO loException
    WAIT WINDOW "Falha ao criar FormACE: " + loException.Message TIMEOUT 10
    loForm = .NULL.
ENDTRY

IF VARTYPE(loForm) = "O"
    loForm.Show()
    READ EVENTS
ELSE
    WAIT WINDOW "FormACE nao instanciou - veja a mensagem acima." TIMEOUT 10
ENDIF

CLOSE ALL
CLEAR EVENTS
QUIT
