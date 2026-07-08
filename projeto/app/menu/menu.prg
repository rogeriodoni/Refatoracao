*==============================================================================
* MENU.PRG
* Menu principal da aplicacao (versao programatica)
*
* NOTA: Este e um exemplo de menu criado programaticamente.
* Recomenda-se usar o Menu Designer do Visual FoxPro para criar um arquivo .MPR
*==============================================================================

*------------------------------------------------------------------------------
* CriarMenuPrincipal - Cria menu principal da aplicacao
*------------------------------------------------------------------------------
PROCEDURE CriarMenuPrincipal()
    * Define popup principal
    DEFINE PAD padArquivo OF _MSYSMENU PROMPT "\<Arquivo" COLOR SCHEME 3 ;
           KEY ALT+A, ""

    DEFINE PAD padCadastros OF _MSYSMENU PROMPT "\<Cadastros" COLOR SCHEME 3 ;
           KEY ALT+C, ""

    DEFINE PAD padMovimentos OF _MSYSMENU PROMPT "\<Movimentos" COLOR SCHEME 3 ;
           KEY ALT+M, ""

    DEFINE PAD padRelatorios OF _MSYSMENU PROMPT "\<Relat" + CHR(243) + "rios" COLOR SCHEME 3 ;
           KEY ALT+R, ""

    DEFINE PAD padFerramentas OF _MSYSMENU PROMPT "\<Ferramentas" COLOR SCHEME 3 ;
           KEY ALT+F, ""

    DEFINE PAD padAjuda OF _MSYSMENU PROMPT "A\<juda" COLOR SCHEME 3 ;
           KEY ALT+J, ""

    * Menu Arquivo
    ON PAD padArquivo OF _MSYSMENU ACTIVATE POPUP popArquivo

    DEFINE POPUP popArquivo MARGIN RELATIVE SHADOW COLOR SCHEME 4
    DEFINE BAR 1 OF popArquivo PROMPT "\<Sair" ;
           KEY CTRL+Q, "Ctrl+Q"
    ON SELECTION BAR 1 OF popArquivo DO SairSistema

    * Menu Cadastros
    ON PAD padCadastros OF _MSYSMENU ACTIVATE POPUP popCadastros

    DEFINE POPUP popCadastros MARGIN RELATIVE SHADOW COLOR SCHEME 4
    DEFINE BAR 1 OF popCadastros PROMPT "Cargos" ;
           MESSAGE "Cadastro de Cargos"
    DEFINE BAR 2 OF popCadastros PROMPT "Cores" ;
           MESSAGE "Cadastro de Cores"
    DEFINE BAR 3 OF popCadastros PROMPT "Departamentos" ;
           MESSAGE "Cadastro de Departamentos"
    DEFINE BAR 4 OF popCadastros PROMPT "\-"
    DEFINE BAR 5 OF popCadastros PROMPT "Clientes" ;
           MESSAGE "Cadastro de Clientes"
    DEFINE BAR 6 OF popCadastros PROMPT "Fornecedores" ;
           MESSAGE "Cadastro de Fornecedores"
    DEFINE BAR 7 OF popCadastros PROMPT "Produtos" ;
           MESSAGE "Cadastro de Produtos"
    DEFINE BAR 8 OF popCadastros PROMPT "Tamanhos" ;
           MESSAGE "Cadastro de Tamanhos"
    DEFINE BAR 9 OF popCadastros PROMPT "Servi" + CHR(231) + "os" ;
           MESSAGE "Cadastro de Servi" + CHR(231) + "os"
    DEFINE BAR 10 OF popCadastros PROMPT "\-"
    DEFINE BAR 11 OF popCadastros PROMPT "Contas a Pagar/Receber" ;
           MESSAGE "Gest" + CHR(227) + "o de Contas a Pagar e Receber"
    DEFINE BAR 12 OF popCadastros PROMPT "\-"
    DEFINE BAR 13 OF popCadastros PROMPT "Usu" + CHR(225) + "rios" ;
           MESSAGE "Cadastro de Usu" + CHR(225) + "rios"
    DEFINE BAR 14 OF popCadastros PROMPT "Acesso de Grupos" ;
           MESSAGE "Cadastro de Acesso de Grupos"
    DEFINE BAR 15 OF popCadastros PROMPT "\-"
    DEFINE BAR 16 OF popCadastros PROMPT "CFOP" ;
           MESSAGE "Cadastro de CFOP - C" + CHR(243) + "digo Fiscal de Opera" + CHR(231) + CHR(245) + "es e Presta" + CHR(231) + CHR(245) + "es"
    DEFINE BAR 17 OF popCadastros PROMPT "\-"
    DEFINE BAR 18 OF popCadastros PROMPT "Grupos de C/C" ;
           MESSAGE "Cadastro de Grupos de Conta Corrente"
    DEFINE BAR 19 OF popCadastros PROMPT "\-"
    DEFINE BAR 20 OF popCadastros PROMPT "Estados (UFs)" ;
           MESSAGE "Cadastro de Estados / Unidades Federativas"
    DEFINE BAR 21 OF popCadastros PROMPT "Acesso a C/C" ;
           MESSAGE "Cadastro de Acesso a Conta Corrente"

    * Vincular acoes dos itens do menu Cadastros
    ON SELECTION BAR 1 OF popCadastros DO AbrirFormCargo
    ON SELECTION BAR 2 OF popCadastros DO AbrirFormCor
    ON SELECTION BAR 3 OF popCadastros DO AbrirFormDepartamento
    * ON SELECTION BAR 5 OF popCadastros DO AbrirFormCliente
    * ON SELECTION BAR 6 OF popCadastros DO AbrirFormFornecedor
    ON SELECTION BAR 7 OF popCadastros DO AbrirFormProduto
    ON SELECTION BAR 8 OF popCadastros DO AbrirFormTam
    ON SELECTION BAR 9 OF popCadastros DO AbrirFormSrv
    ON SELECTION BAR 11 OF popCadastros DO AbrirFormpgr
    * ON SELECTION BAR 13 OF popCadastros DO AbrirFormUsuario
    ON SELECTION BAR 14 OF popCadastros DO AbrirFormacg
    ON SELECTION BAR 16 OF popCadastros DO AbrirFormcfo
    ON SELECTION BAR 18 OF popCadastros DO AbrirFormccr
    ON SELECTION BAR 20 OF popCadastros DO AbrirFormUfs
    ON SELECTION BAR 21 OF popCadastros DO AbrirFormSigAcCcr

    * Menu Movimentos
    ON PAD padMovimentos OF _MSYSMENU ACTIVATE POPUP popMovimentos

    DEFINE POPUP popMovimentos MARGIN RELATIVE SHADOW COLOR SCHEME 4
    DEFINE BAR 1 OF popMovimentos PROMPT "Movimenta" + CHR(231) + CHR(227) + "o de Estoque/Opera" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Movimenta" + CHR(231) + CHR(227) + "o de Estoque e Opera" + CHR(231) + CHR(245) + "es"
    DEFINE BAR 2 OF popMovimentos PROMPT "\-"
    DEFINE BAR 3 OF popMovimentos PROMPT "Pedidos" ;
           MESSAGE "Lan" + CHR(231) + "amento de Pedidos"
    DEFINE BAR 4 OF popMovimentos PROMPT "Notas Fiscais" ;
           MESSAGE "Lan" + CHR(231) + "amento de Notas Fiscais"
    DEFINE BAR 5 OF popMovimentos PROMPT "\-"
    DEFINE BAR 6 OF popMovimentos PROMPT "Conta Corrente Individual" ;
           MESSAGE "Conta Corrente Individual - Saldos e Hist" + CHR(243) + "rico"
    DEFINE BAR 7 OF popMovimentos PROMPT "Conta Corrente Geral" ;
           MESSAGE "Conta Corrente Geral - Lan" + CHR(231) + "amentos"
    DEFINE BAR 8 OF popMovimentos PROMPT "\-"
    DEFINE BAR 9 OF popMovimentos PROMPT "Separa Industrializa" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Separar/Dividir Ordens de Produ" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 10 OF popMovimentos PROMPT "Reinicia Industrializa" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Reiniciar Ordens de Produ" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 11 OF popMovimentos PROMPT "\-"
    DEFINE BAR 12 OF popMovimentos PROMPT "Muda Cor / Tamanho Etiqueta" ;
           MESSAGE "Altera Cor e Tamanho de Etiquetas"
    DEFINE BAR 13 OF popMovimentos PROMPT "\-"
    DEFINE BAR 14 OF popMovimentos PROMPT "Emiss" + CHR(227) + "o de Cheque" ;
           MESSAGE "Emiss" + CHR(227) + "o de Cheque via impressora serial"
    DEFINE BAR 15 OF popMovimentos PROMPT "\-"
    DEFINE BAR 16 OF popMovimentos PROMPT "Movimenta" + CHR(231) + CHR(227) + "o por Funcion" + CHR(225) + "rio" ;
           MESSAGE "Movimenta" + CHR(231) + CHR(227) + "o por Funcion" + CHR(225) + "rio - Controle de Produ" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 17 OF popMovimentos PROMPT "\-"
    DEFINE BAR 18 OF popMovimentos PROMPT "Pendentes" ;
           MESSAGE "Consulta de Movimenta" + CHR(231) + CHR(245) + "es Pendentes"
    DEFINE BAR 19 OF popMovimentos PROMPT "\-"
    DEFINE BAR 20 OF popMovimentos PROMPT "Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P." ;
           MESSAGE "Altera quantidades de divis" + CHR(245) + "es de Ordens de Produ" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 21 OF popMovimentos PROMPT "\-"
    DEFINE BAR 22 OF popMovimentos PROMPT "Reajuste de Precifica" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Reajuste de Precifica" + CHR(231) + CHR(227) + "o de Produtos"
    DEFINE BAR 23 OF popMovimentos PROMPT "\-"
    DEFINE BAR 24 OF popMovimentos PROMPT "Rec" + CHR(225) + "lculo de Saldos" ;
           MESSAGE "Rec" + CHR(225) + "lculo de Saldos (Conta Corrente, Estoque, Custo, Compra)"
    DEFINE BAR 25 OF popMovimentos PROMPT "\-"
    DEFINE BAR 26 OF popMovimentos PROMPT "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os" ;
           MESSAGE "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os de Produtos"
    DEFINE BAR 27 OF popMovimentos PROMPT "\-"
    DEFINE BAR 28 OF popMovimentos PROMPT "C" + CHR(225) + "lculo de Juros" ;
           MESSAGE "Calculadora de juros simples e compostos com vencimentos"
    DEFINE BAR 29 OF popMovimentos PROMPT "\-"
    DEFINE BAR 30 OF popMovimentos PROMPT "Gera" + CHR(231) + CHR(227) + "o CNAB Cobran" + CHR(231) + "a" ;
           MESSAGE "Gera arquivos CNAB de cobran" + CHR(231) + "a para bancos (BB, Itau, Bradesco, Santander)"
    DEFINE BAR 31 OF popMovimentos PROMPT "\-"
    DEFINE BAR 32 OF popMovimentos PROMPT "Estoque M" + CHR(225) + "ximo" ;
           MESSAGE "Cadastro de Estoque M" + CHR(225) + "ximo por Produto/Empresa"
    DEFINE BAR 33 OF popMovimentos PROMPT "\-"
    DEFINE BAR 34 OF popMovimentos PROMPT "Capacidade Produtiva" ;
           MESSAGE "Consulta de Capacidade Produtiva por Fase/Data/Processo"

    ON SELECTION BAR 1  OF popMovimentos DO AbrirFormsigmvcab
    ON SELECTION BAR 6  OF popMovimentos DO AbrirFormsigopind
    ON SELECTION BAR 7  OF popMovimentos DO AbrirFormsigmvccr
    ON SELECTION BAR 9  OF popMovimentos DO AbrirFormsigopdivDivisao
    ON SELECTION BAR 10 OF popMovimentos DO AbrirFormsigopdivReinicia
    ON SELECTION BAR 12 OF popMovimentos DO AbrirFormSIGMDETQ
    ON SELECTION BAR 14 OF popMovimentos DO AbrirFormSigReEch
    ON SELECTION BAR 16 OF popMovimentos DO AbrirFormSigPdMpf
    ON SELECTION BAR 18 OF popMovimentos DO AbrirFormSIGPDPNS
    ON SELECTION BAR 20 OF popMovimentos DO AbrirFormSigPrAop
    ON SELECTION BAR 22 OF popMovimentos DO AbrirFormSigPrApr
    ON SELECTION BAR 24 OF popMovimentos DO AbrirFormSigPrCcc
    ON SELECTION BAR 26 OF popMovimentos DO AbrirFormSigPrCcp
    ON SELECTION BAR 28 OF popMovimentos DO AbrirFormSigPrCfn
    ON SELECTION BAR 32 OF popMovimentos DO AbrirFormsigprcom
    ON SELECTION BAR 30 OF popMovimentos DO AbrirFormSIGPRCNB
    DEFINE BAR 35 OF popMovimentos PROMPT "\-"
    DEFINE BAR 36 OF popMovimentos PROMPT "Distribui" + CHR(231) + CHR(227) + "o de Produtos" ;
           MESSAGE "Distribui" + CHR(231) + CHR(227) + "o de Produtos por Lote"

    ON SELECTION BAR 34 OF popMovimentos DO AbrirFormsigprcpd
    ON SELECTION BAR 36 OF popMovimentos DO AbrirFormsigprdis

    DEFINE BAR 37 OF popMovimentos PROMPT "\-"
    DEFINE BAR 38 OF popMovimentos PROMPT "Controle de Movimenta" + CHR(231) + CHR(227) + "o por XML" ;
           MESSAGE "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML (NF-e, CT-e)"

    ON SELECTION BAR 38 OF popMovimentos DO AbrirFormSigPrCtr

    DEFINE BAR 39 OF popMovimentos PROMPT "Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos" ;
           MESSAGE "Monta descri" + CHR(231) + CHR(245) + "es de produtos em Portugu" + CHR(234) + "s e Ingl" + CHR(234) + "s"

    ON SELECTION BAR 39 OF popMovimentos DO AbrirFormSigPrDsc

    DEFINE BAR 40 OF popMovimentos PROMPT "\-"
    DEFINE BAR 41 OF popMovimentos PROMPT "Pressupostos" ;
           MESSAGE "Consulta de pressupostos de movimentos de produ" + CHR(231) + CHR(227) + "o"

    ON SELECTION BAR 41 OF popMovimentos DO AbrirFormsigpres2

    DEFINE BAR 42 OF popMovimentos PROMPT "\-"
    DEFINE BAR 43 OF popMovimentos PROMPT "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o por Movimenta" + CHR(231) + CHR(227) + "o de Funcion" + CHR(225) + "rios"

    ON SELECTION BAR 43 OF popMovimentos DO AbrirFormSigPrFem

    DEFINE BAR 44 OF popMovimentos PROMPT "\-"
    DEFINE BAR 45 OF popMovimentos PROMPT "Impress" + CHR(227) + "o de Etiquetas Selecionadas" ;
           MESSAGE "Impress" + CHR(227) + "o de Etiquetas Selecionadas de Produtos"

    ON SELECTION BAR 45 OF popMovimentos DO AbrirFormSigPrEtq

    DEFINE BAR 46 OF popMovimentos PROMPT "\-"
    DEFINE BAR 47 OF popMovimentos PROMPT "Processamento de O.P." ;
           MESSAGE "Processamento de Ordens de Produ" + CHR(231) + CHR(227) + "o"

    ON SELECTION BAR 47 OF popMovimentos DO AbrirFormSigPrGlo

    DEFINE BAR 48 OF popMovimentos PROMPT "\-"
    DEFINE BAR 49 OF popMovimentos PROMPT "Processamento Global por Tipo" ;
           MESSAGE "Processamento Global por Tipo"

    ON SELECTION BAR 49 OF popMovimentos DO AbrirFormSigPrGloT

    DEFINE BAR 50 OF popMovimentos PROMPT "\-"
    DEFINE BAR 51 OF popMovimentos PROMPT "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o / Reserva Autom" + CHR(225) + "tica"

    ON SELECTION BAR 51 OF popMovimentos DO AbrirFormSigPrGlx

    * Menu Relatorios
    ON PAD padRelatorios OF _MSYSMENU ACTIVATE POPUP popRelatorios

    DEFINE POPUP popRelatorios MARGIN RELATIVE SHADOW COLOR SCHEME 4
    DEFINE BAR 1 OF popRelatorios PROMPT "Plano de Contas" ;
           MESSAGE "Relat" + CHR(243) + "rio do Plano de Contas"
    DEFINE BAR 2 OF popRelatorios PROMPT "\-"
    DEFINE BAR 3 OF popRelatorios PROMPT "Clientes" ;
           MESSAGE "Relat" + CHR(243) + "rio de Clientes"
    DEFINE BAR 4 OF popRelatorios PROMPT "Produtos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Produtos"
    DEFINE BAR 5 OF popRelatorios PROMPT "Pedidos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Pedidos"
    DEFINE BAR 6 OF popRelatorios PROMPT "\-"
    DEFINE BAR 7 OF popRelatorios PROMPT "Etiquetas/Relat" + CHR(243) + "rios de Produ" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Impress" + CHR(227) + "o de Etiquetas e Relat" + CHR(243) + "rios de Produ" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 8 OF popRelatorios PROMPT "\-"
    DEFINE BAR 9 OF popRelatorios PROMPT "Anal" + CHR(237) + "tico de Atendimentos" ;
           MESSAGE "Relat" + CHR(243) + "rio Anal" + CHR(237) + "tico de Atendimentos / Pend" + CHR(234) + "ncias"
    DEFINE BAR 10 OF popRelatorios PROMPT "\-"
    DEFINE BAR 11 OF popRelatorios PROMPT "Tipos de Autoriza" + CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de Tipos de Autoriza" + CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o"

    DEFINE BAR 12 OF popRelatorios PROMPT "\-"
    DEFINE BAR 13 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + "o de Estoque" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque"
    DEFINE BAR 14 OF popRelatorios PROMPT "\-"
    DEFINE BAR 15 OF popRelatorios PROMPT "Visitas" ;
           MESSAGE "Relat" + CHR(243) + "rio de Visitas"
    DEFINE BAR 16 OF popRelatorios PROMPT "\-"
    DEFINE BAR 17 OF popRelatorios PROMPT "Total Por Opera" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio Total Por Opera" + CHR(231) + CHR(227) + "o"

    DEFINE BAR 18 OF popRelatorios PROMPT "\-"
    DEFINE BAR 19 OF popRelatorios PROMPT "Log de Acessos" ;
           MESSAGE "Relat" + CHR(243) + "rio do Log de Altera" + CHR(231) + CHR(227) + "o de Acessos"
    DEFINE BAR 20 OF popRelatorios PROMPT "\-"
    DEFINE BAR 21 OF popRelatorios PROMPT "Descontos/Acr" + CHR(233) + "scimos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Apura" + CHR(231) + CHR(227) + "o de Descontos/Acr" + CHR(233) + "scimos"
    DEFINE BAR 22 OF popRelatorios PROMPT "\-"
    DEFINE BAR 23 OF popRelatorios PROMPT "An" + CHR(225) + "lise de Estoque por Grande Grupo" ;
           MESSAGE "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque por Grande Grupo"
    DEFINE BAR 24 OF popRelatorios PROMPT "\-"
    DEFINE BAR 25 OF popRelatorios PROMPT "Acompanhamento Por Grupo de Venda" ;
           MESSAGE "Relat" + CHR(243) + "rio de Acompanhamento Por Grupo de Venda"
    DEFINE BAR 26 OF popRelatorios PROMPT "\-"
    DEFINE BAR 27 OF popRelatorios PROMPT "An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios" ;
           MESSAGE "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios"
    DEFINE BAR 28 OF popRelatorios PROMPT "\-"
    DEFINE BAR 29 OF popRelatorios PROMPT "Aniversariantes" ;
           MESSAGE "Relat" + CHR(243) + "rio de Aniversariantes"
    DEFINE BAR 30 OF popRelatorios PROMPT "\-"
    DEFINE BAR 31 OF popRelatorios PROMPT "Resultados" ;
           MESSAGE "Relat" + CHR(243) + "rio de Resultados"
    DEFINE BAR 32 OF popRelatorios PROMPT "\-"
    DEFINE BAR 33 OF popRelatorios PROMPT "An" + CHR(225) + "lise a Pagar / Receber" ;
           MESSAGE "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber"
    DEFINE BAR 34 OF popRelatorios PROMPT "\-"
    DEFINE BAR 35 OF popRelatorios PROMPT "Altera" + CHR(231) + CHR(245) + "es de Produtos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
    DEFINE BAR 36 OF popRelatorios PROMPT "\-"
    DEFINE BAR 37 OF popRelatorios PROMPT "An" + CHR(225) + "lise por Tipo de Material" ;
           MESSAGE "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise por Tipo de Material"
    DEFINE BAR 38 OF popRelatorios PROMPT "\-"
    DEFINE BAR 39 OF popRelatorios PROMPT "An" + CHR(225) + "lise de Estoque por Tipo de Opera" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Estoque por Tipo de Opera" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 40 OF popRelatorios PROMPT "\-"
    DEFINE BAR 41 OF popRelatorios PROMPT "Balan" + CHR(231) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o"
    DEFINE BAR 42 OF popRelatorios PROMPT "\-"
    DEFINE BAR 43 OF popRelatorios PROMPT "Gen" + CHR(233) + "rico de Compras" ;
           MESSAGE "Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras"
    DEFINE BAR 44 OF popRelatorios PROMPT "\-"
    DEFINE BAR 45 OF popRelatorios PROMPT "Composi" + CHR(231) + CHR(227) + "o de Produtos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o de Produtos"
    DEFINE BAR 46 OF popRelatorios PROMPT "\-"
    DEFINE BAR 47 OF popRelatorios PROMPT "Cheques" ;
           MESSAGE "Relat" + CHR(243) + "rio de Cheques"
    DEFINE BAR 48 OF popRelatorios PROMPT "\-"
    DEFINE BAR 49 OF popRelatorios PROMPT "Cheques Pendentes" ;
           MESSAGE "Relat" + CHR(243) + "rio de Cheques Pendentes"
    DEFINE BAR 50 OF popRelatorios PROMPT "\-"
    DEFINE BAR 51 OF popRelatorios PROMPT "Mapa de Comiss" + CHR(227) + "o Por Vendedor" ;
           MESSAGE "Relat" + CHR(243) + "rio de Mapa de Comiss" + CHR(227) + "o Por Vendedor"
    DEFINE BAR 52 OF popRelatorios PROMPT "\-"
    DEFINE BAR 53 OF popRelatorios PROMPT "Listagem de Composi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o/OP" ;
           MESSAGE "Listagem de Composi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o/OP"
    DEFINE BAR 54 OF popRelatorios PROMPT "\-"
    DEFINE BAR 55 OF popRelatorios PROMPT "CMV - Custo M" + CHR(233) + "dio de Venda" ;
           MESSAGE "Relat" + CHR(243) + "rio de CMV - Custo M" + CHR(233) + "dio de Venda"
    DEFINE BAR 56 OF popRelatorios PROMPT "\-"
    DEFINE BAR 57 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + ;
           "o de Lan" + CHR(231) + "amentos N" + CHR(227) + "o Conciliados" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + ;
                   "o de Lan" + CHR(231) + "amentos N" + CHR(227) + "o Conciliados"
    DEFINE BAR 58 OF popRelatorios PROMPT "\-"
    DEFINE BAR 59 OF popRelatorios PROMPT "Contagem por Localiza" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de Contagem por Localiza" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 60 OF popRelatorios PROMPT "\-"
    DEFINE BAR 61 OF popRelatorios PROMPT "Comiss" + CHR(227) + "o por Grupo de Produto" ;
           MESSAGE "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o por Grupo de Produto"
    DEFINE BAR 62 OF popRelatorios PROMPT "\-"
    DEFINE BAR 63 OF popRelatorios PROMPT "Comiss" + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
    DEFINE BAR 64 OF popRelatorios PROMPT "\-"
    DEFINE BAR 65 OF popRelatorios PROMPT "Comiss" + CHR(245) + "es por Recebimento" ;
           MESSAGE "Relat" + CHR(243) + "rio de Comiss" + CHR(245) + "es por Recebimento"
    DEFINE BAR 66 OF popRelatorios PROMPT "\-"
    DEFINE BAR 67 OF popRelatorios PROMPT "Comiss" + CHR(227) + "o Pendente por Vendedor" ;
           MESSAGE "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o Pendente por Vendedor"
    DEFINE BAR 68 OF popRelatorios PROMPT "\-"
    DEFINE BAR 69 OF popRelatorios PROMPT "Diverg" + CHR(234) + "ncias em Estoques" ;
           MESSAGE "Relat" + CHR(243) + "rio de Diverg" + CHR(234) + "ncias entre Estoques"
    DEFINE BAR 70 OF popRelatorios PROMPT "\-"
    DEFINE BAR 71 OF popRelatorios PROMPT "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP" ;
           MESSAGE "Relat" + CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP - Anal" + CHR(237) + "tico e Sint" + CHR(233) + "tico"
    DEFINE BAR 72 OF popRelatorios PROMPT "\-"
    DEFINE BAR 73 OF popRelatorios PROMPT "Cheques Prorrogados" ;
           MESSAGE "Relat" + CHR(243) + "rio de Cheques Prorrogados"
    DEFINE BAR 74 OF popRelatorios PROMPT "\-"
    DEFINE BAR 75 OF popRelatorios PROMPT "Contagem por Refer" + CHR(234) + "ncia" ;
           MESSAGE "Relat" + CHR(243) + "rio de Contagem por Refer" + CHR(234) + "ncia"
    DEFINE BAR 76 OF popRelatorios PROMPT "\-"
    DEFINE BAR 77 OF popRelatorios PROMPT "D" + CHR(233) + "bitos/Cr" + CHR(233) + "ditos Pendentes" ;
           MESSAGE "Relat" + CHR(243) + "rio de D" + CHR(233) + "bitos/Cr" + CHR(233) + "ditos Pendentes"
    DEFINE BAR 78 OF popRelatorios PROMPT "\-"
    DEFINE BAR 79 OF popRelatorios PROMPT "Cheques da Carteira" ;
           MESSAGE "Relat" + CHR(243) + "rio de Cheques Da Carteira"
    DEFINE BAR 80 OF popRelatorios PROMPT "\-"
    DEFINE BAR 81 OF popRelatorios PROMPT "Comiss" + CHR(227) + "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento" ;
           MESSAGE "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento"
    DEFINE BAR 82 OF popRelatorios PROMPT "\-"
    DEFINE BAR 83 OF popRelatorios PROMPT "Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es" ;
           MESSAGE "Relat" + CHR(243) + "rio de Movimenta" + CHR(231) + CHR(227) + "o de Cart" + CHR(245) + "es"
    DEFINE BAR 84 OF popRelatorios PROMPT "\-"
    DEFINE BAR 85 OF popRelatorios PROMPT "Cota" + CHR(231) + CHR(227) + "o de Compras" ;
           MESSAGE "Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + "o de Compras"
    DEFINE BAR 86 OF popRelatorios PROMPT "\-"
    DEFINE BAR 87 OF popRelatorios PROMPT "Demonstrativo de Balan" + CHR(231) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio Demonstrativo de Balan" + CHR(231) + "o"
    DEFINE BAR 88 OF popRelatorios PROMPT "\-"
    DEFINE BAR 89 OF popRelatorios PROMPT "Cotas de Desconto" ;
           MESSAGE "Relat" + CHR(243) + "rio de Cotas de Desconto"
    DEFINE BAR 90 OF popRelatorios PROMPT "\-"
    DEFINE BAR 91 OF popRelatorios PROMPT "Diferen" + CHR(231) + "as Encontradas" ;
           MESSAGE "Visualizador de Diferen" + CHR(231) + "as Encontradas (Contabilidade)"
    DEFINE BAR 92 OF popRelatorios PROMPT "\-"
    DEFINE BAR 93 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Documento" ;
           MESSAGE "Impress" + CHR(227) + "o de Documento por Opera" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 94 OF popRelatorios PROMPT "\-"
    DEFINE BAR 95 OF popRelatorios PROMPT "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o por Movimenta" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 96 OF popRelatorios PROMPT "\-"
    DEFINE BAR 97 OF popRelatorios PROMPT "Demonstrativo de Conta Corrente" ;
           MESSAGE "Relat" + CHR(243) + "rio Demonstrativo de Conta Corrente"
    DEFINE BAR 98 OF popRelatorios PROMPT "\-"
    DEFINE BAR 99 OF popRelatorios PROMPT "Mapa de Contas" ;
           MESSAGE "Relat" + CHR(243) + "rio Mapa de Contas"
    DEFINE BAR 100 OF popRelatorios PROMPT "\-"
    DEFINE BAR 101 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo"
    DEFINE BAR 102 OF popRelatorios PROMPT "\-"
    DEFINE BAR 103 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + "o de Estoque por Grupo de Produto" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque por Grupo de Produto"
    DEFINE BAR 104 OF popRelatorios PROMPT "\-"
    DEFINE BAR 105 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
    DEFINE BAR 106 OF popRelatorios PROMPT "\-"
    DEFINE BAR 107 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + ;
           "o de Estoque Retroativo" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque Retroativo"
    DEFINE BAR 108 OF popRelatorios PROMPT "\-"
    DEFINE BAR 109 OF popRelatorios PROMPT "Estat" + CHR(237) + "stica de Pedidos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Estat" + CHR(237) + "stica de Pedidos"
    DEFINE BAR 110 OF popRelatorios PROMPT "\-"
    DEFINE BAR 111 OF popRelatorios PROMPT "Estoque Por Localiza" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de Estoque Por Localiza" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 112 OF popRelatorios PROMPT "\-"
    DEFINE BAR 113 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + "o de Estoque por Unidade" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque por Unidade"
    DEFINE BAR 114 OF popRelatorios PROMPT "\-"
    DEFINE BAR 115 OF popRelatorios PROMPT "Demonstrativo de Envelopes Duplicados" ;
           MESSAGE "Relat" + CHR(243) + "rio Demonstrativo de Envelopes Duplicados"
    DEFINE BAR 116 OF popRelatorios PROMPT "\-"
    DEFINE BAR 117 OF popRelatorios PROMPT "Fechamento de Caixa" ;
           MESSAGE "Relat" + CHR(243) + "rio de Fechamento de Caixa"
    DEFINE BAR 118 OF popRelatorios PROMPT "\-"
    DEFINE BAR 119 OF popRelatorios PROMPT "Informativo de Vendas Di" + CHR(225) + "rias" ;
           MESSAGE "Relat" + CHR(243) + "rio Informativo de Vendas Di" + CHR(225) + "rias"
    DEFINE BAR 120 OF popRelatorios PROMPT "\-"
    DEFINE BAR 121 OF popRelatorios PROMPT "Fluxo Financeiro - Anal" + CHR(237) + "tico" ;
           MESSAGE "Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico"
    DEFINE BAR 122 OF popRelatorios PROMPT "\-"
    DEFINE BAR 123 OF popRelatorios PROMPT "Fluxo Financeiro - Sint" + CHR(233) + "tico" ;
           MESSAGE "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
    DEFINE BAR 124 OF popRelatorios PROMPT "\-"
    DEFINE BAR 125 OF popRelatorios PROMPT "Rela" + CHR(231) + CHR(227) + "o Tubos Fundi" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Relat" + CHR(243) + "rio de Rela" + CHR(231) + CHR(227) + "o de Tubos por Fundi" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 126 OF popRelatorios PROMPT "\-"
    DEFINE BAR 127 OF popRelatorios PROMPT "Posi" + CHR(231) + CHR(227) + "o de Estoque por Grupo/Faixa de Valor" ;
           MESSAGE "Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque por Grupo de Produto/Faixa de Valor"
    DEFINE BAR 128 OF popRelatorios PROMPT "\-"
    DEFINE BAR 129 OF popRelatorios PROMPT "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos" ;
           MESSAGE "Emiss" + CHR(227) + "o Global de Duplicatas/Boletos"
    DEFINE BAR 130 OF popRelatorios PROMPT "\-"
    DEFINE BAR 131 OF popRelatorios PROMPT "Emiss" + CHR(227) + "o Global de Nota Fiscal" ;
           MESSAGE "Emiss" + CHR(227) + "o Global de Nota Fiscal"
    DEFINE BAR 132 OF popRelatorios PROMPT "\-"
    DEFINE BAR 133 OF popRelatorios PROMPT "C" + CHR(243) + "digos de Barras Por Estoque" ;
           MESSAGE "Relat" + CHR(243) + "rio de C" + CHR(243) + "digos de Barras Por Estoque"
    DEFINE BAR 134 OF popRelatorios PROMPT "\-"
    DEFINE BAR 135 OF popRelatorios PROMPT "Hist" + CHR(243) + "rico de Custo de Produtos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Hist" + CHR(243) + "rico de Custo de Produtos"
    DEFINE BAR 136 OF popRelatorios PROMPT "\-"
    DEFINE BAR 137 OF popRelatorios PROMPT "Hist" + CHR(243) + "rico de Envelopes" ;
           MESSAGE "Relat" + CHR(243) + "rio Hist" + CHR(243) + "rico de Envelopes"
    DEFINE BAR 138 OF popRelatorios PROMPT "\-"
    DEFINE BAR 139 OF popRelatorios PROMPT "Resumo de Cheques Pendentes" ;
           MESSAGE "Relat" + CHR(243) + "rio de Resumo de Cheques Pendentes"
    DEFINE BAR 140 OF popRelatorios PROMPT "\-"
    DEFINE BAR 141 OF popRelatorios PROMPT "Hist" + CHR(243) + "rico de Produtos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Hist" + CHR(243) + "rico de Produtos"
    DEFINE BAR 142 OF popRelatorios PROMPT "\-"
    DEFINE BAR 143 OF popRelatorios PROMPT "Cheques Emitidos" ;
           MESSAGE "Relat" + CHR(243) + "rio de Cheques Emitidos"
    DEFINE BAR 144 OF popRelatorios PROMPT "\-"
    DEFINE BAR 145 OF popRelatorios PROMPT "Identifica" + CHR(231) + CHR(227) + "o de Contas" ;
           MESSAGE "Relat" + CHR(243) + "rio de Identifica" + CHR(231) + CHR(227) + "o de Contas"
    DEFINE BAR 146 OF popRelatorios PROMPT "\-"
    DEFINE BAR 147 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo" ;
           MESSAGE "Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo (SIGREIDT)"
    DEFINE BAR 148 OF popRelatorios PROMPT "\-"
    DEFINE BAR 149 OF popRelatorios PROMPT "Falhas / Perdas" ;
           MESSAGE "Relat" + CHR(243) + "rio de Falhas / Perdas"
    DEFINE BAR 150 OF popRelatorios PROMPT "\-"
    DEFINE BAR 151 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Documentos Comerciais" ;
           MESSAGE "Impress" + CHR(227) + "o de Documentos Comerciais (Faturas, NFs, Pedidos)"
    DEFINE BAR 152 OF popRelatorios PROMPT "\-"
    DEFINE BAR 153 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Cartas" ;
           MESSAGE "Impress" + CHR(227) + "o de Cartas (SIGREIMC)"
    DEFINE BAR 154 OF popRelatorios PROMPT "\-"
    DEFINE BAR 155 OF popRelatorios PROMPT "Comparativo de Impostos" ;
           MESSAGE "Relat" + CHR(243) + "rio Comparativo de Impostos (Entradas x Sa" + CHR(237) + "das)"
    DEFINE BAR 156 OF popRelatorios PROMPT "\-"
    DEFINE BAR 157 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Nota Fiscal" ;
           MESSAGE "Impress" + CHR(227) + "o de Nota Fiscal (SigReInf)"
    DEFINE BAR 158 OF popRelatorios PROMPT "\-"
    DEFINE BAR 159 OF popRelatorios PROMPT "Invent" + CHR(225) + "rio" ;
           MESSAGE "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio (SIGREINR)"
    DEFINE BAR 160 OF popRelatorios PROMPT "\-"
    DEFINE BAR 161 OF popRelatorios PROMPT "Invent" + CHR(225) + "rio de Estoque" ;
           MESSAGE "Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque (SIGREINV)"
    DEFINE BAR 162 OF popRelatorios PROMPT "\-"
    DEFINE BAR 163 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Etiquetas" ;
           MESSAGE "Impress" + CHR(227) + "o de Etiquetas de Endere" + CHR(231) + "amento (SIGREIPE)"
    DEFINE BAR 164 OF popRelatorios PROMPT "\-"
    DEFINE BAR 165 OF popRelatorios PROMPT "Rela" + CHR(231) + CHR(227) + "o de Mailing" ;
           MESSAGE "Relat" + CHR(243) + "rio de Mailing (SIGREIPR)"
    DEFINE BAR 166 OF popRelatorios PROMPT "\-"
    DEFINE BAR 167 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Etiquetas - Mala Direta" ;
           MESSAGE "Impress" + CHR(227) + "o de Etiquetas de Mala Direta (SIGREIPS)"
    DEFINE BAR 168 OF popRelatorios PROMPT "\-"
    DEFINE BAR 169 OF popRelatorios PROMPT "Balan" + CHR(231) + "o de Invent" + CHR(225) + "rio" ;
           MESSAGE "Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o de Invent" + CHR(225) + "rio (SIGREIR1)"
    DEFINE BAR 170 OF popRelatorios PROMPT "\-"
    DEFINE BAR 171 OF popRelatorios PROMPT "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados" ;
           MESSAGE "Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + "os alterados (SIGPRCCR)"

    ON SELECTION BAR 1  OF popRelatorios DO AbrirRelPlanoContas
    ON SELECTION BAR 3  OF popRelatorios DO AbrirFormsigrecmc
    ON SELECTION BAR 7  OF popRelatorios DO AbrirFormsigregli
    ON SELECTION BAR 9  OF popRelatorios DO AbrirFormsigatcrp
    ON SELECTION BAR 11 OF popRelatorios DO AbrirFormSIGREAUP
    ON SELECTION BAR 13 OF popRelatorios DO AbrirFormsigrepes
    ON SELECTION BAR 15 OF popRelatorios DO AbrirFormSIGREVIS
    ON SELECTION BAR 17 OF popRelatorios DO AbrirFormsigrevto
    ON SELECTION BAR 19 OF popRelatorios DO AbrirFormSigReAac
    ON SELECTION BAR 21 OF popRelatorios DO AbrirFormSIGREADS
    ON SELECTION BAR 23 OF popRelatorios DO AbrirFormSIGREAEG
    ON SELECTION BAR 25 OF popRelatorios DO AbrirFormSIGREAGV
    ON SELECTION BAR 27 OF popRelatorios DO AbrirFormSigReAiv
    ON SELECTION BAR 29 OF popRelatorios DO AbrirFormsigreani
    ON SELECTION BAR 31 OF popRelatorios DO AbrirFormsigreanr
    ON SELECTION BAR 33 OF popRelatorios DO AbrirFormsigreapp
    ON SELECTION BAR 35 OF popRelatorios DO AbrirFormSIGREAPR
    ON SELECTION BAR 37 OF popRelatorios DO AbrirFormSigReAtm
    ON SELECTION BAR 39 OF popRelatorios DO AbrirFormsigreato
    ON SELECTION BAR 41 OF popRelatorios DO AbrirFormsigrebal
    ON SELECTION BAR 43 OF popRelatorios DO AbrirFormSigReCgc
    ON SELECTION BAR 45 OF popRelatorios DO AbrirFormsigrecgp
    ON SELECTION BAR 47 OF popRelatorios DO AbrirFormsigreche
    ON SELECTION BAR 49 OF popRelatorios DO AbrirFormsigrechp
    ON SELECTION BAR 51 OF popRelatorios DO AbrirFormsigrecmm
    ON SELECTION BAR 53 OF popRelatorios DO AbrirFormSigReCmp
    ON SELECTION BAR 55 OF popRelatorios DO AbrirFormSIGRECMV
    ON SELECTION BAR 57 OF popRelatorios DO AbrirFormSIGRECND
    ON SELECTION BAR 59 OF popRelatorios DO AbrirFormsigrecnt
    ON SELECTION BAR 61 OF popRelatorios DO AbrirFormsigrecog
    ON SELECTION BAR 63 OF popRelatorios DO AbrirFormsigrecom
    ON SELECTION BAR 65 OF popRelatorios DO AbrirFormsigrecop
    ON SELECTION BAR 67 OF popRelatorios DO AbrirFormsigrecor
    ON SELECTION BAR 69 OF popRelatorios DO AbrirFormsigrecpe
    ON SELECTION BAR 71 OF popRelatorios DO AbrirFormSIGRECPM
    ON SELECTION BAR 73 OF popRelatorios DO AbrirFormsigrecpr
    ON SELECTION BAR 75 OF popRelatorios DO AbrirFormsigrecrf
    ON SELECTION BAR 77 OF popRelatorios DO AbrirFormsigrecrp
    ON SELECTION BAR 79 OF popRelatorios DO AbrirFormsigrecrt
    ON SELECTION BAR 81 OF popRelatorios DO AbrirFormsigrecsm
    ON SELECTION BAR 83 OF popRelatorios DO AbrirFormsigrectc
    ON SELECTION BAR 85 OF popRelatorios DO AbrirFormSIGRECTP
    ON SELECTION BAR 87 OF popRelatorios DO AbrirFormSigReDdp
    ON SELECTION BAR 89 OF popRelatorios DO AbrirFormSIGREDES
    ON SELECTION BAR 91 OF popRelatorios DO AbrirFormSigReDif
    ON SELECTION BAR 93 OF popRelatorios DO AbrirFormsigredoc
    ON SELECTION BAR 95 OF popRelatorios DO AbrirFormSigReDpD
    ON SELECTION BAR 97 OF popRelatorios DO AbrirFormsigredtv
    ON SELECTION BAR 99  OF popRelatorios DO AbrirFormsigremat
    ON SELECTION BAR 101 OF popRelatorios DO AbrirFormSIGREEGG
    ON SELECTION BAR 103 OF popRelatorios DO AbrirFormsigreegp
    ON SELECTION BAR 105 OF popRelatorios DO AbrirFormsigreeqe
    ON SELECTION BAR 107 OF popRelatorios DO AbrirFormSIGREEQR
    ON SELECTION BAR 109 OF popRelatorios DO AbrirFormSigReEsp
    ON SELECTION BAR 111 OF popRelatorios DO AbrirFormSigReEtl
    ON SELECTION BAR 113 OF popRelatorios DO AbrirFormSIGREEUN
    ON SELECTION BAR 115 OF popRelatorios DO AbrirFormSigReEvd
    ON SELECTION BAR 117 OF popRelatorios DO AbrirFormsigrefec
    ON SELECTION BAR 119 OF popRelatorios DO AbrirFormsigrefcd
    ON SELECTION BAR 121 OF popRelatorios DO AbrirFormsigreffi
    ON SELECTION BAR 123 OF popRelatorios DO AbrirFormsigreffn
    ON SELECTION BAR 125 OF popRelatorios DO AbrirFormSIGREFUN
    ON SELECTION BAR 127 OF popRelatorios DO AbrirFormSIGREFXV
    ON SELECTION BAR 129 OF popRelatorios DO AbrirFormSIGREGDP
    ON SELECTION BAR 131 OF popRelatorios DO AbrirFormsigregnf
    ON SELECTION BAR 133 OF popRelatorios DO AbrirFormsigrehbr
    ON SELECTION BAR 135 OF popRelatorios DO AbrirFormSIGREHCP
    ON SELECTION BAR 137 OF popRelatorios DO AbrirFormSigReHev
    ON SELECTION BAR 139 OF popRelatorios DO AbrirFormSIGREHPE
    ON SELECTION BAR 141 OF popRelatorios DO AbrirFormsigrehpr
    ON SELECTION BAR 143 OF popRelatorios DO AbrirFormsigrehtc
    ON SELECTION BAR 145 OF popRelatorios DO AbrirFormSIGREIDC
    ON SELECTION BAR 147 OF popRelatorios DO AbrirFormSigReIdt
    ON SELECTION BAR 149 OF popRelatorios DO AbrirFormSigReIfp
    ON SELECTION BAR 151 OF popRelatorios DO AbrirFormsigreifx
    ON SELECTION BAR 153 OF popRelatorios DO AbrirFormsigreimc
    ON SELECTION BAR 155 OF popRelatorios DO AbrirFormsigreimp
    ON SELECTION BAR 157 OF popRelatorios DO AbrirFormSigReInf
    ON SELECTION BAR 159 OF popRelatorios DO AbrirFormsigreinr
    ON SELECTION BAR 161 OF popRelatorios DO AbrirFormSigReInv
    ON SELECTION BAR 163 OF popRelatorios DO AbrirFormsigreipe
    ON SELECTION BAR 165 OF popRelatorios DO AbrirFormSigReIpr
    ON SELECTION BAR 167 OF popRelatorios DO AbrirFormSIGREIPS
    ON SELECTION BAR 169 OF popRelatorios DO AbrirFormSigReIr1
    ON SELECTION BAR 171 OF popRelatorios DO AbrirFormSIGPRCCR

    * Menu Ferramentas
    ON PAD padFerramentas OF _MSYSMENU ACTIVATE POPUP popFerramentas

    DEFINE POPUP popFerramentas MARGIN RELATIVE SHADOW COLOR SCHEME 4
    DEFINE BAR 1 OF popFerramentas PROMPT "Configura" + CHR(231) + CHR(245) + "es" ;
           MESSAGE "Configura" + CHR(231) + CHR(245) + "es do Sistema"
    DEFINE BAR 2 OF popFerramentas PROMPT "\-"
    DEFINE BAR 3 OF popFerramentas PROMPT "Bloqueio de Contas" ;
           MESSAGE "Processamento para bloqueio/desbloqueio de contas"
    DEFINE BAR 4 OF popFerramentas PROMPT "Gera" + CHR(231) + CHR(227) + "o CNAB - Pagamentos" ;
           MESSAGE "Gerar arquivos CNAB para remessa de pagamentos banc" + CHR(225) + "rios"
    DEFINE BAR 5 OF popFerramentas PROMPT "\-"
    DEFINE BAR 6 OF popFerramentas PROMPT "Testar Conex" + CHR(227) + "o BD" ;
           MESSAGE "Testa conex" + CHR(227) + "o com banco de dados"
    DEFINE BAR 7 OF popFerramentas PROMPT "\-"
    DEFINE BAR 8 OF popFerramentas PROMPT "Gerar Estrutura de Arquivos" ;
           MESSAGE "Gera arquivos de estrutura e " + CHR(237) + "ndices dos DBFs locais"
    ON SELECTION BAR 3 OF popFerramentas DO AbrirFormSIGBLCTA
    ON SELECTION BAR 4 OF popFerramentas DO AbrirFormSIGPGCNB
    ON SELECTION BAR 6 OF popFerramentas DO TestarConexaoBD
    ON SELECTION BAR 8 OF popFerramentas DO AbrirFormSIGPREST

    * Menu Ajuda
    ON PAD padAjuda OF _MSYSMENU ACTIVATE POPUP popAjuda

    DEFINE POPUP popAjuda MARGIN RELATIVE SHADOW COLOR SCHEME 4
    DEFINE BAR 1 OF popAjuda PROMPT "Sobre o Sistema" ;
           MESSAGE "Informa" + CHR(231) + CHR(245) + "es sobre o sistema"
    ON SELECTION BAR 1 OF popAjuda DO SobreSistema

    * Ativa o menu
    ACTIVATE MENU _MSYSMENU NOWAIT
ENDPROC

*------------------------------------------------------------------------------
* SairSistema - Encerra o sistema
*------------------------------------------------------------------------------
PROCEDURE SairSistema()
    LOCAL lnResposta

    lnResposta = MESSAGEBOX("Deseja realmente sair do sistema?", ;
                            36, ;
                            "Confirmar Sa" + CHR(237) + "da")

    IF lnResposta = 6  && Sim
        CLEAR EVENTS
        SET SYSMENU TO DEFAULT
    ENDIF
ENDPROC

*------------------------------------------------------------------------------
* SobreSistema - Exibe informacoes sobre o sistema
*------------------------------------------------------------------------------
PROCEDURE SobreSistema()
    LOCAL lcMensagem

    lcMensagem = ObterVersaoCompleta() + CHR(13) + CHR(13) + ;
                 "Sistema desenvolvido em Visual FoxPro 9" + CHR(13) + ;
                 "Arquitetura: SOLID + Camadas" + CHR(13) + CHR(13) + ;
                 CHR(169) + " " + TRANSFORM(YEAR(DATE())) + " - " + APP_EMPRESA

    MESSAGEBOX(lcMensagem, 64, "Sobre o Sistema")
ENDPROC

*------------------------------------------------------------------------------
* TestarConexaoBD - Testa conexao com banco de dados
*------------------------------------------------------------------------------
PROCEDURE TestarConexaoBD()
    IF TestarConexao()
        MESSAGEBOX("Conex" + CHR(227) + "o com banco de dados: OK", 64, "Teste de Conex" + CHR(227) + "o")
    ELSE
        MESSAGEBOX("Falha na conex" + CHR(227) + "o com banco de dados!", 16, "Teste de Conex" + CHR(227) + "o")
    ENDIF
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCor - Abre formulario de cadastro de cores
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCor()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormCor")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cores" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Cores:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCargo - Abre formulario de cadastro de cargos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCargo()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormCargo")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cargos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Cargos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDepartamento - Abre formulario de cadastro de departamentos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDepartamento()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormDepartamento")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Departamentos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Departamentos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReInf - Abre formulario de Impressao de Nota Fiscal
* Nota: este form normalmente recebe parametros (empresa/operacao/numero/serie)
* quando chamado de telas operacionais. Sem parametros, abre em estado vazio.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReInf()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReInf")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Nota Fiscal" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Nota Fiscal:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormProduto - Abre formulario de cadastro de produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormProduto()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormProduto")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Produtos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormTam - Abre formulario de cadastro de Tamanhos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormTam()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormTam")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Tamanhos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Tamanhos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormProcessamentoBloqueioContas - Abre formulario de processamento de bloqueio/desbloqueio de contas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormProcessamentoBloqueioContas()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormProcessamentoBloqueioContas")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Processamento de Bloqueio de Contas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Processamento de Bloqueio de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirRelPlanoContas - Abre formulario de relatorio de Plano de Contas
*------------------------------------------------------------------------------
PROCEDURE AbrirRelPlanoContas()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormRelPlanoContas")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Plano de Contas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Plano de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigregli - Abre formulario de impressao de relatorios/etiquetas de producao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigregli(par_nOrdem, par_oParentForm)
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario passando parametros opcionais
        IF PCOUNT() = 0
            loForm = CREATEOBJECT("Formsigregli")
        ELSE
            loForm = CREATEOBJECT("Formsigregli", par_nOrdem, par_oParentForm)
        ENDIF

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Relat" + CHR(243) + "rios/Etiquetas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Relat" + CHR(243) + "rios/Etiquetas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormBloqueioContas - Abre formulario de processamento de bloqueio de contas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormBloqueioContas()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormBloqueioContas")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Bloqueio de Contas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Bloqueio de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormacg - Abre formulario de cadastro de acesso de grupos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormacg()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormAcg")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Acesso de Grupos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Acesso de Grupos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSrv - Abre formulario de cadastro de servicos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSrv()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormSrv")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Servi" + CHR(231) + "os" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Servi" + CHR(231) + "os:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormpgr - Abre formulario de Contas a Pagar e Receber
*------------------------------------------------------------------------------
PROCEDURE AbrirFormpgr()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("Formpgr")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Contas a Pagar/Receber" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Contas a Pagar/Receber:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPGCNB - Abre formulario de Geracao de Arquivos CNAB - Pagamentos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPGCNB()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPGCNB")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MsgErro("Erro ao criar formul" + CHR(225) + "rio de Gera" + CHR(231) + CHR(227) + "o CNAB" + CHR(13) + ;
                   "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        MsgErro("Erro ao abrir Gera" + CHR(231) + CHR(227) + "o CNAB: " + loException.Message, "Erro")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGBLCTA - Abre formulario de Processamento para Bloqueio de Contas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGBLCTA()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("FormSIGBLCTA")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario (WindowType = 1 na classe ja define como modal)
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Processamento de Bloqueio" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Processamento de Bloqueio:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigmvcab - Abre formulario de Movimentacao de Estoque/Operacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigmvcab()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("Formsigmvcab")

        IF VARTYPE(loForm) = "O"
            * Exibe o formulario
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Movimenta" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigatcrp - Abre formulario de relatorio Analitico de Atendimentos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigatcrp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigatcrp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Anal" + CHR(237) + "tico de Atendimentos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio Anal" + CHR(237) + "tico de Atendimentos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREAUP - Abre formulario de relatorio de Tipos de Autorizacoes de Producao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREAUP()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREAUP")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Tipos de Autoriza" + CHR(231) + CHR(245) + "es" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Tipos de Autoriza" + CHR(231) + CHR(245) + "es:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigopind - Abre formulario de Conta Corrente Individual
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigopind()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigopind")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Conta Corrente Individual" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Conta Corrente Individual:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrepes - Abre formulario de relatorio de Posicao de Estoque
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrepes()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrepes")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + "o de Estoque:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigmvccr - Abre formulario de Conta Corrente Geral
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigmvccr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigmvccr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario Formsigmvccr" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Conta Corrente Geral:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormcfo - Abre formulario de cadastro de CFOP
*------------------------------------------------------------------------------
PROCEDURE AbrirFormcfo()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formcfo")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de CFOP" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de CFOP:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormccr - Abre formulario de cadastro de Grupos de Conta Corrente
*------------------------------------------------------------------------------
PROCEDURE AbrirFormccr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formccr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Grupos de C/C" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Grupos de C/C:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormUfs - Abre formulario de cadastro de Estados (UFs)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormUfs()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormUfs")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Estados (UFs)" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Estados (UFs):" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigopdivDivisao - Abre Separa Industrializacao (modo Divisao)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigopdivDivisao()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigopdiv", "D")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Separa Industrializa" + ;
                        CHR(231) + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Separa Industrializa" + CHR(231) + CHR(227) + "o:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigopdivReinicia - Abre Reinicia Industrializacao (modo Reinicio)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigopdivReinicia()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigopdiv", "R")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Reinicia Industrializa" + ;
                        CHR(231) + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Reinicia Industrializa" + CHR(231) + CHR(227) + "o:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGMDETQ - Abre formulario de Mudanca de Cor/Tamanho de Etiqueta
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGMDETQ()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGMDETQ")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Muda Cor/Tamanho Etiqueta" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio Muda Cor/Tamanho Etiqueta:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigAcCcr - Abre formulario de Acesso a Conta Corrente
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigAcCcr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGACGCT")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Acesso a Conta Corrente" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio Acesso a Conta Corrente:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREVIS - Abre formulario de Relatorio de Visitas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREVIS()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREVIS")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Visitas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Visitas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigrevto - Abre formulario de Relatorio Total Por Operacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrevto()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrevto")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio Total Por Opera" + ;
                        CHR(231) + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio Total Por Opera" + ;
                     CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReAac - Abre formulario de Relatorio do Log de Acessos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReAac()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReAac")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio do Log de Acessos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio do Log de Acessos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREADS - Abre formulario de Relatorio de Descontos/Acrescimos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREADS()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREADS")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Descontos/Acr" + ;
                        CHR(233) + "scimos" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Descontos/Acr" + ;
                     CHR(233) + "scimos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREAEG - Abre formulario de Analise de Estoque por Grande Grupo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREAEG()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREAEG")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar An" + CHR(225) + "lise de Estoque por Grande Grupo" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir An" + CHR(225) + "lise de Estoque por Grande Grupo:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREAGV - Abre formulario de Acompanhamento Por Grupo de Venda
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREAGV()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREAGV")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Acompanhamento Por Grupo de Venda" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Acompanhamento Por Grupo de Venda:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigReAiv - Abre formulario de Analise Entre Inventarios
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReAiv()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReAiv")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigreani - Abre formulario de Relatorio de Aniversariantes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreani()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreani")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Aniversariantes" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Aniversariantes:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigreanr - Abre formulario de Relatorio de Resultados
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreanr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreanr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Resultados" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Resultados:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigreapp - Abre formulario de Relatorio de Analise a Pagar/Receber
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreapp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreapp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de An" + CHR(225) + "lise a Pagar / Receber:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREAPR - Abre formulario de Relatorio de Alteracoes de Produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREAPR()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREAPR")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Altera" + CHR(231) + ;
                        CHR(245) + "es de Produtos" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Altera" + CHR(231) + ;
                     CHR(245) + "es de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigReAtm - Abre formulario de Analise por Tipo de Material
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReAtm()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReAtm")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar An" + CHR(225) + "lise por Tipo de Material" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir An" + CHR(225) + "lise por Tipo de Material:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigreato - Abre formulario de Analise de Estoque por Tipo de Operacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreato()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreato")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar An" + CHR(225) + "lise de Estoque por Tipo de Opera" + ;
                        CHR(231) + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir An" + CHR(225) + "lise de Estoque por Tipo de Opera" + ;
                     CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrebal - Abre formulario de Relatorio de Balanco
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrebal()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrebal")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Balan" + CHR(231) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigReCgc - Abre formulario de Relatorio Generico de Compras
*   Parametros Grupo e Conta sao passados vazios ao abrir pelo menu;
*   o subtitulo do relatorio exibe apenas "GRUPO : /CONTA : " neste caso.
*   Para abrir com contexto especifico, chamar diretamente com os parametros.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReCgc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReCgc", "", "")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio Gen" + CHR(233) + "rico de Compras:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecgp - Abre formulario de Relatorio de Composicao de Produtos
*   Abre standalone (sem form pai); tipo 5 requer form pai com filtro de
*   operacao. Para abrir com contexto especifico, chamar com par_oParentForm.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecgp(par_oParentForm)
    LOCAL loForm, loException

    TRY
        IF VARTYPE(par_oParentForm) = "O"
            loForm = CREATEOBJECT("Formsigrecgp", par_oParentForm)
        ELSE
            loForm = CREATEOBJECT("Formsigrecgp")
        ENDIF

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Composi" + ;
                CHR(231) + CHR(227) + "o de Produtos" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Composi" + ;
                     CHR(231) + CHR(227) + "o de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigreche - Abre formulario de Relatorio de Cheques
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreche()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreche")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Cheques" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Cheques:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrechp - Abre formulario de Relatorio de Cheques Pendentes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrechp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrechp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Cheques Pendentes" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Cheques Pendentes:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecmc - Abre relatorio de Clientes que Mais/Menos/Nao Compram
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecmc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecmc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Clientes que " + ;
                "Mais/Menos/N" + CHR(227) + "o Compram" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Clientes que " + ;
                     "Mais/Menos/N" + CHR(227) + "o Compram:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecmm - Abre formulario de Relatorio de Mapa de Comissao Por Vendedor
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecmm()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecmm")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Mapa de Comiss" + ;
                        CHR(227) + "o Por Vendedor" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Mapa de Comiss" + ;
                     CHR(227) + "o Por Vendedor:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


PROCEDURE AbrirFormSigReCmp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReCmp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Listagem de Composi" + CHR(231) + CHR(227) + ;
                        "o Por Movimenta" + CHR(231) + CHR(227) + "o/OP" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Listagem de Composi" + CHR(231) + CHR(227) + ;
                     "o Por Movimenta" + CHR(231) + CHR(227) + "o/OP:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGRECMV - Abre formulario de Relatorio CMV - Custo Medio de Venda
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGRECMV()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGRECMV")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio CMV - Custo M" + ;
                        CHR(233) + "dio de Venda" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio CMV - Custo M" + ;
                     CHR(233) + "dio de Venda:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGRECND - Abre formulario de Relatorio de Posicao de Lancamentos Nao Conciliados
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGRECND()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGRECND")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Posi" + ;
                        CHR(231) + CHR(227) + "o de Lan" + CHR(231) + ;
                        "amentos N" + CHR(227) + "o Conciliados" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Posi" + ;
                     CHR(231) + CHR(227) + "o de Lan" + CHR(231) + ;
                     "amentos N" + CHR(227) + "o Conciliados:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecnt - Abre formulario de Relatorio de Contagem por Localizacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecnt()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecnt")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Contagem por " + ;
                        "Localiza" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Contagem por " + ;
                     "Localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecrf - Abre formulario de Relatorio de Contagem por Referencia
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecrf()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecrf")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Contagem por " + ;
                        "Refer" + CHR(234) + "ncia" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Contagem por " + ;
                     "Refer" + CHR(234) + "ncia:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecog - Abre formulario de Relatorio de Comissao por Grupo de Produto
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecog()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecog")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                        "o por Grupo de Produto" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                     "o por Grupo de Produto:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecom - Abre formulario de Relatorio de Comissao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecom()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecom")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecop - Abre formulario de Relatorio de Comissoes por Recebimento
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecop()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecop")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Comiss" + CHR(245) + "es por Recebimento" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Comiss" + CHR(245) + "es por Recebimento:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecor - Abre formulario de Relatorio de Comissao Pendente por Vendedor
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecor()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecor")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Comiss" + ;
                        CHR(227) + "o Pendente por Vendedor" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Comiss" + ;
                     CHR(227) + "o Pendente por Vendedor:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecpe - Abre formulario de Relatorio de Divergencias em Estoques
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecpe()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecpe")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Diverg" + CHR(234) + ;
                        "ncias em Estoques" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Diverg" + CHR(234) + ;
                     "ncias em Estoques:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGRECPM - Abre formulario de Relatorio de Composicao por OP
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGRECPM()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGRECPM")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Listagem de Composi" + CHR(231) + CHR(227) + ;
                        "o por OP" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Listagem de Composi" + CHR(231) + CHR(227) + ;
                     "o por OP:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecpr - Abre formulario de Relatorio de Cheques Prorrogados
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecpr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecpr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Cheques Prorrogados" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Cheques Prorrogados:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecrp - Abre formulario de Relatorio de Debitos/Creditos Pendentes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecrp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecrp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de D" + CHR(233) + ;
                        "bitos/Cr" + CHR(233) + "ditos Pendentes" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de D" + CHR(233) + ;
                     "bitos/Cr" + CHR(233) + "ditos Pendentes:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrecrt - Abre relatorio de Cheques da Carteira
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrecrt()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecrt")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Cheques Da Carteira" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Cheques Da Carteira:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


PROCEDURE AbrirFormsigrecsm()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrecsm")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                        "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                     "o por Condi" + CHR(231) + CHR(227) + "o de Pagamento:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrectc - Abre formulario de relatorio de Movimentacao de Cartoes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrectc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrectc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Movimenta" + CHR(231) + CHR(227) + ;
                        "o de Cart" + CHR(245) + "es" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Movimenta" + CHR(231) + CHR(227) + ;
                     "o de Cart" + CHR(245) + "es:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGRECTP - Abre formulario de relatorio de Cotacao de Compras
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGRECTP()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGRECTP")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + ;
                        "o de Compras" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Cota" + CHR(231) + CHR(227) + ;
                     "o de Compras:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigReDdp - Abre formulario de Relatorio Demonstrativo de Balanco
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReDdp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReDdp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio Demonstrativo de Balan" + CHR(231) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio Demonstrativo de Balan" + CHR(231) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREDES - Abre formulario de Relatorio de Cotas de Desconto
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREDES()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREDES")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Cotas de Desconto" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Cotas de Desconto:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReDif - Abre visualizador de Diferencas Encontradas (Contabilidade)
*   NOTA: Este form recebe DataSessionId do form chamador (movaux/dif2).
*   Quando aberto do menu sem contexto, o grid ficara vazio.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReDif()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReDif")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Visualizador de Diferen" + CHR(231) + "as Encontradas" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Visualizador de Diferen" + CHR(231) + "as Encontradas:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigredoc - Abre formulario de Impressao de Documento
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigredoc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigredoc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Documento" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Documento:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReDpD - Abre formulario de Relatorio de Analise de Producao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReDpD()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReDpD")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de An" + CHR(225) + ;
                        "lise de Produ" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de An" + CHR(225) + ;
                     "lise de Produ" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigredtv - Abre formulario de Demonstrativo de Conta Corrente (Tipo=1)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigredtv()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigredtv", 1)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Demonstrativo de Conta Corrente" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Demonstrativo de Conta Corrente:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigremat - Abre formulario de Mapa de Contas (Tipo=2)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigremat()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigredtv", 2)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Mapa de Contas" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Mapa de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReEch()
    MsgAviso("Emiss" + CHR(227) + "o de Cheque deve ser aberta a partir do m" + ;
             CHR(243) + "dulo Contas a Pagar." + CHR(13) + CHR(13) + ;
             "Acesse: Movimentos > Contas a Pagar e selecione um t" + ;
             CHR(237) + "tulo para emitir o cheque.", ;
             "Emiss" + CHR(227) + "o de Cheque")
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREEGG - Abre formulario de Posicao de Estoque por Grande Grupo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREEGG()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREEGG")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreegp - Abre formulario de Posicao de Estoque por Grupo de Produto
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreegp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreegp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Posi" + CHR(231) + CHR(227) + "o de Estoque por Grupo de Produto" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Posi" + CHR(231) + CHR(227) + "o de Estoque por Grupo de Produto:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreeqe - Abre relatorio de Posicao de Etiquetas por Empresa
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreeqe()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreeqe")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREEQR - Abre relatorio de Posicao de Estoque Retroativo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREEQR()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREEQR")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Posi" + CHR(231) + CHR(227) + "o de Estoque Retroativo" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Posi" + CHR(231) + CHR(227) + "o de Estoque Retroativo:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReEsp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReEsp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Estat" + CHR(237) + "stica de Pedidos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Estat" + CHR(237) + "stica de Pedidos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReEtl - Abre formulario de relatorio de Estoque Por Localizacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReEtl()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReEtl")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Estoque Por Localiza" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Estoque Por Localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREEUN - Abre relatorio de Posicao de Estoque por Unidade
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREEUN()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREEUN")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Posi" + CHR(231) + CHR(227) + "o de Estoque por Unidade" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Posi" + CHR(231) + CHR(227) + "o de Estoque por Unidade:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReEvd - Abre relatorio Demonstrativo de Envelopes Duplicados
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReEvd()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReEvd")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Demonstrativo de Envelopes Duplicados" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Demonstrativo de Envelopes Duplicados:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigrefc2 - Abre formulario de relatorio de Fechamento de Caixa
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrefc2()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrefc2")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Fechamento de Caixa" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Fechamento de Caixa:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigrefcx - Abre relatorio Fechamento de Caixa (completo)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrefcx()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrefcx")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Fechamento de Caixa" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Fechamento de Caixa:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigrefcd - Abre relatorio Informativo de Vendas Diarias
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrefcd()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrefcd")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio Informativo de Vendas Di" + ;
                CHR(225) + "rias" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio Informativo de Vendas Di" + ;
                     CHR(225) + "rias:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigrefec - Abre relatorio Fechamento de Caixa (migrado de SIGREFEC.SCX)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrefec()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrefec")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Fechamento de Caixa" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Fechamento de Caixa:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreffi - Abre relatorio de Fluxo Financeiro Analitico
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreffi()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreffi")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Fluxo Financeiro - Anal" + CHR(237) + "tico:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreffn - Abre relatorio de Fluxo Financeiro Sintetico
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreffn()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreffn")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREFUN - Abre relatorio de Relacao de Tubos Fundicao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREFUN()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREFUN")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Rela" + CHR(231) + CHR(227) + "o Tubos Fundi" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Rela" + CHR(231) + CHR(227) + "o Tubos Fundi" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREFXV - Abre formulario de Relatorio de Posicao de Estoque por Grupo/Faixa de Valor
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREFXV()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREFXV")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Posi" + CHR(231) + CHR(227) + ;
                "o de Estoque por Grupo/Faixa de Valor" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Posi" + CHR(231) + CHR(227) + ;
                     "o de Estoque por Grupo/Faixa de Valor:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREGDP()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREGDP")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Emiss" + CHR(227) + ;
                "o Global de Duplicatas/Boletos" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Emiss" + CHR(227) + "o Global de Duplicatas/Boletos:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigregnf()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigregnf")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Emiss" + CHR(227) + ;
                "o Global de Nota Fiscal" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Emiss" + CHR(227) + "o Global de Nota Fiscal:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigrehbr - Abre formulario de Relatorio Codigos de Barras Por Estoque
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrehbr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrehbr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de C" + CHR(243) + ;
                "digos de Barras Por Estoque" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir C" + CHR(243) + "digos de Barras Por Estoque:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREHCP - Abre formulario de Relatorio Historico de Custo de Produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREHCP()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREHCP")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Hist" + CHR(243) + ;
                "rico de Custo de Produtos" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Hist" + CHR(243) + "rico de Custo de Produtos:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReHev - Abre formulario de relatorio Historico de Envelopes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReHev()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReHev")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Hist" + CHR(243) + "rico de Envelopes" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Hist" + CHR(243) + "rico de Envelopes:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGREHPE - Abre formulario de relatorio Resumo de Cheques Pendentes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREHPE()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREHPE")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Resumo de Cheques Pendentes" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Resumo de Cheques Pendentes:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigrehpr - Abre formulario de relatorio Historico de Produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrehpr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrehpr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Hist" + CHR(243) + ;
                       "rico de Produtos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Hist" + CHR(243) + "rico de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigrehtc - Abre formulario de Relatorio de Cheques Emitidos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigrehtc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigrehtc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cheques Emitidos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Cheques Emitidos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREIDC - Abre formulario de Relatorio de Identificacao de Contas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREIDC()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREIDC")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Identifica" + ;
                        CHR(231) + CHR(227) + "o de Contas" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Identifica" + ;
                     CHR(231) + CHR(227) + "o de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReIdt - Abre formulario de Impressao de Documento de Titulo
* Parametros opcionais: pEmp, pDop, pNum, pNumF, pDir
* (Normalmente chamado por outros forms com parametros pre-preenchidos)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReIdt(par_pEmp, par_pDop, par_pNum, par_pNumF, par_pDir)
    LOCAL loForm, loException
    LOCAL loc_cEmp, loc_cDop, loc_cNum, loc_nNumF, loc_cDir

    loc_cEmp  = IIF(TYPE("par_pEmp")  = "C", par_pEmp,  "")
    loc_cDop  = IIF(TYPE("par_pDop")  = "C", par_pDop,  "")
    loc_cNum  = IIF(TYPE("par_pNum")  = "C", par_pNum,  "")
    loc_nNumF = IIF(TYPE("par_pNumF") = "N", par_pNumF, 0)
    loc_cDir  = IIF(TYPE("par_pDir")  = "C", par_pDir,  "")

    TRY
        loForm = CREATEOBJECT("FormSigReIdt", "", loc_cEmp, loc_cDop, loc_cNum, loc_nNumF, loc_cDir)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + ;
                        CHR(227) + "o de Documento de T" + CHR(237) + "tulo" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Documento de T" + CHR(237) + "tulo:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReIfp - Abre formulario de Relatorio de Falhas / Perdas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReIfp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReIfp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio de Falhas / Perdas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Falhas / Perdas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreifx - Abre formulario de impressao de documentos comerciais
*   NOTA: Normalmente chamado por formularios de movimento (SigMvCab) com
*   parametros do documento. Abertura via menu usa empresa corrente sem doc.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreifx()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreifx", ;
            go_4c_Sistema.cCodEmpresa, "", 0, 0, .F.)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Impress" + CHR(227) + "o de Documentos Comerciais" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Documentos Comerciais:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReIiv - Abre formulario de Impressao de Invoice
*   NOTA: Chamado por formularios de movimento com parametros do pedido.
*   par_pEmp   = Codigo da empresa (3 chars)
*   par_pDop   = Codigo da operacao (20 chars)
*   par_nNum   = Numero do pedido
*   par_nTpImp = Tipo de impressao (1=preview, 2=imprimir, 3=auto, 4=prompt+impr)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReIiv(par_pEmp, par_pDop, par_nNum, par_nTpImp)
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReIiv", par_pEmp, par_pDop, par_nNum, par_nTpImp)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Impress" + CHR(227) + "o de Invoice" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Invoice:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreimc - Abre formulario de Impressao de Cartas
* Aceita parametros opcionais passados de outro formulario (ex: NF de origem)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreimc(par_cEmp, par_cSerie, par_dEmisDe, par_dEmisAte, ;
                             par_cEDNs, par_cNotaIni, par_cNotaFim)
    LOCAL loForm, loException

    TRY
        IF PCOUNT() = 0
            loForm = CREATEOBJECT("Formsigreimc")
        ELSE
            loForm = CREATEOBJECT("Formsigreimc", par_cEmp, par_cSerie, ;
                        par_dEmisDe, par_dEmisAte, par_cEDNs, par_cNotaIni, par_cNotaFim)
        ENDIF

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Impress" + CHR(227) + "o de Cartas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Cartas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreimp - Abre formulario de Relatorio Comparativo de Impostos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreimp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreimp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar Relat" + CHR(243) + "rio Comparativo de Impostos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio Comparativo de Impostos:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreinr - Abre formulario de Relatorio de Inventario
* Requer numero do balanco (consulta o mais recente do banco)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreinr()
    LOCAL loForm, loException, loc_nNumBal, loc_nResult, lcEmpr, loc_cInput
    loc_nNumBal = 0

    TRY
        lcEmpr = go_4c_Sistema.cCodEmpresa
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT MAX(Codigos) AS UltBal FROM SigCdBal WHERE Emps = ?lcEmpr", ;
            "cursor_4c_sigreinr_bal")
        IF loc_nResult > 0 AND USED("cursor_4c_sigreinr_bal")
            SELECT cursor_4c_sigreinr_bal
            GO TOP
            IF !EOF() AND !ISNULL(cursor_4c_sigreinr_bal.UltBal)
                loc_nNumBal = cursor_4c_sigreinr_bal.UltBal
            ENDIF
            USE IN cursor_4c_sigreinr_bal
        ENDIF
    CATCH TO loException
        MsgErro(loException.Message, "Erro")
    ENDTRY

    IF loc_nNumBal <= 0
        loc_cInput = INPUTBOX("Informe o n" + CHR(250) + "mero do Invent" + CHR(225) + "rio:", ;
            "Invent" + CHR(225) + "rio", "")
        IF EMPTY(loc_cInput)
            RETURN
        ENDIF
        loc_nNumBal = VAL(loc_cInput)
        IF loc_nNumBal <= 0
            RETURN
        ENDIF
    ENDIF

    TRY
        loForm = CREATEOBJECT("Formsigreinr", loc_nNumBal)
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Invent" + CHR(225) + "rio" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReInv - Abre formulario de Relatorio de Inventario de Estoque
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReInv()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReInv")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Invent" + CHR(225) + "rio de Estoque" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Invent" + CHR(225) + "rio de Estoque:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigreipe - Abre formulario de Impressao de Etiquetas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigreipe()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigreipe")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Etiquetas" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Etiquetas:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReIpr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigReIpr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Mailing" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Mailing:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGREIPS - Abre formulario de Impressao de Etiquetas - Mala Direta
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGREIPS()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGREIPS")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Etiquetas - Mala Direta" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Etiquetas - Mala Direta:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigReIr1 - Abre formulario de Relatorio de Balanco de Inventario
* Consulta o balanco mais recente da empresa; solicita numero manualmente se
* nao houver registro em SigCdBal.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigReIr1()
    LOCAL loForm, loException, loc_nNumBal, loc_nResult, lcEmpr, loc_cInput
    loc_nNumBal = 0

    TRY
        lcEmpr = go_4c_Sistema.cCodEmpresa
        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT MAX(Codigos) AS UltBal FROM SigCdBal WHERE Emps = ?lcEmpr", ;
            "cursor_4c_sigreir1_bal")
        IF loc_nResult > 0 AND USED("cursor_4c_sigreir1_bal")
            SELECT cursor_4c_sigreir1_bal
            GO TOP
            IF !EOF() AND !ISNULL(cursor_4c_sigreir1_bal.UltBal)
                loc_nNumBal = cursor_4c_sigreir1_bal.UltBal
            ENDIF
            USE IN cursor_4c_sigreir1_bal
        ENDIF
    CATCH TO loException
        MsgErro(loException.Message, "Erro")
    ENDTRY

    IF loc_nNumBal <= 0
        loc_cInput = INPUTBOX("Informe o n" + CHR(250) + "mero do Balan" + CHR(231) + "o:", ;
            "Balan" + CHR(231) + "o de Invent" + CHR(225) + "rio", "")
        IF EMPTY(loc_cInput)
            RETURN
        ENDIF
        loc_nNumBal = VAL(loc_cInput)
        IF loc_nNumBal <= 0
            RETURN
        ENDIF
    ENDIF

    TRY
        loForm = CREATEOBJECT("FormSigReIr1", loc_nNumBal)
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Balan" + CHR(231) + ;
                "o de Invent" + CHR(225) + "rio" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Relat" + CHR(243) + "rio de Balan" + CHR(231) + ;
                     "o de Invent" + CHR(225) + "rio:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigpdmp7 - Abre formulario de Movimentacao por Funcionario
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigpdmp7()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigpdmp7")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Movimenta" + CHR(231) + CHR(227) + "o por Funcion" + CHR(225) + "rio" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Movimenta" + CHR(231) + CHR(227) + "o por Funcion" + CHR(225) + "rio:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPdMpf - Abre form de filtro de Movimentacoes de Producao por Funcionario
* O form de filtro coleta periodo/operacao/grupo/conta e abre FormSigPdMp7 com resultados
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPdMpf()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPdMpf")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Movimenta" + CHR(231) + ;
                        CHR(227) + "o por Funcion" + CHR(225) + "rio" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Movimenta" + CHR(231) + ;
                     CHR(227) + "o por Funcion" + CHR(225) + "rio:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGPDPNS - Abre formulario de Consulta de Pendentes
* NOTA: Form requer chave de sessao (pKey). Chamado sem parametro do menu,
*       exibe form vazio; uso tipico e via chamada programatica com pKey.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPDPNS()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPDPNS", "")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Pendentes" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Pendentes:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrAop - Abre formulario de Alteracao de Quantidade da O.P.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrAop()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrAop")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Altera" + CHR(231) + CHR(227) + "o de Quantidade da O.P.:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrApr - Abre formulario de Reajuste de Precificacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrApr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrApr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Reajuste de Precifica" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Reajuste de Precifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigPrCcc - Abre formulario de Recalculo de Saldos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrCcc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrCcc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Rec" + CHR(225) + "lculo de Saldos." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Rec" + CHR(225) + "lculo de Saldos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrCcp - Abre formulario de Recalculo de Precos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrCcp()
    LOCAL loc_oForm, loc_oErro
    TRY
        loc_oForm = CREATEOBJECT("Formsigprccp")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgErro("Erro ao criar formul" + CHR(225) + "rio de Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os.", "Erro")
        ENDIF
    CATCH TO loc_oErro
        MsgErro("Erro ao abrir Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os: " + loc_oErro.Message, "Erro")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRCCR - Abre formulario de impressao de Produtos com Preco Alterado
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRCCR()
    LOCAL loc_oForm, loc_oErro
    TRY
        loc_oForm = CREATEOBJECT("FormSIGPRCCR")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + ;
                    "o de Produtos com Pre" + CHR(231) + "os alterados." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
        ENDIF
    CATCH TO loc_oErro
        MsgErro("Erro ao abrir Impress" + CHR(227) + "o de Produtos com Pre" + CHR(231) + ;
                "os alterados:" + CHR(13) + CHR(13) + ;
                "Erro: " + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigPrCfn - Abre calculadora de Calculo de Juros
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrCfn()
    LOCAL loc_oForm, loc_oErro

    TRY
        loc_oForm = CREATEOBJECT("FormSigPrCfn")

        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgErro("Erro ao criar formul" + CHR(225) + "rio de C" + CHR(225) + ;
                    "lculo de Juros." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
        ENDIF

    CATCH TO loc_oErro
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loc_oErro.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                     "Procedure: " + loc_oErro.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSIGPRCNB - Abre formulario de Geracao de Arquivos CNAB Cobranca
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRCNB()
    LOCAL loc_oForm, loc_oErro
    TRY
        loc_oForm = CREATEOBJECT("FormSIGPRCNB")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MsgErro("Erro ao criar formul" + CHR(225) + "rio de Gera" + CHR(231) + ;
                    CHR(227) + "o CNAB Cobran" + CHR(231) + "a." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
        ENDIF
    CATCH TO loc_oErro
        MsgErro("Erro ao abrir Gera" + CHR(231) + CHR(227) + "o CNAB Cobran" + CHR(231) + "a:" + ;
                CHR(13) + CHR(13) + ;
                "Erro: " + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigprcom - Abre formulario de Estoque Maximo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprcom()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprcom")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Estoque M" + CHR(225) + "ximo" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Estoque M" + CHR(225) + "ximo:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprcpd - Abre formulario de Capacidade Produtiva
* Nota: este form recebe parametros (fase, unidade, data, codigo) quando chamado
* de telas de planejamento. Sem parametros, abre com data corrente e codigo 0.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprcpd()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprcpd", "", "", DATE(), 0)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Capacidade Produtiva" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Capacidade Produtiva:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprdis - Abre formulario de Distribuicao de Produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprdis()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprdis")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Distribui" + CHR(231) + CHR(227) + "o de Produtos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Distribui" + CHR(231) + CHR(227) + "o de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrCtr - Abre formulario de Controle de Movimentacoes por XML
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrCtr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrCtr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Controle de Movimenta" + CHR(231) + CHR(227) + "o por XML" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Controle de Movimenta" + CHR(231) + CHR(227) + "o por XML:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrDsc - Abre formulario de Montagem de Descricao de Produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrDsc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrDsc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Montagem de Descri" + CHR(231) + CHR(227) + "o de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigpres2 - Abre formulario de Pressupostos (consulta movimentos)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigpres2()
    LOCAL loForm, loException

    TRY
        * Cria instancia do formulario
        loForm = CREATEOBJECT("Formsigpres2")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
            *-- NAO chamar loForm.Release() - FormBase cuida disso
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Formsigpres2" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Pressupostos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPREST - Abre utilitario de geracao de estrutura de arquivos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPREST()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPREST")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Gerar Estrutura" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Gerar Estrutura:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrFem - Abre formulario de Analise de Producao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrFem()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrFem")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrEtq - Abre formulario de Impressao de Etiquetas Selecionadas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrEtq()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrEtq")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Etiquetas Selecionadas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Etiquetas Selecionadas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrGlo - Abre formulario de Processamento de O.P.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrGlo()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrGlo")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Processamento de O.P." + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Processamento de O.P.:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrGloT - Abre formulario de Processamento Global por Tipo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrGloT()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrGloT")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Processamento Global por Tipo" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Processamento Global por Tipo:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrGlx - Abre formulario de Previa da Globalizacao / Reserva Automatica
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrGlx()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrGlx")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* NOTA: Este arquivo contem apenas procedimentos
* A chamada de CriarMenuPrincipal() e READ EVENTS deve ser feita
* no programa principal (main.prg)
*------------------------------------------------------------------------------
