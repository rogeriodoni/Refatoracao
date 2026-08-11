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
    DEFINE BAR 22 OF popCadastros PROMPT "\-"
    DEFINE BAR 23 OF popCadastros PROMPT "Instru" + CHR(231) + CHR(245) + "es de Impress" + CHR(227) + "o" ;
           MESSAGE "Cadastro de Instru" + CHR(231) + CHR(245) + "es de Impress" + CHR(227) + "o"
    DEFINE BAR 24 OF popCadastros PROMPT "Lan" + CHR(231) + "amentos C/C" ;
           MESSAGE "Cadastro de Lan" + CHR(231) + "amentos de Conta Corrente"
    DEFINE BAR 25 OF popCadastros PROMPT "Acesso de Empresas" ;
           MESSAGE "Controle de Acesso por Empresa"
    DEFINE BAR 26 OF popCadastros PROMPT "Acessos de JOB" ;
           MESSAGE "Cadastro de Acessos de JOB"
    DEFINE BAR 27 OF popCadastros PROMPT "Al" + CHR(237) + "neas" ;
           MESSAGE "Cadastro de Al" + CHR(237) + "neas"
    DEFINE BAR 28 OF popCadastros PROMPT "Tipos de " + CHR(193) + "rvore" ;
           MESSAGE "Cadastro de Tipos de " + CHR(193) + "rvore"
    DEFINE BAR 29 OF popCadastros PROMPT "Invent" + CHR(225) + "rio/Balan" + CHR(231) + "o" ;
           MESSAGE "Invent" + CHR(225) + "rio e Balan" + CHR(231) + "o de Estoque"
    DEFINE BAR 30 OF popCadastros PROMPT "Bandeiras de Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito" ;
           MESSAGE "Cadastro de Bandeiras de Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"
    DEFINE BAR 31 OF popCadastros PROMPT "Balan" + CHR(231) + "o de Cheques" ;
           MESSAGE "Balan" + CHR(231) + "o de Cheques"
    DEFINE BAR 32 OF popCadastros PROMPT "Bloqueios por Per" + CHR(237) + "odo" ;
           MESSAGE "Cadastro de Bloqueios por Per" + CHR(237) + "odo"
    DEFINE BAR 33 OF popCadastros PROMPT "\-"
    DEFINE BAR 34 OF popCadastros PROMPT "Cadastros Gerais" ;
           MESSAGE "Cadastro de Registros Gerais (SigCdCad - parametrizado)"
    DEFINE BAR 35 OF popCadastros PROMPT "\-"
    DEFINE BAR 36 OF popCadastros PROMPT "Cancelamento de OP da Fundi" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Cancelamento de Ordens de Produ" + CHR(231) + CHR(227) + "o da Fundi" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 37 OF popCadastros PROMPT "Categorias de Produto" ;
           MESSAGE "Cadastro de Categorias de Produto"
    DEFINE BAR 38 OF popCadastros PROMPT "\-"
    DEFINE BAR 39 OF popCadastros PROMPT "C" + CHR(225) + "lculo de Juros" ;
           MESSAGE "Cadastro de C" + CHR(225) + "lculo de Juros"
    DEFINE BAR 40 OF popCadastros PROMPT "Classifica" + CHR(231) + CHR(227) + "o de Contas" ;
           MESSAGE "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Contas"
    DEFINE BAR 41 OF popCadastros PROMPT "Acesso a Consulta Gen" + CHR(233) + "rica" ;
           MESSAGE "Cadastro de Acesso a Consulta Gen" + CHR(233) + "rica de Situa" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 42 OF popCadastros PROMPT "Prioridade de Estoque/Globaliza" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Cadastro de Prioridade de Estoque p/Globaliza" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 43 OF popCadastros PROMPT "\-"
    DEFINE BAR 44 OF popCadastros PROMPT "CEP" ;
           MESSAGE "Cadastro de CEP"
    DEFINE BAR 45 OF popCadastros PROMPT "Classifica" + CHR(231) + CHR(227) + "o de Estoque" ;
           MESSAGE "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Estoque"
    DEFINE BAR 46 OF popCadastros PROMPT "Configura" + CHR(231) + CHR(227) + "o de Boletos Banc" + CHR(225) + "rios" ;
           MESSAGE "Configura" + CHR(231) + CHR(227) + "o de Boletos Banc" + CHR(225) + "rios"
    DEFINE BAR 47 OF popCadastros PROMPT "ICMS - Cupom Fiscal" ;
           MESSAGE "Cadastro de ICMS para Cupom Fiscal"
    DEFINE BAR 48 OF popCadastros PROMPT "\-"
    DEFINE BAR 49 OF popCadastros PROMPT "Carteira de Cheques" ;
           MESSAGE "Cadastro de Carteira de Cheques"
    DEFINE BAR 50 OF popCadastros PROMPT "Config. Cheque Matricial" ;
           MESSAGE "Configura" + CHR(231) + CHR(227) + "o do Cheque Matricial"
    DEFINE BAR 51 OF popCadastros PROMPT "Classifica" + CHR(231) + CHR(227) + "o de Produto" ;
           MESSAGE "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Produto"
    DEFINE BAR 52 OF popCadastros PROMPT "Comparativos Entre Locais" ;
           MESSAGE "Cadastro de Comparativos Entre Locais de Estoque"
    DEFINE BAR 53 OF popCadastros PROMPT "Classifica" + CHR(231) + CHR(227) + "o Fiscal" ;
           MESSAGE "Cadastro de Classifica" + CHR(231) + CHR(227) + "o Fiscal"

    DEFINE BAR 54 OF popCadastros PROMPT "Compra Para" ;
           MESSAGE "Cadastro de Compra Para"
    DEFINE BAR 55 OF popCadastros PROMPT "Contagem por Localiza" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
    DEFINE BAR 56 OF popCadastros PROMPT "Conquilhas" ;
           MESSAGE "Cadastro de Conquilhas"
    DEFINE BAR 57 OF popCadastros PROMPT "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos" ;
           MESSAGE "Cadastro de Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
    DEFINE BAR 58 OF popCadastros PROMPT "Grupos de Venda" ;
           MESSAGE "Cadastro de Grupos de Venda"
    DEFINE BAR 59 OF popCadastros PROMPT "Comiss" + CHR(245) + "es" ;
           MESSAGE "Cadastro de Comiss" + CHR(245) + "es"
    DEFINE BAR 60 OF popCadastros PROMPT "Caracter" + CHR(237) + "sticas de Contas" ;
           MESSAGE "Cadastro de Caracter" + CHR(237) + "sticas de Contas"
    DEFINE BAR 61 OF popCadastros PROMPT "Contagem de Refer" + CHR(234) + "ncia" ;
           MESSAGE "Cadastro de Contagem de Refer" + CHR(234) + "ncia"
    DEFINE BAR 62 OF popCadastros PROMPT "\-"
    DEFINE BAR 63 OF popCadastros PROMPT "Caracter" + CHR(237) + "sticas de Produtos" ;
           MESSAGE "Cadastro de Caracter" + CHR(237) + "sticas de Produtos"
    DEFINE BAR 64 OF popCadastros PROMPT "Caracter" + CHR(237) + "sticas de Contas (CRP)" ;
           MESSAGE "Cadastro de Caracter" + CHR(237) + "sticas de Contas (SigCrRaP)"
    DEFINE BAR 65 OF popCadastros PROMPT "Caracter" + CHR(237) + "sticas de Movimenta" + CHR(231) + CHR(245) + "es" ;
           MESSAGE "Cadastro de Caracter" + CHR(237) + "sticas de Movimenta" + CHR(231) + CHR(245) + "es"
    DEFINE BAR 66 OF popCadastros PROMPT "\-"
    DEFINE BAR 67 OF popCadastros PROMPT "Retrabalhos" ;
           MESSAGE "Cadastro de Retrabalhos"
    DEFINE BAR 68 OF popCadastros PROMPT "Categoria do Site" ;
           MESSAGE "Cadastro de Categoria do Site"
    DEFINE BAR 69 OF popCadastros PROMPT "\-"
    DEFINE BAR 70 OF popCadastros PROMPT "Constantes" ;
           MESSAGE "Cadastro de Constantes"
    DEFINE BAR 71 OF popCadastros PROMPT "Cadastro de Contas" ;
           MESSAGE "Cadastro de Contas (SigCdCli)"
    DEFINE BAR 72 OF popCadastros PROMPT "Categorias" ;
           MESSAGE "Cadastro de Categorias (SigCdCtg)"
    DEFINE BAR 73 OF popCadastros PROMPT "Comiss" + CHR(245) + "es por Cargo" ;
           MESSAGE "Cadastro de Comiss" + CHR(245) + "es de Vendedores por Cargos"
    DEFINE BAR 74 OF popCadastros PROMPT "Comiss" + CHR(245) + "es Individuais" ;
           MESSAGE "Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais"
    DEFINE BAR 75 OF popCadastros PROMPT "Cotas de Desconto por Per" + CHR(237) + "odo" ;
           MESSAGE "Cadastro de Cotas de Desconto por Per" + CHR(237) + "odo"
    DEFINE BAR 76 OF popCadastros PROMPT "Dicion" + CHR(225) + "rio de Idiomas" ;
           MESSAGE "Cadastro de Dicion" + CHR(225) + "rio de Idiomas (SigCdDic)"
    DEFINE BAR 77 OF popCadastros PROMPT "Departamentos do Site" ;
           MESSAGE "Cadastro de Departamentos do Site"
    DEFINE BAR 78 OF popCadastros PROMPT "Fichas T" + CHR(233) + "cnicas" ;
           MESSAGE "Cadastro de Fichas T" + CHR(233) + "cnicas (SigCdDrs)"
    DEFINE BAR 79 OF popCadastros PROMPT "Disponibilidades" ;
           MESSAGE "Cadastro de Disponibilidades (SigCdDis)"
    DEFINE BAR 80 OF popCadastros PROMPT "S" + CHR(233) + "ries de Duplicatas" ;
           MESSAGE "Configura" + CHR(231) + CHR(227) + "o de S" + CHR(233) + "ries de Duplicatas (SigCnFDU)"
    DEFINE BAR 81 OF popCadastros PROMPT "Email" ;
           MESSAGE "Cadastro de Email (SigCdEma)"
    DEFINE BAR 82 OF popCadastros PROMPT "Embalagens" ;
           MESSAGE "Cadastro de Embalagens (SigCdEmb)"

    DEFINE BAR 83 OF popCadastros PROMPT "Estoque Alvo" ;
           MESSAGE "Estoque M" + CHR(237) + "nimo por Produto/Empresa (SigCdMin)"
    DEFINE BAR 84 OF popCadastros PROMPT "Empresas" ;
           MESSAGE "Cadastro de Empresas (SigCdEmp)"
    DEFINE BAR 85 OF popCadastros PROMPT "Endere" + CHR(231) + "os" ;
           MESSAGE "Cadastro de Endere" + CHR(231) + "os (SIGCDENR)"
    DEFINE BAR 86 OF popCadastros PROMPT "Finaliza" + CHR(231) + CHR(227) + "o Antecipada" ;
           MESSAGE "Finaliza" + CHR(231) + CHR(227) + "o Antecipada de Encerramento Direto"
    DEFINE BAR 87 OF popCadastros PROMPT "Esp" + CHR(233) + "cies" ;
           MESSAGE "Cadastro de Esp" + CHR(233) + "cies (SigCdEsp)"
    DEFINE BAR 88 OF popCadastros PROMPT "Eventos" ;
           MESSAGE "Cadastro de Eventos (SIGCDEVE)"
    DEFINE BAR 89 OF popCadastros PROMPT "Eventos (EVT)" ;
           MESSAGE "Cadastro de Eventos (SIGCDEVT)"
    DEFINE BAR 90 OF popCadastros PROMPT "Envio para Recupera" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Cadastro de Envio para Recupera" + CHR(231) + CHR(227) + "o (SIGCDFAP)"
    DEFINE BAR 91 OF popCadastros PROMPT "Fabrica" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o (SIGCDFBI)"
    DEFINE BAR 92 OF popCadastros PROMPT "Ficha T" + CHR(233) + "cnica" ;
           MESSAGE "Cadastro de Ficha T" + CHR(233) + "cnica (SIGCDFCT)"
    DEFINE BAR 93 OF popCadastros PROMPT "Fechamento de Balan" + CHR(231) + "o" ;
           MESSAGE "Fechamento de Balan" + CHR(231) + "o de Estoque (SIGCDFEA)"

    DEFINE BAR 94 OF popCadastros PROMPT "Finalizadoras n" + CHR(227) + "o Fiscal" ;
           MESSAGE "Cadastro de Finalizadoras n" + CHR(227) + "o Fiscal (SIGCDFNF)"

    DEFINE BAR 95 OF popCadastros PROMPT "Tabela de Finaliza" + CHR(231) + CHR(245) + "es" ;
           MESSAGE "Cadastro de Tabela de Finaliza" + CHR(231) + CHR(245) + "es (SIGCDFNL)"
    DEFINE BAR 96 OF popCadastros PROMPT "Grupos de Pagamento" ;
           MESSAGE "Cadastro Financeiro de Pagamentos (SigCdPag)"
    DEFINE BAR 97 OF popCadastros PROMPT "Condi" + CHR(231) + CHR(245) + "es de Pagamento por Opera" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Condi" + CHR(231) + CHR(245) + "es de Pagamento por Opera" + CHR(231) + CHR(227) + "o (SigOpFpo)"
    DEFINE BAR 98 OF popCadastros PROMPT "Modelos de Produtos" ;
           MESSAGE "Cadastro de Modelos de Produtos (SigCdFip)"
    DEFINE BAR 99 OF popCadastros PROMPT "Fretes x Cidades" ;
           MESSAGE "Cadastro de Fretes por Cidade (SigCdFrt)"
    DEFINE BAR 100 OF popCadastros PROMPT "Finalizadoras (Tef)" ;
           MESSAGE "Cadastro de Finalizadoras (Tef) (SIGCDFTF)"
    DEFINE BAR 101 OF popCadastros PROMPT "Feitios" ;
           MESSAGE "Cadastro de Feitios (SIGCDFTI)"
    DEFINE BAR 102 OF popCadastros PROMPT "Fundi" + CHR(231) + CHR(245) + "es" ;
           MESSAGE "Cadastro de Fundi" + CHR(231) + CHR(245) + "es (SIGCDFUN)"
    DEFINE BAR 103 OF popCadastros PROMPT "Grupo Empresarial" ;
           MESSAGE "Cadastro de Grupo Empresarial (SigCdGre)"
    DEFINE BAR 104 OF popCadastros PROMPT "Grupo de Produto" ;
           MESSAGE "Cadastro de Grupo de Produto (SigCdGpd)"
    DEFINE BAR 105 OF popCadastros PROMPT "Grupos Operacionais" ;
           MESSAGE "Cadastro de Grupos Operacionais (SigCdGpe)"
    DEFINE BAR 106 OF popCadastros PROMPT "Grande Grupo" ;
           MESSAGE "Cadastro de Grande Grupo de Produto (SigCdGpr)"
    DEFINE BAR 107 OF popCadastros PROMPT "Carga Hor" + CHR(225) + "ria" ;
           MESSAGE "Cadastro de Carga Hor" + CHR(225) + "ria (SIGCDHOR)"
    DEFINE BAR 108 OF popCadastros PROMPT CHR(205) + "ndices de Comiss" + CHR(227) + "o" ;
           MESSAGE "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o (SigCdCmi)"
    DEFINE BAR 109 OF popCadastros PROMPT "ICMS - Tipo de Tributa" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Cadastro de Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS (SigPrTri)"
    DEFINE BAR 110 OF popCadastros PROMPT "Impressoras" ;
           MESSAGE "Cadastro de Impressoras (SigCdmp)"
    DEFINE BAR 111 OF popCadastros PROMPT "Informa" + CHR(231) + CHR(245) + "es Complementares" ;
           MESSAGE "Cadastro de Informa" + CHR(231) + CHR(245) + "es Complementares (SigPrInf/SigEmInf)"
    DEFINE BAR 112 OF popCadastros PROMPT "Tratamento de Invent" + CHR(225) + "rio" ;
           MESSAGE "Tratamento de Invent" + CHR(225) + "rio (SigCdInt)"
    DEFINE BAR 113 OF popCadastros PROMPT "\-"
    DEFINE BAR 114 OF popCadastros PROMPT "Jornadas de Trabalho" ;
           MESSAGE "Cadastro de Jornadas de Trabalho (SIGCDJRN)"
    DEFINE BAR 115 OF popCadastros PROMPT "Justificativas do Retrabalho" ;
           MESSAGE "Cadastro de Justificativas do Retrabalho (SIGCDJUS)"
    DEFINE BAR 116 OF popCadastros PROMPT "Lote de Cheques" ;
           MESSAGE "Cadastro de Lote de Cheques (SigChLcq)"

    * Vincular acoes dos itens do menu Cadastros
    ON SELECTION BAR 1 OF popCadastros DO AbrirFormCargo
    ON SELECTION BAR 2 OF popCadastros DO AbrirFormCor
    ON SELECTION BAR 3 OF popCadastros DO AbrirFormDepartamento
    ON SELECTION BAR 5 OF popCadastros DO AbrirFormCliente
    ON SELECTION BAR 6 OF popCadastros DO AbrirFormFornecedor
    ON SELECTION BAR 7 OF popCadastros DO AbrirFormProduto
    ON SELECTION BAR 8 OF popCadastros DO AbrirFormTam
    ON SELECTION BAR 9 OF popCadastros DO AbrirFormSrv
    ON SELECTION BAR 11 OF popCadastros DO AbrirFormpgr
    ON SELECTION BAR 13 OF popCadastros DO AbrirFormacu
    ON SELECTION BAR 14 OF popCadastros DO AbrirFormacg
    ON SELECTION BAR 16 OF popCadastros DO AbrirFormcfo
    ON SELECTION BAR 18 OF popCadastros DO AbrirFormccr
    ON SELECTION BAR 20 OF popCadastros DO AbrirFormUfs
    ON SELECTION BAR 21 OF popCadastros DO AbrirFormSigAcCcr
    ON SELECTION BAR 23 OF popCadastros DO AbrirFormSIGPRINT
    ON SELECTION BAR 24 OF popCadastros DO AbrirFormSIGPRLNC
    ON SELECTION BAR 25 OF popCadastros DO AbrirFormACE
    ON SELECTION BAR 26 OF popCadastros DO AbrirFormACJ
    ON SELECTION BAR 27 OF popCadastros DO AbrirFormAli
    ON SELECTION BAR 28 OF popCadastros DO AbrirFormARV
    ON SELECTION BAR 29 OF popCadastros DO AbrirFormBAL
    ON SELECTION BAR 30 OF popCadastros DO AbrirFormBCC
    ON SELECTION BAR 31 OF popCadastros DO AbrirFormBch
    ON SELECTION BAR 32 OF popCadastros DO AbrirFormBlq
    ON SELECTION BAR 34 OF popCadastros DO AbrirFormCAD
    ON SELECTION BAR 36 OF popCadastros DO AbrirFormCAF
    ON SELECTION BAR 37 OF popCadastros DO AbrirFormCat
    ON SELECTION BAR 39 OF popCadastros DO AbrirFormCCJ
    ON SELECTION BAR 40 OF popCadastros DO AbrirFormCco
    ON SELECTION BAR 41 OF popCadastros DO AbrirFormCec
    ON SELECTION BAR 42 OF popCadastros DO AbrirFormCeg
    ON SELECTION BAR 44 OF popCadastros DO AbrirFormCEP
    ON SELECTION BAR 45 OF popCadastros DO AbrirFormCES
    ON SELECTION BAR 46 OF popCadastros DO AbrirFormCfb
    ON SELECTION BAR 47 OF popCadastros DO AbrirFormcfi
    ON SELECTION BAR 49 OF popCadastros DO AbrirFormche
    ON SELECTION BAR 50 OF popCadastros DO AbrirFormCHM
    ON SELECTION BAR 51 OF popCadastros DO AbrirFormCla
    ON SELECTION BAR 52 OF popCadastros DO AbrirFormCLC
    ON SELECTION BAR 53 OF popCadastros DO AbrirFormClf
    ON SELECTION BAR 54 OF popCadastros DO AbrirFormcmp
    ON SELECTION BAR 55 OF popCadastros DO AbrirFormcnl
    ON SELECTION BAR 56 OF popCadastros DO AbrirFormCNQ
    ON SELECTION BAR 57 OF popCadastros DO AbrirFormCOC
    ON SELECTION BAR 58 OF popCadastros DO AbrirFormCol
    ON SELECTION BAR 59 OF popCadastros DO AbrirFormCOM
    ON SELECTION BAR 60 OF popCadastros DO AbrirFormCRC
    ON SELECTION BAR 61 OF popCadastros DO AbrirFormcrf
    ON SELECTION BAR 63 OF popCadastros DO AbrirFormcrp
    ON SELECTION BAR 64 OF popCadastros DO AbrirFormcrpContas
    ON SELECTION BAR 65 OF popCadastros DO AbrirFormcrpMovim
    ON SELECTION BAR 67 OF popCadastros DO AbrirFormCrt
    ON SELECTION BAR 68 OF popCadastros DO AbrirFormCsi
    ON SELECTION BAR 70 OF popCadastros DO AbrirFormCst
    ON SELECTION BAR 71 OF popCadastros DO AbrirFormCTA
    ON SELECTION BAR 72 OF popCadastros DO AbrirFormCtg
    ON SELECTION BAR 73 OF popCadastros DO AbrirFormCVE
    ON SELECTION BAR 74 OF popCadastros DO AbrirFormCVI
    ON SELECTION BAR 75 OF popCadastros DO AbrirFormDES
    ON SELECTION BAR 76 OF popCadastros DO AbrirFormDIC
    ON SELECTION BAR 77 OF popCadastros DO AbrirFormDpi
    ON SELECTION BAR 78 OF popCadastros DO AbrirFormDrs
    ON SELECTION BAR 79 OF popCadastros DO AbrirFormDsp
    ON SELECTION BAR 80 OF popCadastros DO AbrirFormDup
    ON SELECTION BAR 81 OF popCadastros DO AbrirFormema
    ON SELECTION BAR 82 OF popCadastros DO AbrirFormEmb
    ON SELECTION BAR 83 OF popCadastros DO AbrirFormEmn
    ON SELECTION BAR 84 OF popCadastros DO AbrirFormemp
    ON SELECTION BAR 85 OF popCadastros DO AbrirFormENR
    ON SELECTION BAR 86 OF popCadastros DO AbrirFormepd
    ON SELECTION BAR 87 OF popCadastros DO AbrirFormEsp
    ON SELECTION BAR 88 OF popCadastros DO AbrirFormEVE
    ON SELECTION BAR 89 OF popCadastros DO AbrirFormEvt
    ON SELECTION BAR 90 OF popCadastros DO AbrirFormFap
    ON SELECTION BAR 91 OF popCadastros DO AbrirFormFBI
    ON SELECTION BAR 92 OF popCadastros DO AbrirFormFct
    ON SELECTION BAR 93 OF popCadastros DO AbrirFormFea
    ON SELECTION BAR 94 OF popCadastros DO AbrirFormFNF
    ON SELECTION BAR 95 OF popCadastros DO AbrirFormfnl
    ON SELECTION BAR 96 OF popCadastros DO AbrirFormFpg
    ON SELECTION BAR 97 OF popCadastros DO AbrirFormFpo
    ON SELECTION BAR 98 OF popCadastros DO AbrirFormFpr
    ON SELECTION BAR 99 OF popCadastros DO AbrirFormFre
    ON SELECTION BAR 100 OF popCadastros DO AbrirFormFTF
    ON SELECTION BAR 101 OF popCadastros DO AbrirFormFti
    ON SELECTION BAR 102 OF popCadastros DO AbrirFormFUN
    ON SELECTION BAR 103 OF popCadastros DO AbrirFormgem
    ON SELECTION BAR 104 OF popCadastros DO AbrirFormgpd
    ON SELECTION BAR 105 OF popCadastros DO AbrirFormGpe
    ON SELECTION BAR 106 OF popCadastros DO AbrirFormgpr
    ON SELECTION BAR 107 OF popCadastros DO AbrirFormHOR
    ON SELECTION BAR 108 OF popCadastros DO AbrirFormICM
    ON SELECTION BAR 109 OF popCadastros DO AbrirFormIct
    ON SELECTION BAR 110 OF popCadastros DO AbrirFormImp
    ON SELECTION BAR 111 OF popCadastros DO AbrirFormInf
    ON SELECTION BAR 112 OF popCadastros DO AbrirFormint
    ON SELECTION BAR 114 OF popCadastros DO AbrirFormJrn
    ON SELECTION BAR 115 OF popCadastros DO AbrirFormJUS
    ON SELECTION BAR 116 OF popCadastros DO AbrirFormlch

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
    DEFINE BAR 41 OF popMovimentos PROMPT "Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Posi" + CHR(231) + CHR(227) + "o por Movimenta" + CHR(231) + CHR(227) + "o - Consulta de SigMvCab"

    ON SELECTION BAR 41 OF popMovimentos DO AbrirFormSigPrEs1

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

    DEFINE BAR 52 OF popMovimentos PROMPT "\-"
    DEFINE BAR 53 OF popMovimentos PROMPT "Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es" ;
           MESSAGE "Edi" + CHR(231) + CHR(227) + "o de Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es"

    ON SELECTION BAR 53 OF popMovimentos DO AbrirFormSigPrCtc

    DEFINE BAR 54 OF popMovimentos PROMPT "\-"
    DEFINE BAR 55 OF popMovimentos PROMPT "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email" ;
           MESSAGE "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email de Movimenta" + CHR(231) + CHR(245) + "es"

    ON SELECTION BAR 55 OF popMovimentos DO AbrirFormsigprema

    DEFINE BAR 56 OF popMovimentos PROMPT "\-"
    DEFINE BAR 57 OF popMovimentos PROMPT "Impress" + CHR(227) + "o de Etiquetas de Envelopes" ;
           MESSAGE "Impress" + CHR(227) + "o de Etiquetas de Envelopes"

    ON SELECTION BAR 57 OF popMovimentos DO AbrirFormsigprenv

    DEFINE BAR 58 OF popMovimentos PROMPT "\-"
    DEFINE BAR 59 OF popMovimentos PROMPT "Transfer" + CHR(234) + "ncia e Recebimento FTP" ;
           MESSAGE "Transferir e receber arquivos via FTP"

    ON SELECTION BAR 59 OF popMovimentos DO AbrirFormsigprftp

    DEFINE BAR 60 OF popMovimentos PROMPT "\-"
    DEFINE BAR 61 OF popMovimentos PROMPT "Falha x Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s" ;
           MESSAGE "Falha x Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s - An" + CHR(225) + "lise de SigCdFea"

    ON SELECTION BAR 61 OF popMovimentos DO AbrirFormSigPrGf1

    DEFINE BAR 62 OF popMovimentos PROMPT "\-"
    DEFINE BAR 63 OF popMovimentos PROMPT "Gera" + CHR(231) + CHR(227) + "o de Pedido de Estoque M" + CHR(237) + "nimo" ;
           MESSAGE "Gera pedidos de compra/produ" + CHR(231) + CHR(227) + "o para recompor estoques abaixo do m" + CHR(237) + "nimo"
    ON SELECTION BAR 63 OF popMovimentos DO AbrirFormSigPrGmi

    DEFINE BAR 64 OF popMovimentos PROMPT "\-"
    DEFINE BAR 65 OF popMovimentos PROMPT "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio" ;
           MESSAGE "Imprime boleto banc" + CHR(225) + "rio para a parcela selecionada da movimenta" + CHR(231) + CHR(227) + "o"
    ON SELECTION BAR 65 OF popMovimentos DO AbrirFormSigPrIbb

    DEFINE BAR 66 OF popMovimentos PROMPT "\-"
    DEFINE BAR 67 OF popMovimentos PROMPT "Mapa Visual do Sistema" ;
           MESSAGE "Mapa visual com diagrama dos " + CHR(237) + "cones do sistema"

    ON SELECTION BAR 67 OF popMovimentos DO AbrirFormsigprico

    DEFINE BAR 68 OF popMovimentos PROMPT "\-"
    DEFINE BAR 69 OF popMovimentos PROMPT "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil" ;
           MESSAGE "Processamento de integra" + CHR(231) + CHR(227) + "o cont" + CHR(225) + "bil - gera" + CHR(231) + CHR(227) + "o de arquivos CTPV"

    ON SELECTION BAR 69 OF popMovimentos DO AbrirFormSigPrIct

    DEFINE BAR 70 OF popMovimentos PROMPT "\-"
    DEFINE BAR 71 OF popMovimentos PROMPT "Importa" + CHR(231) + CHR(227) + "o de Planilha" ;
           MESSAGE "Importa" + CHR(231) + CHR(227) + "o de planilha XLS para lista de pre" + CHR(231) + "o, transfer" + CHR(234) + "ncia e pedidos"

    ON SELECTION BAR 71 OF popMovimentos DO AbrirFormsigprila

    DEFINE BAR 72 OF popMovimentos PROMPT "\-"
    DEFINE BAR 73 OF popMovimentos PROMPT "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos" ;
           MESSAGE "Importa" + CHR(231) + CHR(227) + "o e exporta" + CHR(231) + CHR(227) + "o de imagens JPG para produtos"

    ON SELECTION BAR 73 OF popMovimentos DO AbrirFormsigprima

    DEFINE BAR 74 OF popMovimentos PROMPT "\-"

    DEFINE BAR 75 OF popMovimentos PROMPT "Importa" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o de Estoque" ;
           MESSAGE "Importa" + CHR(231) + CHR(227) + "o de arquivos TXT de movimenta" + CHR(231) + CHR(227) + "o de estoque"

    ON SELECTION BAR 75 OF popMovimentos DO AbrirFormSIGPRIMP

    DEFINE BAR 76 OF popMovimentos PROMPT "\-"

    DEFINE BAR 77 OF popMovimentos PROMPT "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil Total" ;
           MESSAGE "Integra" + CHR(231) + CHR(227) + "o total dos movimentos cont" + CHR(225) + "beis por per" + CHR(237) + "odo e empresa"

    ON SELECTION BAR 77 OF popMovimentos DO AbrirFormSigPrItb

    DEFINE BAR 78 OF popMovimentos PROMPT "\-"

    DEFINE BAR 79 OF popMovimentos PROMPT "Muda Conta" ;
           MESSAGE "Altera c" + CHR(243) + "digos de conta em m" + CHR(250) + "ltiplas tabelas conforme cat" + CHR(225) + "logo ArqDBF"

    ON SELECTION BAR 79 OF popMovimentos DO AbrirFormSigPrMdc

    DEFINE BAR 80 OF popMovimentos PROMPT "\-"

    DEFINE BAR 81 OF popMovimentos PROMPT "Substitui" + CHR(231) + CHR(227) + "o de Refer" + CHR(234) + "ncias de Produtos" ;
           MESSAGE "Substitui" + CHR(231) + CHR(227) + "o de refer" + CHR(234) + "ncias de c" + CHR(243) + "digos de produtos em m" + CHR(250) + "ltiplas tabelas"

    ON SELECTION BAR 81 OF popMovimentos DO AbrirFormsigprmdp

    DEFINE BAR 82 OF popMovimentos PROMPT "\-"

    DEFINE BAR 83 OF popMovimentos PROMPT "Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce" ;
           MESSAGE "Integra" + CHR(231) + CHR(227) + "o com loja virtual SIS: importa pedidos XML e exporta estoque"

    ON SELECTION BAR 83 OF popMovimentos DO AbrirFormSIGPRMEI

    DEFINE BAR 84 OF popMovimentos PROMPT "\-"

    DEFINE BAR 85 OF popMovimentos PROMPT "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta" ;
           MESSAGE "Unifica" + CHR(231) + CHR(227) + "o de Malas Diretas - elimina duplicatas e combina destinat" + CHR(225) + "rios"

    ON SELECTION BAR 85 OF popMovimentos DO AbrirFormSigPrMlu

    DEFINE BAR 86 OF popMovimentos PROMPT "\-"
    DEFINE BAR 87 OF popMovimentos PROMPT "Processamento de NF-e" ;
           MESSAGE "Processamento e Envio de Notas Fiscais Eletr" + CHR(244) + "nicas (NF-e) para a SEFAZ"

    ON SELECTION BAR 87 OF popMovimentos DO AbrirFormsigprnfe

    DEFINE BAR 88 OF popMovimentos PROMPT "\-"
    DEFINE BAR 89 OF popMovimentos PROMPT "Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal" ;
           MESSAGE "Integra" + CHR(231) + CHR(227) + "o e Gera" + CHR(231) + CHR(227) + "o de Arquivo de NFS-e Municipal"

    ON SELECTION BAR 89 OF popMovimentos DO AbrirFormSIGPRNSE

    DEFINE BAR 90 OF popMovimentos PROMPT "\-"
    DEFINE BAR 91 OF popMovimentos PROMPT "Sele" + CHR(231) + CHR(227) + "o de Transa" + CHR(231) + CHR(227) + "o TEF" ;
           MESSAGE "Sele" + CHR(231) + CHR(227) + "o e Gerenciamento de Transa" + CHR(231) + CHR(245) + "es TEF"

    ON SELECTION BAR 91 OF popMovimentos DO AbrirFormsigproef

    DEFINE BAR 92 OF popMovimentos PROMPT "\-"
    DEFINE BAR 93 OF popMovimentos PROMPT "Prioriza" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es para PCP" ;
           MESSAGE "Prioriza" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es para Planejamento de Produ" + CHR(231) + CHR(227) + "o"

    ON SELECTION BAR 93 OF popMovimentos DO AbrirFormSigPrPcp

    DEFINE BAR 94 OF popMovimentos PROMPT "\-"
    DEFINE BAR 95 OF popMovimentos PROMPT "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os" ;
           MESSAGE "Cadastro e consulta de altera" + CHR(231) + CHR(245) + "es de pre" + CHR(231) + "os de produtos"
    ON SELECTION BAR 95 OF popMovimentos DO AbrirFormsigprpre

    DEFINE BAR 96 OF popMovimentos PROMPT "\-"
    DEFINE BAR 97 OF popMovimentos PROMPT "Rec" + CHR(225) + "lculo de Custos de Produto" ;
           MESSAGE "Processa fila de rec" + CHR(225) + "lculo de custos de produto (SigOpClC)"
    ON SELECTION BAR 97 OF popMovimentos DO AbrirFormsigprrcu

    DEFINE BAR 98 OF popMovimentos PROMPT "\-"
    DEFINE BAR 99 OF popMovimentos PROMPT "Retorno de Estoque/Etiquetas" ;
           MESSAGE "Retorno de Estoque / Etiquetas (SIGPRRET)"
    ON SELECTION BAR 99 OF popMovimentos DO AbrirFormSigPrRet

    DEFINE BAR 100 OF popMovimentos PROMPT "\-"
    DEFINE BAR 101 OF popMovimentos PROMPT "Rec" + CHR(225) + "lculo de Saldos CC (Fila)" ;
           MESSAGE "Reprocessa saldos da fila de opera" + CHR(231) + CHR(245) + "es pendentes (SigOpCls)"
    ON SELECTION BAR 101 OF popMovimentos DO AbrirFormSigPrRss

    DEFINE BAR 102 OF popMovimentos PROMPT "\-"
    DEFINE BAR 103 OF popMovimentos PROMPT "Rela" + CHR(231) + CHR(227) + "o de Produtos" ;
           MESSAGE "Di" + CHR(225) + "logo de sele" + CHR(231) + CHR(227) + "o de produtos para transmiss" + CHR(227) + "o ECF (SIGPRTRF)"
    ON SELECTION BAR 103 OF popMovimentos DO AbrirFormSIGPRTRF

    DEFINE BAR 104 OF popMovimentos PROMPT "\-"
    DEFINE BAR 105 OF popMovimentos PROMPT "Importa" + CHR(231) + CHR(227) + "o de SKUs (VTX)" ;
           MESSAGE "Importa" + CHR(231) + CHR(227) + "o de planilha Excel para atualiza" + CHR(231) + CHR(227) + "o de SKUs VTEX (SIGPRVTX)"
    ON SELECTION BAR 105 OF popMovimentos DO AbrirFormSIGPRVTX

    DEFINE BAR 106 OF popMovimentos PROMPT "\-"
    DEFINE BAR 107 OF popMovimentos PROMPT "Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais" ;
           MESSAGE "Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais - Ajuste de campos de NF lan" + CHR(231) + "adas"
    ON SELECTION BAR 107 OF popMovimentos DO AbrirFormCNF

    DEFINE BAR 108 OF popMovimentos PROMPT "\-"
    DEFINE BAR 109 OF popMovimentos PROMPT "Desmontagem de Produtos" ;
           MESSAGE "Desmontagem de Produtos - Desmontar produto em componentes"

    ON SELECTION BAR 109 OF popMovimentos DO AbrirFormDmo

    DEFINE BAR 110 OF popMovimentos PROMPT "\-"
    DEFINE BAR 111 OF popMovimentos PROMPT "Gera" + CHR(231) + CHR(227) + "o de Grupos" ;
           MESSAGE "Gera" + CHR(231) + CHR(227) + "o de Grupos de Acesso (SigCdGrA)"

    ON SELECTION BAR 111 OF popMovimentos DO AbrirFormGr1

    DEFINE BAR 112 OF popMovimentos PROMPT "\-"
    DEFINE BAR 113 OF popMovimentos PROMPT "Duplica" + CHR(231) + CHR(227) + "o dos Tipo de Tributa" + CHR(231) + CHR(227) + "o" ;
           MESSAGE "Duplica" + CHR(231) + CHR(227) + "o dos Tipo de Tributa" + CHR(231) + CHR(227) + "o (SigPrTri)"

    ON SELECTION BAR 113 OF popMovimentos DO AbrirFormICD

    DEFINE BAR 114 OF popMovimentos PROMPT "\-"
    DEFINE BAR 115 OF popMovimentos PROMPT CHR(205) + "cones de Acesso" ;
           MESSAGE "Configura" + CHR(231) + CHR(227) + "o de " + CHR(237) + "cones dos programas de acesso"

    ON SELECTION BAR 115 OF popMovimentos DO AbrirFormICN

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
    DEFINE BAR 9 OF popFerramentas PROMPT "\-"
    DEFINE BAR 10 OF popFerramentas PROMPT "Gerar Senha do Dia" ;
           MESSAGE "Gera e envia a senha do dia por e-mail"
    DEFINE BAR 11 OF popFerramentas PROMPT "\-"
    DEFINE BAR 12 OF popFerramentas PROMPT "Cadastro de " + CHR(205) + "cones" ;
           MESSAGE "Cadastro de " + CHR(205) + "cones do sistema (SigSyIco)"
    ON SELECTION BAR 3  OF popFerramentas DO AbrirFormSIGBLCTA
    ON SELECTION BAR 4  OF popFerramentas DO AbrirFormSIGPGCNB
    ON SELECTION BAR 6  OF popFerramentas DO TestarConexaoBD
    ON SELECTION BAR 8  OF popFerramentas DO AbrirFormSIGPREST
    ON SELECTION BAR 10 OF popFerramentas DO AbrirFormsigprsen
    ON SELECTION BAR 12 OF popFerramentas DO AbrirFormICO

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
* AbrirFormGpe - Abre formulario de cadastro de Grupos Operacionais
*------------------------------------------------------------------------------
PROCEDURE AbrirFormGpe()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormGpe")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Grupos Operacionais" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Grupos Operacionais:" + ;
                     CHR(13) + CHR(13) + ;
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
* AbrirFormacu - Abre formulario de cadastro de usuarios
*------------------------------------------------------------------------------
PROCEDURE AbrirFormacu()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formacu")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Usu" + CHR(225) + "rios" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Usu" + CHR(225) + "rios:" + CHR(13) + CHR(13) + ;
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
* AbrirFormACE - Abre formulario de Acesso de Empresas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormACE()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormACE")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Acesso de Empresas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Acesso de Empresas:" + CHR(13) + CHR(13) + ;
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
        *-- par_pTipo=.T. habilita selecao de Tipo de OP (cnt_4c_TipoOp ativo)
        loForm = CREATEOBJECT("FormSigPrGloT", .F., .F., .F., .T.)

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
* AbrirFormSigPrCtc - Abre formulario de Cotacoes por Operacoes (standalone)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrCtc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrCtc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigprema - Abre formulario de Processamento e Geracao de Email
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprema()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprema", "", .F.)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Processamento e Gera" + CHR(231) + CHR(227) + "o de Email" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Processamento e Gera" + CHR(231) + CHR(227) + "o de Email:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprenv - Abre formulario de Impressao de Etiquetas de Envelopes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprenv()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprenv")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + "o de Etiquetas de Envelopes" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Etiquetas de Envelopes:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrEs1 - Abre formulario Posicao Por Movimentacao (SigPrEs1)
*   Form OPERACIONAL: apresenta filtros, executa consulta em SigMvCab e
*   abre SigPrEs2 com os resultados
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrEs1()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrEs1")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Posi" + CHR(231) + CHR(227) + ;
                "o Por Movimenta" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Posi" + CHR(231) + CHR(227) + "o Por Movimenta" + ;
                     CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprftp - Abre formulario de Transferencia e Recebimento FTP
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprftp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprftp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Transfer" + CHR(234) + ;
                        "ncia e Recebimento FTP" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Transfer" + CHR(234) + "ncia e Recebimento FTP:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrGf1 - Abre formulario de Falha x Recuperacao por Mes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrGf1()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrGf1")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Falha x Recupera" + ;
                        CHR(231) + CHR(227) + "o por M" + CHR(234) + "s" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Falha x Recupera" + CHR(231) + CHR(227) + "o por M" + CHR(234) + "s:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrGmi - Abre formulario de Geracao de Pedido de Estoque Minimo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrGmi()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrGmi")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Gera" + CHR(231) + CHR(227) + "o de Pedido de Estoque M" + CHR(237) + "nimo" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Gera" + CHR(231) + CHR(227) + "o de Pedido de Estoque M" + CHR(237) + "nimo:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrIbb - Abre formulario de Impressao de Boleto Bancario
* Nota: Para uso via menu, abre sem EmpDopNum (form mostra sem dados).
* O uso normal eh via chamada direta de outro form passando EmpDopNum.
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrIbb()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRIBL")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Impress" + CHR(227) + ;
                        "o de Boleto Banc" + CHR(225) + "rio" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprico - Abre formulario de Mapa Visual do Sistema
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprico()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprico")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Mapa Visual do Sistema" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Mapa Visual do Sistema:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrIct - Abre formulario de Integracao Contabil
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrIct()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrIct")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprila - Abre formulario de Importacao de Planilha
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprila()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprila")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Importa" + CHR(231) + CHR(227) + "o de Planilha" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Importa" + CHR(231) + CHR(227) + "o de Planilha:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprima - Abre formulario de Importacao de Imagens de Produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprima()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprima")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRIMP - Abre formulario de Importacao de Movimentacao de Estoque
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRIMP()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRIMP")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Importa" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o de Estoque" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Importa" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o de Estoque:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRINT - Abre formulario de Cadastro de Instrucoes de Impressao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRINT()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRINT")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Instru" + CHR(231) + CHR(245) + "es de Impress" + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Instru" + CHR(231) + CHR(245) + "es de Impress" + CHR(227) + "o:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrItb - Abre formulario de Integracao Contabil Total
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrItb()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrItb")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil Total" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil Total:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRLNC - Abre formulario de Cadastro de Lancamentos de C/C
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRLNC()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRLNC")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Lan" + CHR(231) + "amentos de C/C" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Lan" + CHR(231) + "amentos de C/C:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrMdc - Abre formulario de Muda Conta
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrMdc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrMdc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Muda Conta" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Muda Conta:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprmdp - Abre formulario de Substituicao de Referencias de Produtos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprmdp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprmdp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Substitui" + CHR(231) + CHR(227) + "o de Refer" + CHR(234) + "ncias de Produtos" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Substitui" + CHR(231) + CHR(227) + "o de Refer" + CHR(234) + "ncias de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRMEI - Abre formulario de Integracao SIS E-Commerce
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRMEI()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRMEI")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrMlu - Abre formulario de Unificacao de Mala Direta
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrMlu()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrMlu")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Unifica" + CHR(231) + CHR(227) + "o de Mala Direta" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Unifica" + CHR(231) + CHR(227) + "o de Mala Direta:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRNSE - Abre formulario de Integracao de NF-e Municipal
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRNSE()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRNSE")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Integra" + CHR(231) + CHR(227) + "o de NF-e Municipal:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigprnfe - Abre formulario de Processamento de NF-e
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprnfe()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprnfe")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Processamento de NF-e" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Processamento de NF-e:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormsigproef - Abre formulario de Selecao de Transacao TEF
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigproef()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigproef")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Sele" + CHR(231) + CHR(227) + "o de Transa" + CHR(231) + CHR(227) + "o TEF" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Sele" + CHR(231) + CHR(227) + "o de Transa" + CHR(231) + CHR(227) + "o TEF:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSigPrPcp - Abre formulario de Priorizacao de Operacoes para PCP
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrPcp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrPcp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Prioriza" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es para PCP" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Prioriza" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(245) + "es para PCP:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigPrPpc - Abre formulario de Produtos Por Conta
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrPpc()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrPpc")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Produtos Por Conta" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Produtos Por Conta:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigprpre - Abre formulario de Alteracao de Precos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprpre()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprpre")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigprrcu - Abre formulario de Recalculo de Custos de Produto
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprrcu()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprrcu")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Rec" + CHR(225) + "lculo de Custos de Produto" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Rec" + CHR(225) + "lculo de Custos de Produto:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

PROCEDURE AbrirFormSigPrRet()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrRet")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Retorno de Estoque/Etiquetas" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Retorno de Estoque/Etiquetas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormSigPrRss - Abre formulario de Recalculo de Saldos CC (Fila SigOpCls)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSigPrRss()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSigPrRss")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Rec" + CHR(225) + "lculo de Saldos CC" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Rec" + CHR(225) + "lculo de Saldos CC:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormsigprsen - Abre utilitario de Gerar e Enviar Senha do Dia
*------------------------------------------------------------------------------
PROCEDURE AbrirFormsigprsen()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formsigprsen")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Gerar Senha do Dia" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Gerar Senha do Dia:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRTRF - Abre dialogo de selecao de produtos para ECF
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRTRF()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRTRF")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Rela" + CHR(231) + CHR(227) + "o de Produtos" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Rela" + CHR(231) + CHR(227) + "o de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormSIGPRVTX - Abre formulario de Importacao de SKUs via planilha Excel
*------------------------------------------------------------------------------
PROCEDURE AbrirFormSIGPRVTX()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormSIGPRVTX")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Importa" + CHR(231) + ;
                        CHR(227) + "o de SKUs (VTX)" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Importa" + CHR(231) + ;
                     CHR(227) + "o de SKUs (VTX):" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormACJ - Abre formulario de Cadastro de Acessos de JOB
*------------------------------------------------------------------------------
PROCEDURE AbrirFormACJ()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormACJ")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Acessos de JOB" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Acessos de JOB:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormAli - Abre formulario de Cadastro de Alineas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormAli()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormAli")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Al" + CHR(237) + "neas" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Al" + CHR(237) + "neas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormARV - Abre formulario de Cadastro de Tipos de Arvore
*------------------------------------------------------------------------------
PROCEDURE AbrirFormARV()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormARV")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Tipos de " + CHR(193) + "rvore" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Tipos de " + CHR(193) + "rvore:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormBAL - Abre formulario de Inventario/Balanco de Estoque
*------------------------------------------------------------------------------
PROCEDURE AbrirFormBAL()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormBAL")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Invent" + CHR(225) + "rio/Balan" + CHR(231) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Invent" + CHR(225) + "rio/Balan" + CHR(231) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormBCC - Abre formulario de Bandeiras de Cartao de Credito
*------------------------------------------------------------------------------
PROCEDURE AbrirFormBCC()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormBCC")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormBCC" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Bandeiras de Cart" + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormBch - Abre formulario de Balanco de Cheques
*------------------------------------------------------------------------------
PROCEDURE AbrirFormBch()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormBch")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormBch" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Balan" + CHR(231) + "o de Cheques:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormBlq - Abre formulario de Cadastro de Bloqueios por Periodo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormBlq()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormBlq")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormBlq" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Bloqueios por Per" + CHR(237) + "odo:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormCAD - Abre formulario de Cadastros Gerais (SIGCDCAD)
* Formulario parametrizado: passar par_cTipoCads para filtrar por tipo.
* Sem parametros, abre em modo generico (Buscar mostrara aviso).
* Uso programatico: AbrirFormCAD("CARGO", 10) ou AbrirFormCAD("APONTAMTO")
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCAD(par_cTipoCads, par_nMaxCodCads)
    LOCAL loForm, loException
    LOCAL loc_cTipo, loc_nMaxCod
    loc_cTipo   = IIF(VARTYPE(par_cTipoCads)   = "C", par_cTipoCads,   "")
    loc_nMaxCod = IIF(VARTYPE(par_nMaxCodCads) = "N", par_nMaxCodCads, 20)

    TRY
        loForm = CREATEOBJECT("FormCAD", loc_cTipo, loc_nMaxCod)

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cadastros Gerais" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Cadastros Gerais:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormCAF - Abre formulario de Cancelamento de OP da Fundicao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCAF()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCAF")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cancelamento de OP" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Cancelamento de OP da Fundi" + CHR(231) + CHR(227) + "o:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormCtg - Abre formulario de cadastro de Categorias (SigCdCtg)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCtg()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCtg")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Categorias" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Categorias:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormCat - Abre formulario de cadastro de Categorias de Produto
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCat()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCat")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Categorias de Produto" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Categorias de Produto:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormCCJ - Abre formulario de Calculo de Juros
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCCJ()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCCJ")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de C" + CHR(225) + ;
                        "lculo de Juros" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de C" + CHR(225) + ;
                     "lculo de Juros:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormCco - Abre formulario de cadastro de Classificacao de Contas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCco()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCco")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Classifica" + ;
                CHR(231) + CHR(227) + "o de Contas" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Classifica" + ;
                     CHR(231) + CHR(227) + "o de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC


*------------------------------------------------------------------------------
* AbrirFormCec - Abre formulario de cadastro de Acesso a Consulta Generica
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCec()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCec")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Acesso a Consulta Gen" + CHR(233) + "rica" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Acesso a Consulta Gen" + CHR(233) + "rica:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCeg - Abre formulario de Cadastro de Prioridade de Estoque/Globalizacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCeg()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCeg")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Prioridade de Estoque" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Prioridade de Estoque:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCEP - Abre formulario de cadastro de CEP
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCEP()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCEP")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de CEP" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de CEP:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCES - Abre formulario de cadastro de Classificacao de Estoque
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCES()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCES")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Classifica" + CHR(231) + CHR(227) + "o de Estoque" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Classifica" + CHR(231) + CHR(227) + "o de Estoque:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCfb - Abre formulario de Configuracao de Boletos Bancarios
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCfb()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCfb")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Configura" + CHR(231) + CHR(227) + "o de Boletos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Configura" + CHR(231) + CHR(227) + "o de Boletos:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormcfi - Abre formulario de ICMS Cupom Fiscal
*------------------------------------------------------------------------------
PROCEDURE AbrirFormcfi()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formcfi")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de ICMS - Cupom Fiscal" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de ICMS - Cupom Fiscal:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormche - Abre formulario de Carteira de Cheques
*------------------------------------------------------------------------------
PROCEDURE AbrirFormche()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formche")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Carteira de Cheques" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Carteira de Cheques:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCHM - Abre formulario de Configuracao do Cheque Matricial
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCHM()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCHM")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Configura" + ;
                        CHR(231) + CHR(227) + "o do Cheque Matricial" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Configura" + CHR(231) + CHR(227) + ;
                     "o do Cheque Matricial:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCla - Abre formulario de Cadastro de Classificacao de Produto
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCla()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCla")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Classifica" + ;
                        CHR(231) + CHR(227) + "o de Produto" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Classifica" + CHR(231) + CHR(227) + ;
                     "o de Produto:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

PROCEDURE AbrirFormCLC()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCLC")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Comparativos Entre Locais" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Comparativos Entre Locais:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormClf - Abre formulario de cadastro de Classificacao Fiscal
*------------------------------------------------------------------------------
PROCEDURE AbrirFormClf()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormClf")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Classifica" + ;
                        CHR(231) + CHR(227) + "o Fiscal" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Classifica" + CHR(231) + CHR(227) + ;
                     "o Fiscal:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormcmp - Abre formulario de Cadastro de Compra Para
*------------------------------------------------------------------------------
PROCEDURE AbrirFormcmp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formcmp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Compra Para" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Compra Para:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

PROCEDURE AbrirFormCliente()
    LOCAL loForm, loException, lcRetorno

    TRY
        *-- Abrir para novo cadastro de cliente (INSERIR mode)
        *-- pCpf="", pGrupo="" (auto-detectado de crSigCdPam), pCep=0,
        *-- pVal=.F., pCli="" (novo), pcTpBloqCar="0", pcMudaCpfCgc="0"
        loForm = CREATEOBJECT("FormCliente", "", "", 0, .F., "", "0", "0")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cadastro de Cliente" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Cadastro de Cliente:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

PROCEDURE AbrirFormcnl()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formcnl")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Contagem por Localiza" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Contagem por Localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

PROCEDURE AbrirFormCNF()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCNF")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Corre" + CHR(231) + CHR(227) + "o de Notas Fiscais:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCNQ - Abre formulario de cadastro de Conquilhas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCNQ()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCNQ")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Conquilhas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Conquilhas:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCOC - Abre formulario de cadastro de Ocorrencias de Titulos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCOC()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCOC")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCol - Abre formulario de cadastro de Grupos de Venda
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCol()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCol")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Grupos de Venda" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Grupos de Venda:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCOM - Abre o formulario de Cadastro de Comissoes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCOM()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("FormCOM")
        IF VARTYPE(loForm) = "O"
            loForm.Show(1)
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Comiss" + CHR(245) + "es:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCRC - Abre formulario de cadastro de Caracteristicas de Contas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCRC()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("FormCRC")
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Contas" + ;
                CHR(13) + "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormcrf - Abre formulario de Contagem de Referencia
*------------------------------------------------------------------------------
PROCEDURE AbrirFormcrf()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("Formcrf")
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Contagem de Refer" + CHR(234) + "ncia" + ;
                CHR(13) + "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Contagem de Refer" + CHR(234) + "ncia:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormcrp - Abre formulario de Caracteristicas de Produtos (nTipo=0)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormcrp()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("Formcrp", 0)
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Produtos" + ;
                CHR(13) + "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormcrpContas - Abre formulario de Caracteristicas de Contas (nTipo=1, SigCrRaP)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormcrpContas()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("Formcrp", 1)
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Contas (CRP)" + ;
                CHR(13) + "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Contas (CRP):" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormcrpMovim - Abre formulario de Caracteristicas de Movimentacoes (nTipo=2)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormcrpMovim()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("Formcrp", 2)
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Movimenta" + CHR(231) + CHR(245) + "es" + ;
                CHR(13) + "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Caracter" + CHR(237) + "sticas de Movimenta" + CHR(231) + CHR(245) + "es:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCrt - Abre formulario de cadastro de Retrabalhos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCrt()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCrt")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Retrabalhos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Retrabalhos:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCsi - Abre formulario de cadastro de Categoria do Site
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCsi()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCsi")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Categoria do Site" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Categoria do Site:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCst - Abre formulario de cadastro de Constantes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCst()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCst")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Constantes" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Constantes:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

PROCEDURE AbrirFormCTA()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormCTA")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Cadastro de Contas" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Cadastro de Contas:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCVE - Abre o formulario de Cadastro de Comissoes de Vendedores por Cargos
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCVE()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("FormCVE")
        IF VARTYPE(loForm) = "O"
            loForm.Show(1)
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Comiss" + CHR(245) + "es por Cargo:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormCVI - Abre o formulario de Cadastro de Comissoes de Vendedores Individuais
*------------------------------------------------------------------------------
PROCEDURE AbrirFormCVI()
    LOCAL loForm, loException, lcMensagem
    loForm      = .NULL.
    loException = .NULL.
    lcMensagem  = ""
    TRY
        loForm = CREATEOBJECT("FormCVI")
        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormCVI" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF
    CATCH TO loException
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Comiss" + CHR(245) + "es Individuais:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message  + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDES - Abre formulario de cadastro de Cotas de Desconto por Periodo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDES()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormDES")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormDES" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Cotas de Desconto:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDIC - Abre formulario de cadastro de Dicionario de Idiomas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDIC()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormDIC")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormDIC" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Dicion" + CHR(225) + "rio de Idiomas:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDmo - Abre formulario de Desmontagem de Produtos (SIGCDDMO)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDmo()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormDmo")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Desmontagem de Produtos" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Desmontagem de Produtos:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDpi - Abre formulario de Cadastro de Departamentos do Site
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDpi()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormDpi")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Departamentos do Site" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Departamentos do Site:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDrs - Abre formulario de Fichas Tecnicas (SigCdDrs)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDrs()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormDrs")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Fichas T" + CHR(233) + "cnicas" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Fichas T" + CHR(233) + "cnicas:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDsp - Abre formulario de cadastro de Disponibilidades
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDsp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormDsp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Disponibilidades" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Disponibilidades:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormDup - Abre formulario de cadastro de Series de Duplicatas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormDup()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormDup")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de S" + CHR(233) + "ries de Duplicatas" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de S" + CHR(233) + "ries de Duplicatas:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormema - Abre formulario de cadastro de Email
*------------------------------------------------------------------------------
PROCEDURE AbrirFormema()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formema")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Email" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Email:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormEmb - Abre formulario de cadastro de Embalagens
*------------------------------------------------------------------------------
PROCEDURE AbrirFormEmb()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormEmb")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Embalagens" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Embalagens:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormEmn - Abre formulario de Estoque Alvo (Minimo por Produto/Empresa)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormEmn()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormEmn")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Estoque Alvo" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Estoque Alvo:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormemp - Abre formulario de Cadastro de Empresas
*------------------------------------------------------------------------------
PROCEDURE AbrirFormemp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formemp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Empresas" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Empresas:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message                   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)         + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormENR - Abre formulario de cadastro de Enderecos (SIGCDENR)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormENR()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormENR")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario FormENR", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario FormENR:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormepd - Abre formulario de Finalizacao Antecipada
*------------------------------------------------------------------------------
PROCEDURE AbrirFormepd()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formepd")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario Formepd", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario Formepd:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormEsp - Abre formulario de cadastro de Especies
*------------------------------------------------------------------------------
PROCEDURE AbrirFormEsp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormEsp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario FormEsp", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario FormEsp:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormEVE - Abre formulario de cadastro de Eventos (SIGCDEVE)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormEVE()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormEVE")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario FormEVE", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario FormEVE:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormEvt - Abre formulario de cadastro de Eventos (SIGCDEVT)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormEvt()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormEvt")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario FormEvt", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario FormEvt:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFap - Abre formulario de cadastro de Envio para Recuperacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFap()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFap")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFap" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Envio para Recupera" + ;
                     CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFBI - Abre formulario de cadastro de Fabricacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFBI()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFBI")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFBI" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Fabrica" + ;
                     CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFct - Abre formulario de cadastro de Ficha Tecnica
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFct()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFct")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFct" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Ficha T" + ;
                     CHR(233) + "cnica:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
PROCEDURE AbrirFormFea()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFea")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFea" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Fechamento de Balan" + ;
                     CHR(231) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFNF - Abre formulario de cadastro de Finalizadoras nao Fiscal
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFNF()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFNF")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Finalizadoras n" + CHR(227) + "o Fiscal" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Finalizadoras n" + CHR(227) + "o Fiscal:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFTF - Abre formulario de cadastro de Finalizadoras (Tef)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFTF()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFTF")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Finalizadoras (Tef)" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Finalizadoras (Tef):" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFti - Abre formulario de cadastro de Feitios
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFti()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFti")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Feitios" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Feitios:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFUN - Abre formulario de Cadastro de Fundicoes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFUN()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFUN")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Fundi" + CHR(231) + CHR(245) + "es" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir Cadastro de Fundi" + CHR(231) + CHR(245) + "es:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormfnl - Abre formulario de Tabela de Finalizacoes
*------------------------------------------------------------------------------
PROCEDURE AbrirFormfnl()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formfnl")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario Formfnl", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario Formfnl:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFornecedor - Abre formulario de Cadastro de Formas de Pagamento
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFornecedor()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFornecedor")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formulario FormFornecedor", "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario FormFornecedor:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFpg - Abre formulario de Cadastro Financeiro de Pagamentos (SigCdPag)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFpg()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFpg")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFpg" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Grupos de Pagamento:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFpo - Abre formulario de Condicao de Pagamento Por Operacao
* Nota: this_cDopes deve ser definido antes de Show() para carregar dados.
* Quando aberto via menu, exibe grade vazia (aguarda interacao do usuario).
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFpo()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFpo")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFpo" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formulario de Condi" + CHR(231) + CHR(245) + ;
                     "es de Pagamento Por Opera" + CHR(231) + CHR(227) + "o:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFpr - Abre formulario de cadastro de Modelos de Produtos (SigCdFip)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFpr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFpr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFpr" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Modelos de Produtos:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormFre - Abre formulario de cadastro de Fretes x Cidades
*------------------------------------------------------------------------------
PROCEDURE AbrirFormFre()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormFre")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormFre" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Fretes x Cidades:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormgem - Abre formulario de cadastro de Grupo Empresarial
*------------------------------------------------------------------------------
PROCEDURE AbrirFormgem()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formgem")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Formgem" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Grupo Empresarial:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormgpd - Abre formulario de cadastro de Grupo de Produto
*------------------------------------------------------------------------------
PROCEDURE AbrirFormgpd()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormGpd")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormGpd" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Grupo de Produto:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormgpr - Abre formulario de cadastro de Grande Grupo
*------------------------------------------------------------------------------
PROCEDURE AbrirFormgpr()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formgpr")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Formgpr" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Grande Grupo:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormGr1 - Abre formulario de Geracao de Grupos de Acesso
*------------------------------------------------------------------------------
PROCEDURE AbrirFormGr1()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormGr1")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Gera" + CHR(231) + CHR(227) + "o de Grupos" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Gera" + CHR(231) + CHR(227) + "o de Grupos:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormHOR - Abre FormHOR (Carga Horaria) apos selecao de Fase/Setor e UniPrdt
*------------------------------------------------------------------------------
PROCEDURE AbrirFormHOR()
    LOCAL loc_oForm, loc_oErro
    LOCAL loc_cSetors, loc_cUniPrdts, loc_oLookup

    TRY
        *-- 1. Seleciona Fase/Setor via SigCdGcr (codigos, descrs)
        loc_cSetors = ""
        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", ;
            "Selecione a Fase/Setor")

        IF VARTYPE(loc_oLookup) = "O" AND !ISNULL(loc_oLookup)
            loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oLookup.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLookup.Show(1)

            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                loc_cSetors = ALLTRIM(cursor_4c_BuscaGcr.codigos)
            ENDIF

            loc_oLookup = .NULL.

            IF USED("cursor_4c_BuscaGcr")
                USE IN cursor_4c_BuscaGcr
            ENDIF
        ENDIF

        IF !EMPTY(loc_cSetors)
            *-- 2. Seleciona Unidade Produtiva via SigCdUpd (uniprdts)
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUpd", "cursor_4c_BuscaUpd", "uniprdts", "", ;
                "Selecione a Unidade Produtiva")

            IF VARTYPE(loc_oLookup) = "O" AND !ISNULL(loc_oLookup)
                loc_oLookup.mAddColuna("uniprdts", "", "Unidade Produtiva")
                loc_oLookup.Show(1)

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
                    loc_cUniPrdts = ALLTRIM(cursor_4c_BuscaUpd.uniprdts)
                ENDIF

                loc_oLookup = .NULL.

                IF USED("cursor_4c_BuscaUpd")
                    USE IN cursor_4c_BuscaUpd
                ENDIF
            ENDIF

            IF !EMPTY(loc_cUniPrdts)
                *-- 3. Abre FormHOR com os parametros selecionados
                loc_oForm = CREATEOBJECT("FormHOR", loc_cSetors, loc_cUniPrdts)
                IF VARTYPE(loc_oForm) = "O"
                    loc_oForm.Show()
                ELSE
                    MsgErro("Erro ao criar formul" + CHR(225) + "rio de Carga Hor" + CHR(225) + "ria." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
                ENDIF
            ENDIF
        ENDIF
    CATCH TO loc_oErro
        LOCAL lcMsg
        lcMsg = "Erro ao abrir Carga Hor" + CHR(225) + "ria:" + CHR(13) + CHR(13) + ;
                "Erro: " + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        MsgErro(lcMsg, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormICD - Abre form de Duplicacao dos Tipo de Tributacao
*------------------------------------------------------------------------------
PROCEDURE AbrirFormICD()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormICD")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Duplica" + CHR(231) + CHR(227) + "o de Tipo de Tributa" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Duplica" + CHR(231) + CHR(227) + "o de Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                     "Erro: " + loException.Message + CHR(13) + ;
                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure

        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormICM - Abre formulario de Cadastro de Indices de Comissao (SigCdCmi)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormICM()
    LOCAL loc_oForm, loc_oErro, loc_cMensagem
    loc_oForm     = .NULL.
    loc_oErro     = .NULL.
    loc_cMensagem = ""
    TRY
        loc_oForm = CREATEOBJECT("FormICM")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ENDIF
    CATCH TO loc_oErro
        loc_cMensagem = "Erro ao abrir formul" + CHR(225) + "rio de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o:" + CHR(13) + CHR(13) + ;
                        "Erro: "      + loc_oErro.Message   + CHR(13) + ;
                        "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure
        MostrarErro(loc_cMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormICN - Abre formulario de Icones de Acesso (SigCdPrg)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormICN()
    LOCAL loc_oForm, loc_oErro, loc_cMensagem
    loc_oForm     = .NULL.
    loc_oErro     = .NULL.
    loc_cMensagem = ""
    TRY
        loc_oForm = CREATEOBJECT("FormICN")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de " + CHR(205) + "cones de Acesso" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
        ENDIF
    CATCH TO loc_oErro
        loc_cMensagem = "Erro ao abrir formul" + CHR(225) + "rio de " + CHR(205) + "cones de Acesso:" + CHR(13) + CHR(13) + ;
                        "Erro: "      + loc_oErro.Message   + CHR(13) + ;
                        "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure
        MostrarErro(loc_cMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormICO - Abre formulario de Cadastro de Icones (SigSyIco)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormICO()
    LOCAL loc_oForm, loc_oErro, loc_cMensagem
    loc_oForm     = .NULL.
    loc_oErro     = .NULL.
    loc_cMensagem = ""
    TRY
        loc_oForm = CREATEOBJECT("FormICO")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de " + CHR(205) + "cones" + CHR(13) + ;
                       "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
        ENDIF
    CATCH TO loc_oErro
        loc_cMensagem = "Erro ao abrir formul" + CHR(225) + "rio de " + CHR(205) + "cones:" + CHR(13) + CHR(13) + ;
                        "Erro: "      + loc_oErro.Message   + CHR(13) + ;
                        "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure
        MostrarErro(loc_cMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormIct - Abre formulario de Tipo de Tributacao do ICMS (SigPrTri)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormIct()
    LOCAL loc_oForm, loc_oErro, loc_cMensagem
    loc_oForm     = .NULL.
    loc_oErro     = .NULL.
    loc_cMensagem = ""
    TRY
        loc_oForm = CREATEOBJECT("FormIct")
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Tipo de Tributa" + ;
                CHR(231) + CHR(227) + "o do ICMS" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
        ENDIF
    CATCH TO loc_oErro
        loc_cMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Tipo de Tributa" + ;
                        CHR(231) + CHR(227) + "o do ICMS:" + CHR(13) + CHR(13) + ;
                        "Erro: "      + loc_oErro.Message   + CHR(13) + ;
                        "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure
        MostrarErro(loc_cMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormImp - Abre formulario de cadastro de Impressoras
*------------------------------------------------------------------------------
PROCEDURE AbrirFormImp()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormImp")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormImp" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Impressoras:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message   + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo) + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormInf - Abre formulario de Cadastro de Informacoes Complementares
*------------------------------------------------------------------------------
PROCEDURE AbrirFormInf()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormInf")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio FormInf" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Informa" + ;
                     CHR(231) + CHR(245) + "es Complementares:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message            + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)  + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormint - Abre formulario Tratamento de Inventario (SIGCDINT)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormint()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formint")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Tratamento de Invent" + CHR(225) + "rio" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio Tratamento de Invent" + CHR(225) + "rio:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message            + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)  + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormJrn - Abre formulario Cadastro de Jornadas de Trabalho (SIGCDJRN)
*------------------------------------------------------------------------------
PROCEDURE AbrirFormJrn()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormJrn")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Jornadas de Trabalho" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio Jornadas de Trabalho:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message            + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)  + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormJUS - Abre formulario de Cadastro de Justificativas do Retrabalho
* Standalone: abre sem filtro de retrabalho (mostra todas as justificativas)
* Chamada com parametros: CREATEOBJECT("FormJUS", oFormPai, "TIPO")
*------------------------------------------------------------------------------
PROCEDURE AbrirFormJUS()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("FormJUS")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio de Justificativas do Retrabalho" + ;
                        CHR(13) + "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Justificativas do Retrabalho:" + ;
                     CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message            + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)  + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* AbrirFormlch - Abre formulario de Lote de Cheques
*------------------------------------------------------------------------------
PROCEDURE AbrirFormlch()
    LOCAL loForm, loException

    TRY
        loForm = CREATEOBJECT("Formlch")

        IF VARTYPE(loForm) = "O"
            loForm.Show()
        ELSE
            MostrarErro("Erro ao criar formul" + CHR(225) + "rio Formlch" + CHR(13) + ;
                "VARTYPE retornou: " + VARTYPE(loForm), "Erro")
        ENDIF

    CATCH TO loException
        LOCAL lcMensagem
        lcMensagem = "Erro ao abrir formul" + CHR(225) + "rio de Lote de Cheques:" + CHR(13) + CHR(13) + ;
                     "Erro: "      + loException.Message            + CHR(13) + ;
                     "Linha: "     + TRANSFORM(loException.LineNo)  + CHR(13) + ;
                     "Procedure: " + loException.Procedure
        MostrarErro(lcMensagem, "Erro Detalhado")
    ENDTRY
ENDPROC

*------------------------------------------------------------------------------
* NOTA: Este arquivo contem apenas procedimentos
* A chamada de CriarMenuPrincipal() e READ EVENTS deve ser feita
* no programa principal (main.prg)
*------------------------------------------------------------------------------
