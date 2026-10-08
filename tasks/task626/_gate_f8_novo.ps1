$ErrorActionPreference = "Stop"
. "C:\4c\tasks\task626\_helpers_gate.ps1"
$BaseName  = "SIGPRIFF"
$TaskPath  = "C:\4c\tasks\task626"
$FormType  = "OPERACIONAL"
$formClass = "FormSIGPRIFF"
$boClass   = "SIGPRIFFBO"
$formFile  = "C:\4c\projeto\app\forms\operacionais\FormSIGPRIFF.prg"
$validado  = $false
            # Fase 8: Espera Form COMPLETO com todos os eventos e m�todos
            if (Test-Path $formFile) {
                $conteudo = Get-Content $formFile -Raw
                # BtnSalvarClick fica FORA da lista de nomes obrigatorios: ele
                # eh convencao de form CRUD (botao "Salvar" da Page2 de Dados).
                # Form OPERACIONAL flat nomeia o botao de acao conforme o
                # legado - "Confirmar" (SIGMVCHV, FormFAPP), "Processa"
                # (FormSIGBLCTA) - e exigir o nome BtnSalvarClick obrigaria a
                # INVENTAR um botao que o legado nao tem (viola o PILAR 1 e a
                # regra "NUNCA inventar") ou a criar um metodo vazio (proibido
                # pela regra de completude). Medido em 2026-09-23: 5 dos 134
                # forms OPERACIONAL do projeto legitimamente nao tem
                # BtnSalvarClick. Mesmo raciocinio das excecoes ja aplicadas
                # nas Fases 4, 5 e 6.
                $metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
                $metodosFaltantes = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })

                # FAIL-CLOSED: so aceita a ausencia de BtnSalvarClick quando o
                # dump do legado EXISTE e prova que nao ha botao de gravar.
                # Dump ausente/ilegivel, ou legado COM botao de salvar, mantem
                # a exigencia original do nome canonico.
                $dumpLegadoF8    = Join-Path $TaskPath "$($BaseName)_form_codigo_fonte.txt"
                $txtLegadoF8     = $null
                $legadoSemSalvar = $false
                if (Test-Path $dumpLegadoF8) {
                    $txtLegadoF8 = Get-Content $dumpLegadoF8 -Raw -ErrorAction SilentlyContinue
                    if ($txtLegadoF8) {
                        # Nome de OBJETO/metodo de gravacao no legado. Nao
                        # casar o caminho de imagem "cadastro_salvar_60.jpg":
                        # btnConfirmar usa esse icone e NAO grava nada (o
                        # bloco de persistencia esta comentado no SCX).
                        $padroesSalvarLegado = @(
                            'btnSalvar',
                            'btnGravar',
                            'PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click',
                            'mGravaDados'
                        )
                        $legadoSemSalvar = -not ($padroesSalvarLegado | Where-Object { $txtLegadoF8 -match $_ })
                    }
                }

                # Layout DESPACHANTE: form OPERACIONAL cujo SCX legado nao tem
                # NEM lista NEM campos NEM CRUD - splash/despachante que so
                # avisa e encaminha para outra tela (ex.: SIGMVEXP ->
                # FormSigMvExp, task570: 337x147, TitleBar=0, ControlBox=.F.,
                # UNICO CommandButton "Aguarde Processando Dados" cujo Click eh
                # um DO CASE de despacho disparado pelo Activate).
                # Os quatro nomes exigidos acima sao convencao de form CRUD:
                # FormParaBO/BOParaForm mapeiam CAMPOS (o legado nao tem
                # nenhum), CarregarLista popula a grade da LISTA (idem) e
                # BtnCancelarClick eh o Cancelar da Page2 de Dados. Exigi-los
                # aqui obrigaria a INVENTAR campos, lista e botoes que o legado
                # nao tem (viola o PILAR 1 e a regra "NUNCA inventar") ou a
                # criar quatro metodos vazios (proibido pela regra de
                # completude, validada logo abaixo). Pelo mesmo motivo nao se
                # exige botao de acao com nome da lista canonica: o botao do
                # legado se chama "Processo" e seu handler (BtnProcessoClick)
                # ja eh a acao - o que se cobra eh o botao E o handler dele.
                # Mesmo raciocinio das excecoes das Fases 4, 5, 6 e 7.
                #
                # FAIL-CLOSED: so relaxa com o dump PRESENTE provando as tres
                # ausencias (lista, campos e CRUD) e com a superficie que o
                # legado de fato tem entregue no migrado. Dump ausente/ilegivel
                # mantem a exigencia original - form REPORT nao declara os
                # botoes no SCX (herda do frmrelatorio), e ausencia de prova
                # nao eh prova de ausencia. Medido em 2026-09-24 nos dumps de
                # tasks\: dos 11 forms que hoje falhariam nesta fase por metodo
                # ausente, a excecao dispensa 1 (task570) e mantem os outros 10.
                $legadoDespachanteF8   = $false
                $legadoExibicaoF8      = $false
                $legadoVisualizadorF8  = $false
                $legadoFluxoUnicoF8    = $false
                $legadoLinhaImediataF8 = $false
                $legadoCalculadoraF8   = $false
                $legadoProtocoloF8     = $false
                $legadoFiltroDespachoF8 = $false
                $legadoUtilitarioArquivoF8 = $false
                $legadoGraficoF8       = $false
                $legadoProcessadorLoteF8 = $false
                $legadoEntradaSemBotaoF8 = $false
                if ($FormType -eq "OPERACIONAL" -and $txtLegadoF8) {
                    $temListaLegadoF8 = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                                        ($txtLegadoF8 -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
                    $temCamposLegadoF8 = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
                    # 'pcEscolha' NAO entra nesta lista como nome solto: eh a
                    # variavel de MODO do frmcadastro, mas um dialogo FILHO a
                    # RECEBE do chamador sem ter modo CRUD nenhum. Tratada
                    # abaixo, com o mesmo criterio de DONO que a Fase 7 ja
                    # aplica - ver Test-ModoRecebidoDoChamador.
                    $padroesCrudLegadoF8 = @(
                        'frmcadastro',
                        'Grupo_Op',
                        '(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)',
                        '(Incluir|Alterar|Visualizar|Excluir)\.Click'
                    )
                    $semCrudLegadoF8 = -not ($padroesCrudLegadoF8 | Where-Object { $txtLegadoF8 -match $_ })

                    # APAGA-LINHA DE GRADE x EXCLUIR DE CRUD. O padrao de NOME
                    # acima nao distingue os dois, e o botao que apaga a LINHA
                    # da grade costuma se chamar 'btnexcluir' - identico ao
                    # 'cmdExcluir' da barra do frmcadastro. Quando ele eh a
                    # UNICA evidencia de CRUD do dump, $semCrudLegadoF8 vira
                    # $false e os OITO ramos de excecao ficam fora de alcance
                    # DE UMA VEZ, antes mesmo de serem avaliados - a fase passa
                    # a exigir BtnCancelarClick/FormParaBO/BOParaForm/
                    # CarregarLista de um legado que nao tem Page2, modo de
                    # edicao nem Cancelar. Insatisfazivel sem INVENTAR
                    # superficie (viola o PILAR 1) ou criar metodo vazio
                    # (proibido pela regra de completude).
                    #
                    # Distinguir exige o mesmo criterio que os ramos
                    # VISUALIZADOR e FILTRO-DESPACHO ja precisaram aplicar -
                    # olhar o ALVO da escrita, nao o NOME do botao -, e
                    # Test-LegadoEscritaSoEmCursorLocal (helper do ramo
                    # FILTRO-DESPACHO) ja responde exatamente isso.
                    #
                    # DELIBERADAMENTE em variavel PROPRIA e NAO uma "correcao"
                    # de $semCrudLegadoF8: aquele eh consumido pelos oito ramos
                    # e afrouxa-lo alargaria os oito de uma vez. Mesma decisao
                    # tomada nos ramos PROTOCOLO e FILTRO-DESPACHO diante do
                    # falso positivo de $temListaLegadoF8 - preferir predicado
                    # proprio estreito a mexer no que os outros ja consomem.
                    # So o ramo FLUXO-UNICO consome $semCrudRealF8.
                    #
                    # FAIL-CLOSED em tres provas somadas:
                    #   1. nenhuma evidencia ESTRUTURAL de CRUD (frmcadastro,
                    #      Grupo_Op ou <Verbo>.Click) - so o nome do botao;
                    #   2. o unico verbo casado eh Excluir - sem irmao
                    #      Incluir/Alterar/Visualizar, isto eh, sem a BARRA CRUD
                    #      (que o frmcadastro sempre traz completa);
                    #   3. TODA escrita do dump cai em cursor LOCAL que o
                    #      proprio dump cria - nada persiste em tabela.
                    $soApagaLinhaGradeF8 = $false
                    if (-not $semCrudLegadoF8) {
                        $temCrudEstruturalF8 = ($txtLegadoF8 -match 'frmcadastro') -or
                                               ($txtLegadoF8 -match 'Grupo_Op') -or
                                               ($txtLegadoF8 -match '(Incluir|Alterar|Visualizar|Excluir)\.Click')
                        if (-not $temCrudEstruturalF8) {
                            $verbosCrudCasadosF8 = @(
                                [regex]::Matches($txtLegadoF8, '(?i)(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)') |
                                ForEach-Object { $_.Groups[2].Value.ToLower() } | Select-Object -Unique)
                            $soApagaLinhaGradeF8 = ($verbosCrudCasadosF8.Count -gt 0) -and
                                                   (@($verbosCrudCasadosF8 | Where-Object { $_ -ne 'excluir' }).Count -eq 0) -and
                                                   (Test-LegadoEscritaSoEmCursorLocal -TextoDump $txtLegadoF8)
                        }
                    }
                    $semCrudRealF8 = $semCrudLegadoF8 -or $soApagaLinhaGradeF8

                    # 'pcEscolha' com olhar de DONO. O gate desta fase o lia
                    # cru desde sempre, o que marcava como CRUD todo dialogo
                    # FILHO que so LE o modo - e dai nenhum dos ramos de
                    # excecao alcancava, fazendo a fase exigir
                    # BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista de
                    # um legado que nao tem Page2, nem modo de edicao, nem
                    # botao de Cancelar. Insatisfazivel sem INVENTAR superficie
                    # (viola o PILAR 1) ou criar quatro metodos vazios
                    # (proibido pela regra de completude). A Fase 7 ja tinha
                    # sido consertada em 2026-09-24/25 e o defeito gemeo desta
                    # fase ficou registrado como PENDENTE na mesma ocasiao -
                    # "vai morder o proximo dialogo filho". Mordeu:
                    # SIGPREML -> FormSigPrEml (task603), dialogo de alerta por
                    # email aberto por SigMvCab com
                    # "Do form SigPrEml With TprMvCab.EmpDopNums,
                    # thisform.pcEscolha, laOpeBaixa" - "Parameters prDopes,
                    # pcEscolha, laOpeBaixa" seguido de
                    # "Thisform.pcEscolha = pcEscolha", o modo RECEBIDO da
                    # forma (2) coberta pelo helper. Era a UNICA evidencia de
                    # CRUD no dump inteiro (frmcadastro, Grupo_Op e os dois
                    # padroes de botao CRUD nao casam).
                    #
                    # FAIL-CLOSED, identico a Fase 7 e nas mesmas DUAS formas
                    # de receber: (1) referencia ao objeto pai
                    # ("pForm.pcEscolha") - descontada da contagem; (2)
                    # parametro do proprio Init - Test-ModoRecebidoDoChamador,
                    # que so devolve "recebido" com prova positiva e devolve
                    # $false assim que o form atribui um LITERAL a pcEscolha
                    # (isto eh, decide o proprio modo).
                    # Vale tambem para $semCrudRealF8: o apaga-linha nao pode
                    # servir de atalho para pular a prova de modo recebido.
                    if ($semCrudLegadoF8 -or $semCrudRealF8) {
                        $nPcEscolhaTotalF8 = ([regex]::Matches($txtLegadoF8, '(?i)pcEscolha')).Count
                        $nPcEscolhaDoPaiF8 = ([regex]::Matches($txtLegadoF8, '(?i)(ParentForm|pForm|oForm|oFormulario|par_oForm)\s*\.\s*pcEscolha')).Count
                        if (($nPcEscolhaTotalF8 - $nPcEscolhaDoPaiF8) -gt 0) {
                            if (-not (Test-ModoRecebidoDoChamador -TextoDump $txtLegadoF8)) {
                                $semCrudLegadoF8 = $false
                                $semCrudRealF8   = $false
                            }
                        }
                    }

                    # A excecao NAO pode virar atalho para form vazio: se o
                    # dump prova botao, o migrado precisa do botao E do handler
                    # do Click; sem botao nenhum, exige-se a estrutura base.
                    #
                    # Legado FLAT SEM CONTAINER: ha despachante cujo SCX nao tem
                    # NENHUMA superficie de agrupamento - nem PageFrame, nem
                    # Container (ex.: SIGPRALE -> FormSIGPRALE, task582: 419x115,
                    # TitleBar=0, ControlBox=.F., AlwaysOnTop=.T., so Image + 3
                    # Label penduradas direto na Form e um Init de 4 parametros
                    # que popula Picture/Captions - nem grade, nem campo, nem
                    # botao, nem Click nenhum). Exigir "ConfigurarPageFrame"
                    # desse form obrigaria a inventar um PageFrame que as Fases
                    # 3, 4, 5 e 6 corretamente NAO criaram (viola o PILAR 1 e a
                    # regra "NUNCA inventar") ou a escrever um metodo vazio so
                    # para casar com o regex, que e' o "stub disfarcado" proibido
                    # pela regra de completude. Reaproveita-se aqui o MESMO
                    # criterio ja aplicado nas Fases 3, 4, 5 e 6 (ver
                    # $temEstruturaSemPageFrameF4 / F5 / F6): DEFINE CLASS ... AS
                    # FormBase + InicializarForm + BO instanciado, sem AddObject
                    # de PageFrame.
                    # FAIL-CLOSED: nao afrouxa nada alem disso - o ramo continua
                    # exigindo o dump provando legado SEM lista, SEM campos e SEM
                    # CRUD, e o sub-ramo de botao (nBotoes >= 1) fica intocado.
                    # SEXTA recorrencia da mesma familia: excecao de layout criada
                    # numa fase nao se propaga sozinha para as vizinhas que fazem
                    # a mesma pergunta sobre a mesma superficie.
                    $rxDefineClasseF8Desp = '(?im)^\s*DEFINE\s+CLASS\s+' + [regex]::Escape($formClass) + '\s+AS\s+FormBase\b'
                    $rxInstanciaBOF8Desp  = 'CREATEOBJECT\(\s*"' + [regex]::Escape($boClass) + '"'
                    $temEstruturaSemPageFrameF8 = ($conteudo -notmatch 'AddObject\(\s*"pgf_4c_') -and
                                                  ($conteudo -match $rxDefineClasseF8Desp) -and
                                                  ($conteudo -match $rxInstanciaBOF8Desp)

                    $nBotoesDespachanteF8 = Get-ContagemBotoesLegado -TextoDump $txtLegadoF8
                    if ($nBotoesDespachanteF8 -ge 1) {
                        $temSuperficieDespachanteF8 = ($conteudo -match 'AddObject\(\s*"(cmg_4c_|cmd_4c_)') -and
                                                      ($conteudo -match 'PROCEDURE\s+(Cmd|Btn)\w*Click')
                    } else {
                        $temSuperficieDespachanteF8 = ($conteudo -match "InicializarForm") -and
                                                      (($conteudo -match "ConfigurarPageFrame") -or $temEstruturaSemPageFrameF8)
                    }

                    $legadoDespachanteF8 = ((-not $temListaLegadoF8) -and (-not $temCamposLegadoF8) -and
                                            $semCrudLegadoF8 -and $temSuperficieDespachanteF8)

                    # Layout EXIBICAO: ramo espelho do que as Fases 4, 5 e 6 ja
                    # tem (SIGPDMEN -> FormSigMvMen, task573: dialogo modal com
                    # um EditBox ReadOnly dentro de um Container e um unico
                    # botao "Ok"). Difere do DESPACHANTE por TER campo - o que
                    # faz $temCamposLegadoF8 dar verdadeiro e o ramo acima nao
                    # alcancar -, mas TODO campo do legado eh ReadOnly = .T.
                    # (Test-LegadoDialogoExibicao), e por isso os quatro nomes
                    # exigidos tampouco se aplicam:
                    #   FormParaBO/BOParaForm mapeiam campo EDITAVEL - nao ha o
                    #     que escrever de volta a partir de campo somente-leitura
                    #     (o sentido de leitura ja foi entregue no Carregar* da
                    #     Fase 4, espelhando o Init legado);
                    #   CarregarLista popula a grade da LISTA - o legado nao tem
                    #     lista ($temListaLegadoF8 falso);
                    #   BtnCancelarClick eh o Cancelar da Page2 de Dados - nao ha
                    #     Page2 nem modo de edicao para cancelar.
                    # Exigi-los obrigaria a INVENTAR campos editaveis, lista e
                    # botao que o legado nao tem (viola o PILAR 1 e a regra
                    # "NUNCA inventar") ou a criar quatro metodos vazios
                    # (proibido pela regra de completude).
                    #
                    # FAIL-CLOSED: dump PRESENTE provando ausencia de lista,
                    # ausencia de CRUD e TODO campo ReadOnly, e o migrado tendo
                    # de entregar a superficie que o legado tem (botao + handler)
                    # MAIS o campo somente-leitura reproduzido. Um unico campo
                    # editavel no legado derruba a excecao.
                    $legadoExibicaoF8 = ((-not $temListaLegadoF8) -and $semCrudLegadoF8 -and
                                         (Test-LegadoDialogoExibicao -TextoDump $txtLegadoF8) -and
                                         $temSuperficieDespachanteF8 -and
                                         ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(EditBox|TextBox)"'))

                    # Layout VISUALIZADOR: o legado TEM lista e TEM campo, mas
                    # NENHUM campo aceita digitacao. Ramo espelho do que a Fase 6
                    # ja tem (SIGMVSBN -> FormSigMvSbn, task577: dois grids
                    # somente-leitura, tres fwget com "When -> Return .f." e
                    # exatamente DOIS CommandButton - Sair e BtnOficina).
                    # Difere do ramo de EXIBICAO acima em dois pontos: nao exige
                    # ausencia de lista (este legado TEM grade, o que faz
                    # $temListaLegadoF8 dar verdadeiro e aquele ramo nao
                    # alcancar) e reconhece o "When -> Return .f." do Framework
                    # Fortyus, que eh como o SIGMVSBN torna Get_items/Get_descr/
                    # Get_valo nao-digitaveis - nenhum dos tres declara ReadOnly.
                    #
                    # TRES dos quatro nomes exigidos nao se aplicam:
                    #   FormParaBO/BOParaForm mapeiam campo EDITAVEL - nao ha o
                    #     que escrever de volta a partir de campo somente-leitura
                    #     (o sentido unico BO -> campo ja foi entregue nos
                    #     AfterRowColChange da Fase 7);
                    #   BtnCancelarClick eh o Cancelar da Page2 de Dados - nao ha
                    #     Page2 nem modo de edicao para cancelar.
                    # CarregarLista NAO entra na dispensa: este legado TEM grade,
                    # e popula-la eh justamente o trecho final do Init dele.
                    #
                    # FAIL-CLOSED: dump PRESENTE provando as tres ausencias -
                    # sem CRUD, sem botao de gravar e TODO campo somente-leitura
                    # (Test-LegadoSomenteLeitura: UM campo digitavel derruba a
                    # excecao) - e o migrado tendo de entregar a superficie que o
                    # legado tem: o botao E o handler do Click MAIS o campo
                    # reproduzido como ReadOnly.
                    $legadoVisualizadorF8 = ($semCrudLegadoF8 -and $legadoSemSalvar -and
                                             (Test-LegadoSomenteLeitura -TextoDump $txtLegadoF8) -and
                                             $temSuperficieDespachanteF8 -and
                                             ($conteudo -match '(?im)^\s*\.ReadOnly\s*=\s*\.T\.'))

                    # Layout FLUXO-UNICO: form OPERACIONAL sem CRUD (sem
                    # Incluir/Alterar/Excluir/pcEscolha/frmcadastro/Grupo_Op) que
                    # NAO cai em nenhum dos tres ramos acima porque eles exigem
                    # AUSENCIA de lista (despachante/exibicao) ou AUSENCIA de
                    # campo digitavel (visualizador: Test-LegadoSomenteLeitura).
                    # Este ramo eh o oposto - tem lista de verdade E campo
                    # digitavel de verdade, mas o campo digitavel eh o que
                    # DISPARA a consulta que popula a grade, nao um filtro de
                    # listagem CRUD. Ex.: SIGPRAOP -> FormSigPrAop (task583):
                    # grade de 5 colunas (SigOpPic) toda ReadOnly + um UNICO
                    # campo digitavel (Get_OP, sem ReadOnly e sem When->Return
                    # .f.) cujo Valid consulta SigCdNec/SigPdMvf/SigOpPic e
                    # popula a grade, e um UNICO par de botoes (Grupo_Conf:
                    # Salva grava via Update+Commit, Conf_Sair fecha) - sem
                    # Page1(Lista)/Page2(Dados), sem modo INCLUIR/ALTERAR/
                    # VISUALIZAR/EXCLUIR separado do modo de listagem.
                    #
                    # BtnCancelarClick/FormParaBO/BOParaForm sao convencao do
                    # par Page2(Dados)+modo INCLUIR/ALTERAR do frmcadastro:
                    # FormParaBO/BOParaForm mapeiam TODOS os campos editaveis
                    # de uma ficha de volta ao BO, e BtnCancelarClick descarta
                    # uma edicao em andamento - nao ha ficha nem edicao
                    # cancelavel quando o unico campo digitavel eh o parametro
                    # de uma consulta e a transferencia form->BO acontece por
                    # ARGUMENTO do metodo de carga (nao por mapeamento
                    # generico de campos). CarregarLista tambem sai da lista
                    # exigida, mas so quando o migrado prova que ALGUM metodo
                    # Carregar* alimenta o cursor ligado ao grid - a obrigacao
                    # de popular a lista continua, so o NOME muda para refletir
                    # que a carga eh disparada pelo campo, nao por um metodo de
                    # listagem CRUD independente. Exigir os quatro nomes
                    # canonicos aqui obrigaria a inventar Page2/modo de edicao
                    # que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
                    # inventar") ou a criar metodos vazios (proibido pela regra
                    # de completude).
                    #
                    # FAIL-CLOSED: exige dump PROVANDO semCrudLegadoF8, NAO
                    # coberto por nenhum dos tres ramos acima (ou seja, TEM
                    # lista E TEM campo editavel de verdade ao mesmo tempo) e o
                    # migrado com pelo menos um metodo Carregar* alimentando o
                    # grid. O botao de acao real (Confirmar/Gravar/Processa/...)
                    # continua exigido pelo bloco de $padraoAcaoGravar mais
                    # abaixo, que este ramo NAO substitui.
                    # $semCrudRealF8 (e nao $semCrudLegadoF8): o apaga-linha da grade
                    # nao eh Excluir de CRUD - ver o bloco de $soApagaLinhaGradeF8 acima.
                    $legadoFluxoUnicoF8 = ($semCrudRealF8 -and (-not $legadoDespachanteF8) -and
                                           (-not $legadoExibicaoF8) -and (-not $legadoVisualizadorF8) -and
                                           $temListaLegadoF8 -and $temCamposLegadoF8 -and
                                           ($conteudo -match 'PROCEDURE\s+Carregar\w*'))

                    # QUINTO ramo - LINHA IMEDIATA: dialogo FILHO de grade 1-N,
                    # aberto de dentro de um form pai, que TEM CRUD de LINHA
                    # (Inserir/Excluir) mas NAO tem Salvar/Confirmar nem
                    # Cancelar - cada acao vale na hora, e no legado quem
                    # persistia era o TABLEUPDATE do form PAI sobre o cursor
                    # compartilhado. Ex.: SIGPRCAR -> FormSigPrCar (task585,
                    # "Caracteristicas do Produto"): 480x540, TitleBar=0,
                    # WindowType=1, grade de 2 colunas ligada a crSigPrCar (o
                    # cursor do Cadastro de Produtos) e TRES botoes - cmdInserir
                    # (Insert Into crSigPrCar), cmdExcluir (Delete) e cmdSair
                    # ("Encerrar", Cancel=.T., que apaga as linhas em branco e
                    # fecha). Sem Page1(Lista)/Page2(Dados).
                    #
                    # Nenhum dos quatro ramos acima alcanca: DESPACHANTE exige
                    # sem lista e sem campos (este tem grade e celulas
                    # editaveis); EXIBICAO exige sem lista; VISUALIZADOR e
                    # FLUXO-UNICO exigem $semCrudLegadoF8, e aqui ele eh FALSO de
                    # verdade - o dump tem pcEscolha e cmdInserir/cmdExcluir.
                    #
                    # O que NAO existe eh acao de GRAVAR num botao, e Cancelar:
                    #   - BtnCancelarClick eh o Cancelar da Page2 de Dados, que
                    #     nao existe. O unico caminho de saida eh o Encerrar, e
                    #     ele NAO cancela (descarta linha em branco e fecha).
                    #   - $padraoAcaoGravar pede um botao de gravar/confirmar que
                    #     o legado nao tem: a gravacao eh o Replace na linha,
                    #     disparado pela escolha no lookup da celula.
                    # Exigir os dois obrigaria a INVENTAR dois botoes que o
                    # legado nao tem (viola o PILAR 1 e a regra "NUNCA inventar")
                    # ou a criar handlers vazios (proibido pela regra de
                    # completude). FormParaBO/BOParaForm/CarregarLista continuam
                    # EXIGIDOS - a linha da grade eh a ficha desta tela, entao os
                    # tres tem sentido aqui e nao entram na dispensa.
                    #
                    # FAIL-CLOSED em provas somadas, todas do dump mais a
                    # superficie entregue no .prg:
                    #   1. legado TEM grade e TEM os dois botoes de linha;
                    #   2. legado NAO tem botao de gravar ($legadoSemSalvar) nem
                    #      objeto de acao/confirmacao/cancelamento com qualquer
                    #      dos nomes usuais;
                    #   3. legado NAO tem PageFrame (sem Lista/Dados);
                    #   4. o migrado entregou os dois handlers de linha, a
                    #      persistencia de verdade (Salvar e Excluir no BO) e os
                    #      hooks de transferencia da linha (FormParaBO/BOParaForm)
                    #      - sem isso a dispensa viraria atalho para form que so
                    #      mexe em cursor local e nunca grava.
                    # O par de botoes de LINHA vem das DECLARACOES de
                    # CommandButton do dump, nao de substring no texto cru. Dois
                    # motivos, ambos medidos no SIGPRCOT (task594):
                    #   a) o legado nomeia botao SEM prefixo - os tres do
                    #      SIGPRCOT sao 'inserir', 'delete' e 'sair', entao
                    #      exigir (btn|cmd|Command) antes do verbo deixa de fora
                    #      exatamente o mesmo layout que este ramo existe para
                    #      cobrir (o SIGPRCAR, que o estreou, usa cmdInserir);
                    #   b) procurar o verbo no texto cru casaria com CODIGO: o
                    #      dump do SIGPRCOT contem "Delete From SigCdCot" (o SQL
                    #      do delete.Click). Get-NomesBotoesLegado olha so as
                    #      declaracoes, entao SQL e comentario nao poluem.
                    # 'Delete' entra ao lado de 'Excluir' porque eh o nome que o
                    # legado usa para o botao de excluir LINHA; o resto das
                    # provas somadas abaixo eh que mantem o ramo fechado.
                    $nomesBotoesLegadoF8 = Get-NomesBotoesLegado -TextoDump $txtLegadoF8
                    $temBotoesLinhaLegadoF8 = (@($nomesBotoesLegadoF8 | Where-Object { $_ -match '(?i)(Inserir|Incluir)' }).Count -gt 0) -and
                                              (@($nomesBotoesLegadoF8 | Where-Object { $_ -match '(?i)(Excluir|Delete)'  }).Count -gt 0)
                    # Sem \b e com os radicais CURTOS de proposito: o legado tem
                    # botao chamado "Salva" (SigPrAop, sem o "r"), que a grafia
                    # completa de $legadoSemSalvar nao pega. Casar mais do que o
                    # necessario aqui eh o lado SEGURO - so torna a excecao mais
                    # dificil de valer, nunca mais facil.
                    $semAcaoNemCancelarLegadoF8 = -not ($txtLegadoF8 -match
                        '(?i)(btn|cmd|Command)(Cancel|Confirm|Salva|Grava|Aplica|Executa|Process|Ok)')
                    $semPageFrameLegadoF8 = -not ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*pageframe\s*$')
                    # Inserir OU Incluir no handler migrado: o verbo segue o
                    # botao do legado ('inserir' no SIGPRCOT virou
                    # BtnIncluirClick, 'cmdInserir' no SIGPRCAR virou
                    # BtnInserirClick). Exigir so uma das grafias reprovaria o
                    # form pelo SINONIMO escolhido, nao pela ausencia do
                    # handler - a mesma armadilha de lista de palavras que ja
                    # derrubou a 1a versao do ramo de botao de acao.
                    $temSuperficieLinhaF8 = (($conteudo -match 'PROCEDURE\s+BtnInserirClick') -or
                                             ($conteudo -match 'PROCEDURE\s+BtnIncluirClick')) -and
                                            ($conteudo -match 'PROCEDURE\s+BtnExcluirClick') -and
                                            ($conteudo -match '(?i)this_oBusinessObject\.Salvar\(') -and
                                            ($conteudo -match '(?i)this_oBusinessObject\.Excluir\(') -and
                                            ($conteudo -match 'PROCEDURE\s+FormParaBO') -and
                                            ($conteudo -match 'PROCEDURE\s+BOParaForm')

                    # NAO se exclui com FLUXO-UNICO (os outros tres ramos, sim).
                    # Os dois PODEM valer ao mesmo tempo e sao COMPLEMENTARES:
                    # quando o legado nomeia os botoes de linha sem prefixo
                    # ('inserir'/'delete' do SIGPRCOT), $semCrudLegadoF8 da
                    # verdadeiro - a lista de CRUD procura (btn|cmd|Command)
                    # antes do verbo - e FLUXO-UNICO tambem casa. Dispensas
                    # diferentes: FLUXO-UNICO tira os quatro NOMES canonicos,
                    # LINHA-IMEDIATA tira a exigencia de BOTAO DE ACAO (o bloco
                    # de $padraoAcaoGravar mais abaixo, que so consulta este
                    # ramo). Mantido o -not, o dialogo filho de grade 1-N com
                    # botao sem prefixo perdia a segunda dispensa e a fase
                    # reprovava pedindo um Salvar/Confirmar que o SCX nao tem.
                    $legadoLinhaImediataF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                              (-not $legadoVisualizadorF8) -and
                                              $temListaLegadoF8 -and $temBotoesLinhaLegadoF8 -and
                                              $legadoSemSalvar -and $semAcaoNemCancelarLegadoF8 -and
                                              $semPageFrameLegadoF8 -and $temSuperficieLinhaF8)

                    # SEXTO ramo - CALCULADORA: dialogo utilitario que so faz
                    # CONTA em memoria. TEM campos EDITAVEIS, NAO tem lista nem
                    # grade, NAO tem CRUD e nao persiste nada - o unico botao
                    # fecha a tela. Ex.: SIGPRCFN -> FormSigPrCfn (task589,
                    # "Calculo de Juros"): 600x300, TitleBar=0, WindowType=1,
                    # 19 TextBox + 2 OptionGroup, aberto por CREATEOBJECT com
                    # os parametros do calculo (pVal/pTip/pJMe/pJDi/pDtB/pDtF),
                    # calcula a cada evento e fecha no btnOK ("Sair",
                    # Click = ThisForm.Release). comportamento.json: zero query,
                    # zero tabela.
                    #
                    # Nenhum dos cinco ramos acima alcanca:
                    #   - DESPACHANTE exige SEM campos (este tem 21);
                    #   - EXIBICAO e VISUALIZADOR exigem todo campo somente-
                    #     leitura (aqui o usuario digita - eh uma calculadora);
                    #   - FLUXO-UNICO exige TER lista (este nao tem nenhuma);
                    #   - LINHA-IMEDIATA exige grade + botoes de linha.
                    #
                    # O que nao existe eh lista e Cancelar:
                    #   - CarregarLista popula grade de LISTA, e nao ha grade:
                    #     o dump nao tem BaseClass grid/pageframe, nao tem
                    #     AddCursor/pColuna e nao consulta tabela nenhuma.
                    #   - BtnCancelarClick eh o Cancelar da Page2 de Dados, que
                    #     tampouco existe: nao ha modo de edicao cancelavel
                    #     porque nao ha o que gravar.
                    # FormParaBO/BOParaForm continuam EXIGIDOS - os campos sao
                    # editaveis e alimentam o calculo, entao os dois hooks de
                    # transferencia tem sentido pleno nesta tela (a dispensa eh
                    # PARCIAL, como no ramo visualizador, nao um @() geral).
                    #
                    # FAIL-CLOSED em provas somadas, do dump mais a superficie
                    # entregue no .prg:
                    #   1. legado sem CRUD, sem lista, COM campos editaveis
                    #      (isto eh: NAO passa em Test-LegadoSomenteLeitura);
                    #   2. legado sem botao de gravar ($legadoSemSalvar) e sem
                    #      objeto de acao/confirmacao/cancelamento com qualquer
                    #      dos nomes usuais (mesmo radical curto do 5o ramo);
                    #   3. legado com EXATAMENTE 1 botao, cujo Click so fecha -
                    #      os mesmos dois helpers que $legadoSemAcao usa;
                    #   4. o migrado entregou os dois hooks de transferencia
                    #      REAIS (FormParaBO/BOParaForm) e o handler do unico
                    #      botao do legado. Sem isso a dispensa viraria atalho
                    #      para form que nao transfere campo nenhum.
                    $semAcaoNemCancelarCalcF8 = -not ($txtLegadoF8 -match
                        '(?i)(btn|cmd|Command)(Cancel|Confirm|Salva|Grava|Aplica|Executa|Process)')
                    $cliqueSoFechaCalcF8 = Test-LegadoCliqueSoFecha -TextoDump $txtLegadoF8
                    $nBotoesCalcF8       = Get-ContagemBotoesLegado -TextoDump $txtLegadoF8
                    $temSuperficieCalcF8 = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                                           ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                                           ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')

                    $legadoCalculadoraF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                            (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                                            (-not $legadoLinhaImediataF8) -and
                                            $semCrudLegadoF8 -and (-not $temListaLegadoF8) -and
                                            $temCamposLegadoF8 -and $legadoSemSalvar -and
                                            $semAcaoNemCancelarCalcF8 -and
                                            ($cliqueSoFechaCalcF8 -eq $true) -and ($nBotoesCalcF8 -eq 1) -and
                                            $temSuperficieCalcF8)

                    # SETIMO ramo - PROTOCOLO: dialogo que conversa com um
                    # DISPOSITIVO EXTERNO por DLL declarada no proprio SCX. TEM
                    # campos editaveis, NAO tem lista nem grade, NAO tem CRUD e
                    # NAO tem botao de gravar: o unico botao ABORTA a transacao.
                    # Ex.: SIGPRDFT -> Formsigprdft (task599, "Sitef - Cartao de
                    # Debito"): 500x370, TitleBar=0, WindowType=1, 5 TextBox + 1
                    # OptionGroup, Load declara 4 funcoes da CliSiTef32I.DLL e o
                    # UNICO CommandGroup (SAIDA/CANCELA, ButtonCount=1) chama
                    # ContinuaFuncaoSiTefInterativo(-1), grava os arquivos de
                    # resposta e fecha.
                    #
                    # Nenhum dos seis ramos acima alcanca:
                    #   - DESPACHANTE exige SEM campos (este tem 6);
                    #   - EXIBICAO e VISUALIZADOR exigem todo campo somente-
                    #     leitura (aqui o usuario digita os 4 ultimos digitos, o
                    #     numero de parcelas e o vencimento);
                    #   - FLUXO-UNICO exige um metodo Carregar* alimentando
                    #     grade, e nao ha grade nenhuma;
                    #   - LINHA-IMEDIATA exige grade + botoes de linha;
                    #   - CALCULADORA exige "Click so fecha", e este Click faz
                    #     trabalho de verdade antes de fechar (aborta no
                    #     terminal e grava os arquivos de retorno) - o que NAO o
                    #     torna um botao de GRAVAR.
                    #
                    # O que nao existe eh lista e botao de acao:
                    #   - Carregar...Lista popula grade de LISTA. Aqui a prova
                    #     eh o teste ESTRITO do ramo CAPTURA das Fases 4/5/6, e
                    #     NAO o $temListaLegadoF8 largo: naquele predicado o
                    #     token "ControlSource" casa com a propriedade de
                    #     qualquer controle de valor unico, e neste dump o UNICO
                    #     ControlSource eh "SAIDA.ControlSource = [OPSENHA]" num
                    #     COMMANDGROUP (vestigio da classe Grupo_Saida do
                    #     Framework, nada a ver com lista). Test-Legado
                    #     ControlSourceLigaLista ja sabe descontar exatamente
                    #     esse caso, e Test-LegadoAddCursorLigaGrade faz o mesmo
                    #     para o AddCursor de 3 argumentos - reusar os dois eh
                    #     melhor que escrever um predicado paralelo, e deixa
                    #     $temListaLegadoF8 intocado (os outros seis ramos o
                    #     consomem).
                    #   - Btn...Salvar...Click nao tem o que gravar: o resultado
                    #     desta tela sai pelo protocolo (arquivos de resposta do
                    #     PIN-pad) e pela string do Unload, nao por INSERT/
                    #     UPDATE em tabela - o dump nao tem nenhum.
                    # FormParaBO/BOParaForm continuam EXIGIDOS (dispensa
                    # PARCIAL, como nos ramos visualizador e calculadora): os
                    # campos sao editaveis e alimentam o protocolo, entao os
                    # dois hooks de transferencia tem sentido pleno.
                    #
                    # FAIL-CLOSED em provas somadas:
                    #   1. legado sem CRUD, COM campos editaveis e sem NENHUMA
                    #      evidencia estrita de grade;
                    #   2. legado declarando funcao externa de DLL no SCX - eh
                    #      esta a assinatura que caracteriza "dialogo de
                    #      protocolo" e o que mantem o ramo estreito;
                    #   3. legado sem botao de gravar ($legadoSemSalvar) e sem
                    #      objeto de acao/confirmacao/cancelamento prefixado
                    #      (mesmo radical curto dos ramos 5 e 6);
                    #   4. legado com EXATAMENTE 1 botao;
                    #   5. o migrado entregou os dois hooks REAIS e o handler do
                    #      unico botao do legado. Regex ancorada em inicio de
                    #      linha com \b, NAO substring: a tabela "o que nao se
                    #      aplica" que se escreve no cabecalho do form satisfaria
                    #      um -match solto e a dispensa viraria NO-OP.
                    $semGradeProtocoloF8 = -not (($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe|listbox)\s*$') -or
                                                 ($txtLegadoF8 -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                                                 (Test-LegadoAddCursorLigaGrade -TextoDump $txtLegadoF8) -or
                                                 (Test-LegadoControlSourceLigaLista -TextoDump $txtLegadoF8))
                    $temDllExternaF8     = $txtLegadoF8 -match '(?im)^\s*DECLARE\s+.*\bIN\s+"[^"]+\.(DLL|OCX|EXE)"'
                    $semAcaoNemCancelarProtF8 = -not ($txtLegadoF8 -match
                        '(?i)(btn|cmd|Command)(Cancel|Confirm|Salva|Grava|Aplica|Executa|Process)')
                    $nBotoesProtF8       = Get-ContagemBotoesLegado -TextoDump $txtLegadoF8
                    $temSuperficieProtF8 = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                                           ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                                           ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')

                    $legadoProtocoloF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                          (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                                          (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                                          $semCrudLegadoF8 -and $semGradeProtocoloF8 -and
                                          $temCamposLegadoF8 -and $temDllExternaF8 -and
                                          $legadoSemSalvar -and $semAcaoNemCancelarProtF8 -and
                                          ($nBotoesProtF8 -eq 1) -and $temSuperficieProtF8)

                    # OITAVO ramo - FILTRO-DESPACHO: tela de FILTRO que consulta
                    # e ENTREGA o resultado a OUTRO form. TEM campos editaveis
                    # (o usuario preenche os filtros), NAO tem lista/grade
                    # propria, NAO tem CRUD e NAO persiste nada: a acao monta um
                    # Select, joga num cursor VFP local e faz "Do Form <outro>".
                    # Ex.: SIGPRES1 -> FormSigPrEs1 (task606, "Posicao Por
                    # Movimentacao"): 12 filtros + 4 OptionGroup + CheckBox e um
                    # CommandGroup de DOIS botoes - "Consultar" (consulta
                    # SigMvCab para csTemporario e abre o sigpres2) e "Encerrar".
                    #
                    # Nenhum dos sete ramos acima alcanca:
                    #   - DESPACHANTE exige SEM campos (este tem 17);
                    #   - EXIBICAO e VISUALIZADOR exigem todo campo somente-
                    #     leitura (aqui o usuario digita TODOS os filtros);
                    #   - FLUXO-UNICO exige metodo Carregar* alimentando grade,
                    #     e nao ha grade nenhuma;
                    #   - LINHA-IMEDIATA exige grade + botoes de linha;
                    #   - CALCULADORA exige "Click so fecha" e UM botao; aqui o
                    #     Consultar trabalha de verdade e sao DOIS botoes;
                    #   - PROTOCOLO exige DECLARE de DLL externa, que nao ha.
                    #
                    # O que nao existe eh lista e botao de GRAVAR:
                    #   - Carregar...Lista popula grade de LISTA. A prova aqui eh
                    #     o teste ESTRITO do ramo CAPTURA das Fases 4/5/6, e NAO
                    #     o $temListaLegadoF8 largo - pelo mesmo motivo que o
                    #     ramo PROTOCOLO ja documenta: naquele predicado o token
                    #     "ControlSource" casa com a propriedade de qualquer
                    #     controle de valor unico, e neste dump os UNICOS sete
                    #     ControlSource sao STRING VAZIA (ControlSource = "") em
                    #     TextBox de filtro. Test-LegadoControlSourceLigaLista ja
                    #     exige valor NAO-vazio e por isso devolve $false aqui.
                    #     Deixa $temListaLegadoF8 intocado (os outros sete ramos
                    #     o consomem).
                    #   - Btn...Salvar...Click nao tem o que gravar: a unica
                    #     escrita do dump eh "Update csTemporario Set PrazoEnts =
                    #     Iif(IsNull(...))", limpeza de NULL no cursor VFP que
                    #     alimenta a tela SEGUINTE. Test-LegadoEscritaSoEmCursor
                    #     Local prova que nenhum alvo de escrita eh tabela -
                    #     "olhar o ALVO da escrita, nao a existencia dela", a
                    #     mesma distincao que o ramo VISUALIZADOR precisou fazer.
                    #     O legado TEM botao de acao e o migrado TEM o handler
                    #     dele; o que falta eh so o NOME estar na lista de
                    #     palavras de $padraoAcaoGravar - "Consultar" nao esta.
                    #     O criterio certo aqui eh o do ramo DESPACHANTE ("o
                    #     botao que o legado TEM ganhou handler"), nao o nome
                    #     canonico: lista de palavras no nome do handler erra
                    #     igual a lista de palavras no nome do botao.
                    # FormParaBO/BOParaForm continuam EXIGIDOS (dispensa
                    # PARCIAL, como nos ramos visualizador/calculadora/
                    # protocolo): os campos sao editaveis e alimentam o filtro.
                    #
                    # FAIL-CLOSED em provas somadas:
                    #   1. legado sem CRUD, COM campos editaveis e sem NENHUMA
                    #      evidencia estrita de grade;
                    #   2. legado sem botao de gravar ($legadoSemSalvar) e sem
                    #      NADA persistido em tabela (toda escrita em cursor
                    #      local) - eh esta a prova que substitui a exigencia de
                    #      botao de acao, e a que mantem o ramo estreito;
                    #   3. legado DESPACHANDO para outro form ("Do Form"), que eh
                    #      a assinatura de "filtro que entrega o resultado";
                    #   4. o migrado entregou os dois hooks REAIS e o handler do
                    #      botao de acao. Regex ancorada em inicio de linha com
                    #      \b, NAO substring: a tabela "o que nao se aplica" que
                    #      se escreve no cabecalho do form satisfaria um -match
                    #      solto e a dispensa viraria NO-OP.
                    $semGradeFiltroF8   = $semGradeProtocoloF8
                    $temDoFormF8        = $txtLegadoF8 -match '(?im)^\s*Do\s+Form\s+\w+'
                    $escritaSoCursorF8  = Test-LegadoEscritaSoEmCursorLocal -TextoDump $txtLegadoF8
                    $temSuperficieFiltroF8 = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                                             ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                                             ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')

                    $legadoFiltroDespachoF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                               (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                                               (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                                               (-not $legadoProtocoloF8) -and
                                               $semCrudLegadoF8 -and $semGradeFiltroF8 -and
                                               $temCamposLegadoF8 -and $legadoSemSalvar -and
                                               $temDoFormF8 -and $escritaSoCursorF8 -and
                                               $temSuperficieFiltroF8)

                    # Layout UTILITARIO-ARQUIVO (9o ramo). Ferramenta de
                    # MANUTENCAO que varre arquivos .DBF do disco e grava o
                    # resultado em tabela LOCAL, sem tocar o banco: SIGPREST ->
                    # FormSIGPREST (task608, "Gerar Estrutura" - 600x191,
                    # TitleBar=0, ControlBox=.F., DataSession=2). O Click do
                    # unico botao de acao faz "Set Default To .\basededados\",
                    # ADir('*.Dbf'), "Create Table ArqDBF Free" / "Create Table
                    # ArqInd Free" e alimenta as duas com AFields()/Tag()/Key().
                    #
                    # Nenhum dos oito ramos anteriores alcanca:
                    #   DESPACHANTE  - exige sem campos, e o SCX tem 2 CheckBox;
                    #   EXIBICAO /
                    #   VISUALIZADOR - exigem campo somente-leitura, e as caixas
                    #                  sao clicaveis (sao a ENTRADA da tela);
                    #   FLUXO-UNICO  - exige lista, e nao ha grade nenhuma;
                    #   LINHA-IMEDIATA - exige grade + Inserir/Excluir de linha;
                    #   CALCULADORA  - exige UM botao cujo Click so fecha, e aqui
                    #                  ha DOIS e o primeiro processa de verdade;
                    #   PROTOCOLO    - exige DECLARE de DLL no SCX;
                    #   FILTRO-DESPACHO - exige "Do Form" e escrita so em cursor.
                    #
                    # A exigencia de BOTAO DE ACAO nao eh tocada por este ramo, e
                    # nao precisa ser: o legado TEM acao de verdade e o migrado a
                    # entrega com nome do vocabulario canonico (BtnOKClick).
                    # Dispensa PARCIAL, so os dois nomes que pressupoem CRUD:
                    #   Cancelar  - eh o botao que ABANDONA uma edicao na Page2
                    #               de Dados; nao ha PageFrame, nem modo de
                    #               edicao, nem registro em edicao. O segundo
                    #               botao do SCX eh "Encerrar" (Cancel = .T.),
                    #               que so fecha.
                    #   Lista     - nao ha grade: a "lista" que a ferramenta
                    #               produz sao as linhas de ArqDBF.DBF/ArqInd.DBF,
                    #               GRAVADAS em disco em vez de exibidas.
                    # FormParaBO/BOParaForm continuam EXIGIDOS (as caixas de
                    # opcao mapeiam para properties do BO) e sao o que
                    # $temSuperficieUtilF8 cobra, com regex ANCORADA - a tabela
                    # "o que nao se aplica" do cabecalho do form satisfaria um
                    # -match solto e a dispensa viraria NO-OP.
                    #
                    # FAIL-CLOSED em provas somadas:
                    #   1. sem CRUD e sem NENHUMA evidencia estrita de grade
                    #      (reusa $semGradeProtocoloF8, que sabe que AddCursor de
                    #      3 args e ControlSource vazio/de CommandGroup NAO
                    #      provam lista);
                    #   2. os unicos controles de entrada sao de OPCAO (CheckBox/
                    #      OptionGroup/OptionButton) - se houver TextBox, EditBox,
                    #      ComboBox, ListBox ou Spinner, nao eh este ramo;
                    #   3. o legado nao tem botao de gravar ($legadoSemSalvar);
                    #   4. prova POSITIVA de ferramenta de arquivo: cria tabela
                    #      LOCAL FREE e varre diretorio (ADir + Set Default To);
                    #   5. NADA eh escrito em tabela do banco
                    #      (Test-LegadoEscritaSoEmTabelaLocalFree);
                    #   6. o migrado entregou os dois hooks REAIS e o handler do
                    #      botao de acao.
                    $semGradeUtilF8 = $semGradeProtocoloF8
                    $soOpcaoLegadoF8 = ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(checkbox|optiongroup|optionbutton)\s*$') -and
                                       (-not ($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|spinner)\s*$'))
                    $criaTabelaLocalF8 = $txtLegadoF8 -match '(?i)\bCreate\s+Table\s+[A-Za-z_]\w*\s+Free\b'
                    $varreDiretorioF8  = ($txtLegadoF8 -match '(?i)\bADir\s*\(') -and
                                         ($txtLegadoF8 -match '(?i)\bSet\s+Default\s+To\b')
                    $escritaSoLocalF8  = Test-LegadoEscritaSoEmTabelaLocalFree -TextoDump $txtLegadoF8
                    $temSuperficieUtilF8 = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                                           ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                                           ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')

                    $legadoUtilitarioArquivoF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                                  (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                                                  (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                                                  (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                                                  $semCrudLegadoF8 -and $semGradeUtilF8 -and
                                                  $soOpcaoLegadoF8 -and $legadoSemSalvar -and
                                                  $criaTabelaLocalF8 -and $varreDiretorioF8 -and
                                                  $escritaSoLocalF8 -and $temSuperficieUtilF8)

                    # Layout GRAFICO: a tela EH um grafico. O SCX nao tem grade
                    # nem CRUD nem persistencia; tem um OleBoundControl ligado a
                    # um campo General de cursor LOCAL (o binario do
                    # MSGraph.Chart), um ComboBox somente-selecao que escolhe a
                    # serie a desenhar e botoes de imprimir/encerrar. Ex.:
                    # SIGPRGF2 -> FormSigPrGf2 (task613, "Grafico de Falha X
                    # Recuperacao Mensal"): 3 Container, 1 oleboundcontrol,
                    # 1 CommandGroup de 2 botoes, 1 combobox e 4 label.
                    #
                    # Os QUATRO nomes exigidos sao convencao de form CRUD e aqui
                    # nao tem a que se referir:
                    #   FormParaBO/BOParaForm mapeiam campo EDITAVEL - o unico
                    #     campo eh ComboBox Style = 2 (somente-selecao), e o que
                    #     a tela faz com a escolha eh REDESENHAR o grafico, nao
                    #     gravar valor em property de persistencia;
                    #   CarregarLista popula a grade da LISTA - nao ha grade
                    #     (o predicado ESTREITO abaixo prova isso; o
                    #     $temListaLegadoF8 largo da falso positivo aqui porque
                    #     casa o token "ControlSource", e neste dump o unico
                    #     ControlSource eh o do OleBoundControl do grafico);
                    #   BtnCancelarClick eh o Cancelar da Page2 de Dados - nao
                    #     ha Page2 nem modo de edicao para cancelar.
                    # Exigi-los obrigaria a INVENTAR grade, campo editavel e
                    # botao que o legado nao tem (viola o PILAR 1 e a regra
                    # "NUNCA inventar") ou a criar quatro metodos vazios
                    # (proibido pela regra de completude).
                    #
                    # Por que nao cai nos ramos ja existentes: EXIBICAO e
                    # DESPACHANTE exigem (-not $temListaLegadoF8), que o falso
                    # positivo do ControlSource derruba; VISUALIZADOR nao
                    # dispensa CarregarLista (pressupoe legado COM grade) e cobra
                    # '.ReadOnly = .T.' no migrado; CALCULADORA exige UM unico
                    # botao cujo Click so fecha, e aqui sao DOIS e um deles
                    # imprime. Predicados PROPRIOS e estreitos, deixando
                    # $temListaLegadoF8 e $temSuperficieDespachanteF8 intocados -
                    # mesma decisao dos ramos PROTOCOLO e FILTRO-DESPACHO.
                    #
                    # FAIL-CLOSED em SETE provas somadas:
                    #   1. sem CRUD;
                    #   2. sem objeto/metodo de gravar no legado;
                    #   3. sem grade, pelo predicado ESTREITO (reusa
                    #      Test-LegadoAddCursorLigaGrade e
                    #      Test-LegadoControlSourceLigaLista, que descontam os
                    #      dois falsos positivos conhecidos);
                    #   4. o legado TEM OleBoundControl - eh o que faz a tela ser
                    #      um grafico, e nao um dialogo qualquer;
                    #   5. NENHUM campo do legado aceita digitacao
                    #      (Test-LegadoSomenteLeitura: UM campo digitavel derruba
                    #      a excecao);
                    #   6. o migrado reproduz o OleBoundControl E o campo de
                    #      selecao - nao vale trocar o grafico por outra coisa;
                    #   7. o migrado entrega o handler de Click do(s) botao(oes)
                    #      que o legado tem.
                    $semGradeGraficoF8 = -not (($txtLegadoF8 -match '(?im)^\s*BaseClass:\s*(grid|pageframe|listbox)\s*$') -or
                                               ($txtLegadoF8 -match '(?i)(pColuna|\bGrade\b|\bgrd)') -or
                                               (Test-LegadoAddCursorLigaGrade     -TextoDump $txtLegadoF8) -or
                                               (Test-LegadoControlSourceLigaLista -TextoDump $txtLegadoF8))
                    $temOleLegadoF8      = $txtLegadoF8 -match '(?im)^\s*BaseClass:\s*oleboundcontrol\s*$'
                    $temSuperficieGrafF8 = ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"OleBoundControl"') -and
                                           ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(ComboBox|ListBox)"') -and
                                           ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+(Cmd|Btn)\w*Click\b')

                    $legadoGraficoF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                        (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                                        (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                                        (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                                        (-not $legadoUtilitarioArquivoF8) -and
                                        $semCrudLegadoF8 -and $legadoSemSalvar -and
                                        $semGradeGraficoF8 -and $temOleLegadoF8 -and
                                        (Test-LegadoSomenteLeitura -TextoDump $txtLegadoF8) -and
                                        $temSuperficieGrafF8)

                    # Layout PROCESSADOR-LOTE (11o ramo). Tela de GERACAO em
                    # lote: o usuario preenche criterios digitaveis e UM botao
                    # de acao varre o banco e GRAVA o resultado em tabela real.
                    # SIGPRGMI -> FormSigPrGmi (task619, "Geracao de Pedido de
                    # Estoque Minimo", 800x292): seis criterios (Empresa, Grupo
                    # de Estoque, Conta de Estoque, Linha de Producao, Somente
                    # Negativos e Data) e dois botoes - "Processar" (241 linhas:
                    # valida os criterios, consulta SigMvEst/SigCdPro e insere o
                    # pedido em SigMvCab/SigMvItn) e "Encerrar" (Click =
                    # ThisForm.Release, e nada mais).
                    #
                    # Nenhum dos dez ramos anteriores alcanca:
                    #   DESPACHANTE  - exige legado SEM campos, e aqui o usuario
                    #                  digita os seis criterios;
                    #   EXIBICAO /
                    #   VISUALIZADOR - exigem TODO campo somente-leitura;
                    #   FLUXO-UNICO  - exige lista/grade real (medido no dump:
                    #                  zero BaseClass grid/pageframe/listbox e
                    #                  zero pColuna/Grade/grd);
                    #   LINHA-IMEDIATA - exige grade com Inserir/Excluir por linha;
                    #   CALCULADORA  - exige UM unico botao cujo Click so fecha e
                    #                  NADA persistido; aqui sao DOIS botoes e o
                    #                  Processar grava;
                    #   PROTOCOLO    - exige DECLARE de DLL externa;
                    #   FILTRO-DESPACHO - exige "Do Form" E escrita so em cursor
                    #                  local; aqui nao ha Do Form e a escrita VAI
                    #                  para tabela (ver prova 3 abaixo);
                    #   UTILITARIO-ARQUIVO - exige varredura de .DBF do disco com
                    #                  gravacao em tabela LOCAL Free;
                    #   GRAFICO      - exige OleBoundControl.
                    #
                    # O que nao existe eh lista e modo de edicao:
                    #   - Carregar...Lista popula grade de LISTA, e a prova de que
                    #     nao ha grade eh o teste ESTRITO ($semGradeProtocoloF8),
                    #     que desconta os dois falsos positivos conhecidos do
                    #     $temListaLegadoF8 largo - o token "ControlSource" de
                    #     controle de valor unico e o AddCursor que nao liga
                    #     grade. Aqui os TRES AddCursor do Init legado passam ''
                    #     na posicao do objeto de grade.
                    #   - BtnCancelarClick eh o "Cancelar" da Page2 de Dados do
                    #     frmcadastro: desfaz a edicao e volta para a Lista. Nao
                    #     ha Page2, nao ha modo de edicao, e o Processar nao tem
                    #     caminho de interrupcao (conferido linha a linha: o Click
                    #     eh validacao + consulta + insercao, sem ESC e sem barra
                    #     de progresso cancelavel). O segundo botao do legado eh o
                    #     ENCERRAR - objeto chamado "Cancela" mas com Caption
                    #     "Encerrar" e Click "ThisForm.Release" -, e o migrado o
                    #     entrega como BtnEncerrarClick, convencao dominante do
                    #     projeto (medido em 2026-10-06: 851 arquivos com
                    #     BtnEncerrarClick contra 11 com BtnCancelaClick, que eh o
                    #     nome do objeto legado e viola o PILAR 3). Exigir o NOME
                    #     BtnCancelarClick aqui obrigaria a batizar o botao de
                    #     FECHAR com o verbo de uma acao que a tela nao tem -
                    #     mesma armadilha de "lista de palavras no nome" que o
                    #     ramo FILTRO-DESPACHO ja documenta.
                    # FormParaBO/BOParaForm continuam EXIGIDOS (dispensa PARCIAL,
                    # como nos ramos visualizador/calculadora/protocolo/
                    # filtro-despacho): os seis criterios sao editaveis e
                    # alimentam o processamento.
                    #
                    # FAIL-CLOSED em provas somadas:
                    #   1. legado sem CRUD, COM campos editaveis e sem NENHUMA
                    #      evidencia estrita de grade;
                    #   2. legado sem objeto/metodo de gravar ($legadoSemSalvar) -
                    #      o botao de acao se chama "Processar", nao "Salvar";
                    #   3. o legado PERSISTE de verdade em tabela do banco
                    #      (Test-LegadoPersisteViaAddCursor) - eh esta a prova que
                    #      separa este ramo do FILTRO-DESPACHO e o que impede que
                    #      ele vire atalho para tela sem acao nenhuma;
                    #   4. o migrado entregou os dois hooks REAIS, o handler do
                    #      botao de acao e o handler do botao de fechar. Regex
                    #      ancorada em inicio de linha com \b, NAO substring: a
                    #      tabela "o que nao se aplica" escrita no cabecalho do
                    #      form satisfaria um -match solto e a dispensa viraria
                    #      NO-OP - foi exatamente assim que "CarregarLista" passou
                    #      a satisfazer este gate por COMENTARIO neste form.
                    $temSuperficieProcLoteF8 = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                                               ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                                               ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click\b') -and
                                               ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn(Encerrar|Cancelar|Sair|Fechar)\w*Click\b')

                    $legadoProcessadorLoteF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                                (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                                                (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                                                (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                                                (-not $legadoUtilitarioArquivoF8) -and (-not $legadoGraficoF8) -and
                                                $semCrudLegadoF8 -and $semGradeProtocoloF8 -and
                                                $temCamposLegadoF8 -and $legadoSemSalvar -and
                                                (Test-LegadoPersisteViaAddCursor -TextoDump $txtLegadoF8) -and
                                                $temSuperficieProcLoteF8)

                    # Layout DIALOGO-ENTRADA (input-box): legado que PERGUNTA um
                    # valor e devolve a resposta ao chamador, SEM botao algum.
                    # Caso medido: SIGPRIFF -> FormSIGPRIFF (task626) - 409x50,
                    # WindowType=1, KeyPreview=.T., arvore de QUATRO objetos no
                    # dump (dataenvironment, form1, Text1, Combo1), zero
                    # commandbutton/commandgroup, zero ".Click", zero SQL. O
                    # Init recebe 6 PARAMETERS (pcCab/pcTipo/pcTitulo/pcMaximo/
                    # pcMinimo/pcDado), esconde Text1 ou Combo1 conforme o modo,
                    # e a resposta eh capturada no KeyPress de CADA campo
                    # ("IF nKeyCode = 13 / Resposta = ... / RELEASE WINDOWS"),
                    # com ESC no KeyPress do FORM e "Return(Resposta)" no Unload.
                    #
                    # Difere de TODOS os ramos anteriores, e eh por isso que
                    # nenhum deles alcanca este legado:
                    #   despachante  exige NAO ter campo - aqui o campo eh a
                    #                tela inteira ($temCamposLegadoF8 = $true);
                    #   exibicao/visualizador exigem campo somente-leitura - aqui
                    #                o campo eh justamente o que se digita;
                    #   calculadora/protocolo exigem UM botao no SCX - aqui sao
                    #                ZERO, e por isso tambem nao ha
                    #                Test-LegadoCliqueSoFecha nem contagem == 1
                    #                que valham (medido: cliqueSoFecha devolve
                    #                nulo, nBotoes = 0);
                    #   fluxo-unico/linha-imediata/grafico/processador-lote
                    #                exigem lista, grade, OleBoundControl ou
                    #                persistencia - nada disso existe aqui.
                    #
                    # Os quatro nomes CRUD-canonicos nao se aplicam, pela mesma
                    # razao dos ramos acima: FormParaBO/BOParaForm mapeiam campo
                    # de REGISTRO para gravar (aqui nao se grava nada - a
                    # resposta volta ao chamador em memoria, como o PUBLIC
                    # Resposta do legado), CarregarLista popula a grade da LISTA
                    # (nao ha lista) e BtnCancelarClick eh o Cancelar da Page2 de
                    # Dados (nao ha Page2, nao ha modo de edicao e o cancelamento
                    # eh o ESC do proprio form). A exigencia de botao de acao
                    # tampouco se aplica: o legado NAO TEM BOTAO - exigi-la
                    # obrigaria a INVENTAR um botao (viola o PILAR 1 e a regra
                    # "NUNCA inventar") ou a criar um handler vazio (proibido
                    # pela regra de completude), as duas unicas saidas que
                    # restavam ao retry.
                    #
                    # FAIL-CLOSED: reaproveita a MESMA Test-LegadoSemBotaoAlgum
                    # (nBotoes=0 E zero ".Click" E Class do form 'form' PURO E
                    # nenhum agrupador de VCX) em que o guard de no-op das Fases
                    # 7 e 8 ja confia, somada a dump PRESENTE, ausencia de lista,
                    # ausencia de CRUD, ausencia de botao de gravar e PRESENCA de
                    # campo - e exige do migrado a superficie que o legado de
                    # fato tem: o(s) campo(s) criados, os handlers de captura
                    # ligados por BINDEVENT no KeyPress deles e o KeyPress do
                    # proprio form (o ESC do legado). Dump ausente/ilegivel, ou
                    # legado com UM botao que seja, mantem a exigencia original.
                    #
                    # OITAVA recorrencia da mesma familia: excecao de layout
                    # criada numa fase nao se propaga sozinha para as vizinhas
                    # que fazem a mesma pergunta sobre a mesma superficie - o
                    # guard de no-op da Fase 8 ja tratava "legado sem botao
                    # ALGUM", mas o gate de conteudo da MESMA fase so absorvia
                    # esse legado pelo ramo despachante, que exige ausencia de
                    # campo e portanto nao alcanca um dialogo de ENTRADA.
                    $rxDefineClasseF8Ent    = '(?im)^\s*DEFINE\s+CLASS\s+' + [regex]::Escape($formClass) + '\s+AS\s+FormBase\b'
                    $temSuperficieEntradaF8 = ($conteudo -match 'AddObject\(\s*"(txt_4c_|cbo_4c_|edt_4c_|spn_4c_)') -and
                                              ($conteudo -match '(?i)BINDEVENT\(\s*THIS\.\w+\s*,\s*"KeyPress"') -and
                                              ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+KeyPress\b') -and
                                              ($conteudo -match $rxDefineClasseF8Ent) -and
                                              ($conteudo -match "InicializarForm")

                    $legadoEntradaSemBotaoF8 = ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                                                (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                                                (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                                                (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                                                (-not $legadoUtilitarioArquivoF8) -and (-not $legadoGraficoF8) -and
                                                (-not $legadoProcessadorLoteF8) -and
                                                (-not $temListaLegadoF8) -and $temCamposLegadoF8 -and
                                                $semCrudLegadoF8 -and $legadoSemSalvar -and
                                                (Test-LegadoSemBotaoAlgum -TextoDump $txtLegadoF8) -and
                                                $temSuperficieEntradaF8)
                }

                if ($legadoDespachanteF8 -and $metodosFaltantes.Count -gt 0) {
                    Write-Host "  [i] Fase 8 (layout despachante): legado sem lista, sem campos e sem CRUD - $($metodosFaltantes -join ', ') nao se aplicam; validado pela superficie que o legado de fato tem" -ForegroundColor Cyan
                    $metodosFaltantes = @()
                }

                if ((-not $legadoDespachanteF8) -and $legadoExibicaoF8 -and $metodosFaltantes.Count -gt 0) {
                    Write-Host "  [i] Fase 8 (layout exibicao): legado sem lista, sem CRUD e com todos os campos ReadOnly - $($metodosFaltantes -join ', ') nao se aplicam; validado pela superficie que o legado de fato tem" -ForegroundColor Cyan
                    $metodosFaltantes = @()
                }

                # Dispensa PARCIAL, ao contrario dos dois ramos acima: so saem
                # os tres nomes que pressupoem campo EDITAVEL ou Page2 de Dados.
                # CarregarLista fica de fora de proposito - o legado deste ramo
                # TEM grade, entao popula-la continua obrigatorio, e zerar a
                # lista inteira aqui deixaria passar visualizador com a grade
                # vazia.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    $legadoVisualizadorF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaVisualizadorF8 = @("BtnCancelarClick", "FormParaBO", "BOParaForm")
                    $dispensadosF8 = @($metodosFaltantes | Where-Object { $dispensaVisualizadorF8 -contains $_ })
                    if ($dispensadosF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout visualizador): legado sem CRUD, sem botao de gravar e com TODO campo somente-leitura - $($dispensadosF8 -join ', ') nao se aplicam; validado pela superficie que o legado de fato tem" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaVisualizadorF8 -notcontains $_ })
                    }
                }

                # Dispensa dos quatro nomes CRUD-canonicos quando o legado tem
                # lista E campo editavel reais mas nao tem CRUD nenhum (nao eh
                # despachante, nem exibicao, nem visualizador - ver definicao de
                # $legadoFluxoUnicoF8 acima). CarregarLista entra na dispensa
                # aqui (ao contrario do ramo visualizador) porque a condicao ja
                # exigiu a PROVA de um metodo Carregar* alimentando o grid.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and (-not $legadoVisualizadorF8) -and
                    $legadoFluxoUnicoF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaFluxoUnicoF8 = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
                    $dispensadosFluxoF8 = @($metodosFaltantes | Where-Object { $dispensaFluxoUnicoF8 -contains $_ })
                    if ($dispensadosFluxoF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout fluxo-unico): legado sem CRUD mas com lista e campo editavel reais, sem Page2/modo de edicao cancelavel - $($dispensadosFluxoF8 -join ', ') nao se aplicam; validado pelo metodo Carregar* que alimenta o grid" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaFluxoUnicoF8 -notcontains $_ })
                    }
                }

                # Dispensa de UM nome so - BtnCancelarClick - no dialogo filho de
                # grade 1-N com gravacao imediata por linha (ver definicao de
                # $legadoLinhaImediataF8 acima). FormParaBO/BOParaForm/
                # CarregarLista NAO entram: a linha da grade eh a ficha desta
                # tela e os tres tem sentido nela - a propria condicao do ramo
                # exige que FormParaBO/BOParaForm existam antes de dispensar
                # qualquer coisa. A exigencia de botao de acao eh tratada no
                # bloco de $padraoAcaoGravar logo abaixo.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    $legadoLinhaImediataF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaLinhaImediataF8 = @("BtnCancelarClick")
                    $dispensadosLinhaF8 = @($metodosFaltantes | Where-Object { $dispensaLinhaImediataF8 -contains $_ })
                    if ($dispensadosLinhaF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout linha-imediata): legado eh dialogo filho de grade 1-N com Inserir/Excluir por linha, sem Salvar/Confirmar, sem Cancelar e sem Page1/Page2 - $($dispensadosLinhaF8 -join ', ') nao se aplicam; validado pelos handlers de linha, pela persistencia no BO e pelos hooks FormParaBO/BOParaForm" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaLinhaImediataF8 -notcontains $_ })
                    }
                }

                # Dispensa PARCIAL (como no ramo visualizador): saem so os dois
                # nomes que pressupoem grade de LISTA ou Page2 de Dados.
                # FormParaBO/BOParaForm continuam EXIGIDOS - os campos da
                # calculadora sao editaveis e alimentam o calculo, entao os dois
                # hooks de transferencia tem sentido pleno aqui (e sao, de fato,
                # o que $temSuperficieCalcF8 cobra antes de dispensar o resto).
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    (-not $legadoLinhaImediataF8) -and
                    $legadoCalculadoraF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaCalculadoraF8 = @("BtnCancelarClick", "CarregarLista")
                    $dispensadosCalcF8 = @($metodosFaltantes | Where-Object { $dispensaCalculadoraF8 -contains $_ })
                    if ($dispensadosCalcF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout calculadora): legado eh dialogo de calculo em memoria - campos editaveis, sem lista/grade, sem CRUD, sem persistencia e um unico botao que so fecha - $($dispensadosCalcF8 -join ', ') nao se aplicam; validado pelos hooks FormParaBO/BOParaForm e pelo handler do botao do legado" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaCalculadoraF8 -notcontains $_ })
                    }
                }

                # Dispensa PARCIAL no dialogo de PROTOCOLO (7o ramo, predicado
                # em $legadoProtocoloF8 acima): saem so os nomes que pressupoem
                # grade de LISTA ou Page2 de Dados. FormParaBO/BOParaForm
                # continuam EXIGIDOS - os campos sao editaveis e alimentam o
                # protocolo do dispositivo, e sao justamente o que
                # $temSuperficieProtF8 cobra antes de dispensar o resto.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                    $legadoProtocoloF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaProtocoloF8 = @("BtnCancelarClick", "CarregarLista")
                    $dispensadosProtF8 = @($metodosFaltantes | Where-Object { $dispensaProtocoloF8 -contains $_ })
                    if ($dispensadosProtF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout protocolo): legado eh dialogo de conversa com dispositivo externo via DLL declarada no SCX - campos editaveis, sem lista/grade, sem CRUD e sem botao de gravar - $($dispensadosProtF8 -join ', ') nao se aplicam; validado pelos hooks FormParaBO/BOParaForm e pelo handler do unico botao do legado" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaProtocoloF8 -notcontains $_ })
                    }
                }

                # Dispensa PARCIAL na tela de FILTRO-DESPACHO (8o ramo, predicado
                # em $legadoFiltroDespachoF8 acima): saem so os nomes que
                # pressupoem grade de LISTA ou Page2 de Dados. FormParaBO/
                # BOParaForm continuam EXIGIDOS - os filtros sao editaveis e
                # alimentam a consulta, e sao justamente o que
                # $temSuperficieFiltroF8 cobra antes de dispensar o resto.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                    (-not $legadoProtocoloF8) -and
                    $legadoFiltroDespachoF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaFiltroF8 = @("BtnCancelarClick", "CarregarLista")
                    $dispensadosFiltroF8 = @($metodosFaltantes | Where-Object { $dispensaFiltroF8 -contains $_ })
                    if ($dispensadosFiltroF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout filtro-despacho): legado eh tela de filtro que consulta para cursor local e despacha o resultado a outro form - sem lista/grade propria, sem CRUD e sem persistencia - $($dispensadosFiltroF8 -join ', ') nao se aplicam; validado pelos hooks FormParaBO/BOParaForm e pelo handler do botao de acao do legado" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaFiltroF8 -notcontains $_ })
                    }
                }

                # Dispensa PARCIAL na ferramenta de ARQUIVO (9o ramo, predicado
                # em $legadoUtilitarioArquivoF8 acima): saem so os dois nomes que
                # pressupoem grade de LISTA ou Page2 de Dados. FormParaBO/
                # BOParaForm continuam EXIGIDOS - as caixas de opcao sao a
                # entrada da tela e mapeiam para properties do BO, e sao
                # justamente o que $temSuperficieUtilF8 cobra antes de dispensar
                # o resto. A exigencia de botao de acao segue valendo: este
                # legado TEM acao de verdade.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                    (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                    $legadoUtilitarioArquivoF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaUtilF8 = @("BtnCancelarClick", "CarregarLista")
                    $dispensadosUtilF8 = @($metodosFaltantes | Where-Object { $dispensaUtilF8 -contains $_ })
                    if ($dispensadosUtilF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout utilitario-arquivo): legado eh ferramenta de manutencao que varre .DBF do disco e grava o resultado em tabela LOCAL Free - sem grade, sem CRUD, sem escrita em tabela do banco e com as caixas de opcao como unica entrada - $($dispensadosUtilF8 -join ', ') nao se aplicam; validado pelos hooks FormParaBO/BOParaForm e pelo handler do botao de acao do legado" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaUtilF8 -notcontains $_ })
                    }
                }

                # Ramo GRAFICO (ver as SETE provas onde $legadoGraficoF8 eh
                # calculado). Dispensa os QUATRO nomes: a tela nao tem grade
                # (CarregarLista), nao tem Page2/modo de edicao
                # (BtnCancelarClick) e seu unico campo eh ComboBox
                # somente-selecao que REDESENHA o grafico em vez de alimentar
                # persistencia (FormParaBO/BOParaForm). O que se cobra em troca
                # esta em $temSuperficieGrafF8: o OleBoundControl do grafico, o
                # campo de selecao e o handler de Click do botao do legado.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                    (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                    (-not $legadoUtilitarioArquivoF8) -and
                    $legadoGraficoF8 -and $metodosFaltantes.Count -gt 0) {
                    Write-Host "  [i] Fase 8 (layout grafico): legado eh tela de GRAFICO - OleBoundControl ligado a campo General de cursor local, ComboBox somente-selecao escolhendo a serie, sem grade, sem CRUD e sem persistencia - $($metodosFaltantes -join ', ') nao se aplicam; validado pelo grafico reproduzido, pelo campo de selecao e pelo handler do botao do legado" -ForegroundColor Cyan
                    $metodosFaltantes = @()
                }

                # Dispensa PARCIAL de DOIS nomes - BtnCancelarClick e
                # CarregarLista - na tela de GERACAO em lote (ver definicao de
                # $legadoProcessadorLoteF8 acima). FormParaBO/BOParaForm NAO
                # entram: os criterios sao editaveis e alimentam o
                # processamento, e a propria condicao do ramo exige que os dois
                # existam como metodo REAL antes de dispensar qualquer coisa.
                # A exigencia de botao de acao tambem NAO eh dispensada: esta
                # tela GRAVA, e o $padraoAcaoGravar logo abaixo ja a satisfaz
                # pelo handler do botao de acao do legado.
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                    (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                    (-not $legadoUtilitarioArquivoF8) -and (-not $legadoGraficoF8) -and
                    $legadoProcessadorLoteF8 -and $metodosFaltantes.Count -gt 0) {
                    $dispensaProcLoteF8 = @("BtnCancelarClick", "CarregarLista")
                    $dispensadosProcLoteF8 = @($metodosFaltantes | Where-Object { $dispensaProcLoteF8 -contains $_ })
                    if ($dispensadosProcLoteF8.Count -gt 0) {
                        Write-Host "  [i] Fase 8 (layout processador-lote): legado eh tela de GERACAO em lote - criterios digitaveis e um botao de acao que varre o banco e GRAVA em tabela real via AddCursor+Commit, sem grade, sem CRUD e sem modo de edicao cancelavel - $($dispensadosProcLoteF8 -join ', ') nao se aplicam; validado pelos hooks FormParaBO/BOParaForm, pelo handler do botao de acao e pelo handler do botao de fechar" -ForegroundColor Cyan
                        $metodosFaltantes = @($metodosFaltantes | Where-Object { $dispensaProcLoteF8 -notcontains $_ })
                    }
                }

                # Dispensa dos QUATRO nomes CRUD-canonicos no dialogo de ENTRADA
                # sem botao algum (ver definicao de $legadoEntradaSemBotaoF8
                # acima). Dispensa TOTAL, como em despachante/exibicao/grafico:
                # nao ha registro a gravar (a resposta volta ao chamador em
                # memoria), nao ha lista a popular e nao ha Page2 a cancelar - o
                # cancelamento eh o ESC do proprio form, que a condicao do ramo
                # ja exigiu entregue (PROCEDURE KeyPress).
                if ((-not $legadoDespachanteF8) -and (-not $legadoExibicaoF8) -and
                    (-not $legadoVisualizadorF8) -and (-not $legadoFluxoUnicoF8) -and
                    (-not $legadoLinhaImediataF8) -and (-not $legadoCalculadoraF8) -and
                    (-not $legadoProtocoloF8) -and (-not $legadoFiltroDespachoF8) -and
                    (-not $legadoUtilitarioArquivoF8) -and (-not $legadoGraficoF8) -and
                    (-not $legadoProcessadorLoteF8) -and
                    $legadoEntradaSemBotaoF8 -and $metodosFaltantes.Count -gt 0) {
                    Write-Host "  [i] Fase 8 (layout dialogo-entrada): legado eh input-box que pergunta um valor e devolve a resposta ao chamador - campo digitavel, sem lista/grade, sem CRUD, sem persistencia e ZERO botao no SCX - $($metodosFaltantes -join ', ') nao se aplicam; validado pelos campos criados, pelos handlers de captura no KeyPress deles e pelo KeyPress do form (o ESC do legado)" -ForegroundColor Cyan
                    $metodosFaltantes = @()
                }

                # A excecao acima NAO pode virar atalho para form sem acao
                # nenhuma: o botao que grava/confirma tem de existir com ALGUM
                # nome. Aceita o nome canonico CRUD ou o nome que o legado usa.
                #
                # MAS existe legado que nao tem botao de acao NENHUM: SIGMVCTH
                # (task566) eh um visualizador somente-leitura de historico de
                # cotacoes cujo UNICO botao eh o cmdSalva.btnSair ("Retornar",
                # Cancel = .T., Click = ThisForm.Release). Exigir acao de
                # gravar ali obrigaria a INVENTAR um botao (viola o PILAR 1) ou
                # a criar um handler vazio (proibido pela regra de completude) -
                # a mesma armadilha que a Fase 6 tinha com lookup inexistente e
                # a Fase 7 com o piso de 2 handlers.
                #
                # FAIL-CLOSED em TRES provas somadas, todas vindas do dump:
                #   1. o legado nao tem objeto/metodo de gravar ($legadoSemSalvar)
                #   2. TODO evento Click do SCX apenas fecha a tela
                #      (Test-LegadoCliqueSoFecha) - nao basta olhar o NOME do
                #      botao, ha acao com nome que lista de palavras nao pega
                #      (btnCopiar, btnCargas, btnApagar, cmdLimSenha...)
                #   3. o legado tem EXATAMENTE 1 botao (contagem 0 = form REPORT,
                #      que herda os botoes do frmrelatorio sem declara-los no
                #      SCX: ausencia de prova, nao prova de ausencia)
                # Faltando qualquer uma, a exigencia original permanece.
                # Medido em 2026-09-24 nos 565 dumps de tasks\: as tres juntas
                # dispensam 7 forms; so a prova 3 dispensaria 58.
                $padraoAcaoGravar = 'PROCEDURE\s+Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK)\w*Click'
                if ((-not $legadoDespachanteF8) -and ($conteudo -notmatch $padraoAcaoGravar)) {
                    $legadoSemAcao          = $false
                    $acaoLegadoComHandlerF8 = $false
                    if ($txtLegadoF8 -and $legadoSemSalvar) {
                        $cliqueSoFechaF8 = Test-LegadoCliqueSoFecha -TextoDump $txtLegadoF8
                        $nBotoesLegadoF8 = Get-ContagemBotoesLegado -TextoDump $txtLegadoF8
                        $legadoSemAcao   = (($cliqueSoFechaF8 -eq $true) -and ($nBotoesLegadoF8 -eq 1))

                        # Visualizador com MAIS de um botao: o SIGMVSBN
                        # (task577) tem DOIS - Sair e BtnOficina -, e o Click do
                        # BtnOficina nao fecha a tela (monta o numero da OS e
                        # abre o SigRePhi), entao nem Test-LegadoCliqueSoFecha
                        # nem a contagem == 1 alcancam. Continua nao havendo
                        # acao de GRAVAR: o legado nao tem campo digitavel
                        # nenhum nem Insert/Update/Delete. Exigir
                        # BtnSalvar/Confirmar/Processa aqui obrigaria a INVENTAR
                        # um botao que o legado nao tem (viola o PILAR 1) ou a
                        # criar um handler vazio (proibido pela regra de
                        # completude) - a mesma armadilha que a Fase 6 tinha com
                        # lookup inexistente e a Fase 7 com o piso de 2
                        # handlers. As provas de $legadoVisualizadorF8 (sem
                        # CRUD, sem gravar, TODO campo somente-leitura, mais a
                        # superficie entregue) sao o que mantem isso fechado.
                        if (-not $legadoSemAcao) {
                            $legadoSemAcao = $legadoVisualizadorF8
                        }

                        # Dialogo filho de grade 1-N com gravacao imediata por
                        # linha (SIGPRCAR): aqui HA escrita - Insert/Delete/
                        # Replace no cursor da grade -, mas ela nao pende de
                        # BOTAO nenhum. O legado tem Inserir, Excluir e Encerrar,
                        # e a gravacao do par Codigo/Descricao acontece no
                        # Replace disparado pela escolha no lookup da celula; no
                        # legado quem persistia era o TABLEUPDATE do form PAI.
                        # Nem Test-LegadoCliqueSoFecha (o Click do cmdInserir
                        # insere, o do cmdExcluir apaga) nem a contagem == 1 (sao
                        # tres botoes) nem $legadoVisualizadorF8 (a grade eh
                        # editavel e ha CRUD de linha) alcancam. As provas de
                        # $legadoLinhaImediataF8 - sem botao de gravar, sem
                        # Cancelar, sem PageFrame, mais os handlers de linha, a
                        # persistencia no BO e os hooks FormParaBO/BOParaForm
                        # entregues - sao o que mantem isso fechado.
                        if (-not $legadoSemAcao) {
                            $legadoSemAcao = $legadoLinhaImediataF8
                        }

                        # Dialogo de PROTOCOLO (SIGPRDFT): o unico botao do SCX
                        # ABORTA a transacao no dispositivo - chama a funcao da
                        # DLL com -1, grava os arquivos de resposta e fecha -,
                        # entao Test-LegadoCliqueSoFecha devolve $false e nem a
                        # contagem == 1 sozinha alcanca. Trabalho antes de fechar
                        # NAO transforma um Cancelar em botao de GRAVAR: nao ha o
                        # que persistir (o dump nao tem INSERT/UPDATE/DELETE em
                        # tabela). As provas de $legadoProtocoloF8 - sem CRUD,
                        # sem grade, sem botao de gravar, DLL externa declarada,
                        # um unico botao, mais os hooks e o handler entregues -
                        # sao o que mantem isso fechado.
                        if (-not $legadoSemAcao) {
                            $legadoSemAcao = $legadoProtocoloF8
                        }

                        # Tela de FILTRO-DESPACHO (SIGPRES1): aqui HA botao de
                        # acao - "Consultar" - e o migrado TEM o handler dele
                        # (BtnConsultarClick). Test-LegadoCliqueSoFecha devolve
                        # $false (o Click consulta e abre outro form) e sao DOIS
                        # botoes, entao nem ele nem a contagem == 1 alcancam.
                        # O que nao existe eh acao de GRAVAR: a unica escrita do
                        # dump tem como alvo um cursor VFP local, nao tabela
                        # (Test-LegadoEscritaSoEmCursorLocal). Exigir
                        # BtnSalvar/Confirmar/Processa aqui obrigaria a INVENTAR
                        # um botao que o legado nao tem (viola o PILAR 1) ou a
                        # criar um handler vazio (proibido pela regra de
                        # completude). As provas de $legadoFiltroDespachoF8 sao
                        # o que mantem isso fechado.
                        if (-not $legadoSemAcao) {
                            $legadoSemAcao = $legadoFiltroDespachoF8
                        }

                        # Legado cuja ACAO nao eh gravar em tabela: o botao
                        # existe, faz trabalho de verdade e JA tem handler no
                        # migrado - so o VERBO nao esta na lista canonica de
                        # $padraoAcaoGravar. Ex.: SIGPRFTP -> Formsigprftp
                        # (task611), transferencia de arquivos via FTP com
                        # "Conecta"/"Transfere"/"Recebe"/"Rede Dial-Up".
                        # Acrescentar verbo a lista repetiria o defeito (lista
                        # de palavras no nome erra sempre - Fase 7 com o verbo
                        # CRUD com sufixo); o criterio certo eh o que o proprio
                        # comentario deste bloco ja promete, "o nome que o
                        # legado usa": derivar o verbo do Caption/Name dos
                        # CommandButton do DUMP e cobrar o handler
                        # correspondente. Test-AcaoDoLegadoTemHandler descarta
                        # o botao que so fecha a tela, exige raiz de 4+ letras
                        # e casa o handler ANCORADO em inicio de linha, para o
                        # cabecalho do form nao satisfazer a checagem.
                        if (-not $legadoSemAcao) {
                            $acaoLegadoComHandlerF8 = Test-AcaoDoLegadoTemHandler `
                                -TextoDump $txtLegadoF8 -ConteudoForm $conteudo
                            $legadoSemAcao = $acaoLegadoComHandlerF8
                        }

                        # Tela de GRAFICO: nao ha acao de GRAVAR a exigir. Os
                        # botoes do legado sao imprimir o grafico e encerrar -
                        # nada persiste em tabela (prova 2 de $legadoGraficoF8:
                        # sem objeto/metodo de gravar no dump). O handler do
                        # botao ja eh cobrado por $temSuperficieGrafF8, e
                        # Test-AcaoDoLegadoTemHandler nao alcanca este caso
                        # porque o verbo do botao do legado eh "Grafico"/
                        # "Imprimir" sobre um CommandGroup, nao um
                        # CommandButton com Caption proprio. Exigir aqui um
                        # Btn(Salvar|Confirmar|Gravar|...)Click obrigaria a
                        # INVENTAR botao de gravar numa tela que so desenha.
                        if (-not $legadoSemAcao) {
                            $legadoSemAcao = $legadoGraficoF8
                        }

                        # Dialogo de ENTRADA sem botao ALGUM (SIGPRIFF): nao ha
                        # acao de gravar NEM botao de acao a exigir, porque nao
                        # ha botao nenhum no SCX. Test-LegadoCliqueSoFecha nao
                        # alcanca (devolve nulo - nao existe ".Click" para
                        # inspecionar) e a contagem == 1 nao alcanca (sao ZERO),
                        # entao sem este ramo a unica forma de "satisfazer" o
                        # gate seria INVENTAR um botao. A acao da tela mora no
                        # KeyPress dos campos, que $temSuperficieEntradaF8 ja
                        # cobra entregue.
                        if (-not $legadoSemAcao) {
                            $legadoSemAcao = $legadoEntradaSemBotaoF8
                        }
                    }

                    if ($legadoSemAcao) {
                        if ($legadoGraficoF8) {
                            # Mensagem propria: aqui NAO se pode dizer "Click so
                            # faz ThisForm.Release" (um dos dois botoes IMPRIME o
                            # grafico) nem "sem botao de acao" (ha, e com
                            # handler) - as duas frases seriam factualmente
                            # erradas, o mesmo erro que a mensagem unica cometia
                            # antes do ramo visualizador. O que falta eh acao de
                            # GRAVAR: a tela desenha e imprime, nao persiste.
                            Write-Host "  [i] Fase 8: legado eh tela de GRAFICO (OleBoundControl + ComboBox somente-selecao; os botoes imprimem o grafico e encerram, nada persiste em tabela) - exigencia de botao de GRAVAR nao se aplica" -ForegroundColor Cyan
                        } elseif (($cliqueSoFechaF8 -eq $true) -and ($nBotoesLegadoF8 -eq 1) -and $legadoCalculadoraF8) {
                            # Mesma prova estrutural do ramo acima (1 botao, Click
                            # so fecha), mas NAO eh "somente-leitura": a
                            # calculadora tem campo editavel. Dizer o contrario
                            # aqui seria factualmente errado, como ja aconteceu
                            # com a mensagem unica antes do ramo visualizador.
                            Write-Host "  [i] Fase 8: legado eh dialogo de calculo em memoria (UM botao no SCX, Click so faz ThisForm.Release, nada a persistir) - exigencia de botao de acao nao se aplica" -ForegroundColor Cyan
                        } elseif (($cliqueSoFechaF8 -eq $true) -and ($nBotoesLegadoF8 -eq 1)) {
                            Write-Host "  [i] Fase 8: legado somente-leitura (UM botao no SCX e todo Click so faz ThisForm.Release) - exigencia de botao de acao nao se aplica" -ForegroundColor Cyan
                        } elseif ($legadoLinhaImediataF8) {
                            Write-Host "  [i] Fase 8: legado eh dialogo filho de grade 1-N (Inserir/Excluir por linha, gravacao imediata, sem botao de Salvar/Confirmar no SCX) - exigencia de botao de acao nao se aplica" -ForegroundColor Cyan
                        } elseif ($legadoProtocoloF8) {
                            # Mensagem propria: aqui NAO se pode dizer "Click so
                            # faz ThisForm.Release" (o Cancelar aborta no
                            # dispositivo antes de fechar) nem "somente-leitura"
                            # (os campos sao digitaveis) - as duas frases seriam
                            # factualmente erradas, o erro que a mensagem unica
                            # ja cometeu antes do ramo visualizador.
                            Write-Host "  [i] Fase 8: legado eh dialogo de protocolo com dispositivo externo (UNICO botao do SCX aborta a transacao na DLL e fecha; nada a persistir em tabela) - exigencia de botao de acao nao se aplica" -ForegroundColor Cyan
                        } elseif ($legadoFiltroDespachoF8) {
                            # Mensagem propria: aqui NAO se pode dizer "Click so
                            # faz ThisForm.Release" (o Consultar consulta e abre
                            # outro form) nem "somente-leitura" (os filtros sao
                            # digitaveis) nem "sem botao de acao" (ha um, e com
                            # handler) - as quatro frases seriam factualmente
                            # erradas. O que falta eh acao de GRAVAR.
                            Write-Host "  [i] Fase 8: legado eh tela de filtro que consulta para cursor local e despacha o resultado a outro form (Do Form) - ha botao de acao e ele tem handler no migrado, mas nada eh persistido em tabela, entao exigencia de botao de GRAVAR nao se aplica" -ForegroundColor Cyan
                        } elseif ($acaoLegadoComHandlerF8) {
                            # Mensagem propria: aqui NAO se pode dizer "Click so
                            # faz ThisForm.Release" (o botao trabalha), nem
                            # "somente-leitura" (ha campo digitavel), nem "sem
                            # botao de acao" (ha, e com handler) - as tres frases
                            # seriam factualmente erradas, o mesmo erro que a
                            # mensagem unica cometia antes do ramo visualizador.
                            Write-Host "  [i] Fase 8: legado tem botao de ACAO e o migrado tem o handler dele, so o VERBO nao esta na lista canonica (a acao da tela nao eh gravar em tabela) - exigencia do nome canonico nao se aplica" -ForegroundColor Cyan
                        } elseif ($legadoEntradaSemBotaoF8) {
                            # Mensagem propria: aqui NAO se pode dizer "Click so
                            # faz ThisForm.Release" nem "UM botao no SCX" (sao
                            # ZERO botoes, zero ".Click") nem "somente-leitura"
                            # (o campo eh justamente o que se digita) - as tres
                            # frases seriam factualmente erradas, o mesmo erro
                            # que a mensagem unica cometia antes do ramo
                            # visualizador.
                            Write-Host "  [i] Fase 8: legado eh input-box sem botao ALGUM (nBotoes=0, zero .Click) - a acao mora no KeyPress dos campos, entao exigencia de botao de acao nao se aplica" -ForegroundColor Cyan
                        } else {
                            Write-Host "  [i] Fase 8: legado visualizador (sem CRUD, sem botao de gravar e TODO campo somente-leitura) - exigencia de botao de acao nao se aplica" -ForegroundColor Cyan
                        }
                    } else {
                        $metodosFaltantes += "BtnSalvarClick (ou BtnConfirmarClick/BtnGravarClick/BtnProcessaClick)"
                    }
                }

                if ((-not $legadoDespachanteF8) -and ($conteudo -notmatch "BtnSalvarClick")) {
                    if ($legadoSemSalvar) {
                        Write-Host "  [i] Fase 8: legado sem botao de gravar - validado pelo botao de acao que o legado realmente tem" -ForegroundColor Cyan
                    } else {
                        $metodosFaltantes += "BtnSalvarClick (legado TEM botao de gravar, ou dump ausente)"
                    }
                }

                # Pista de diagnostico, no espirito do que a Fase 6 ja faz: sem
                # isto, quem ve a fase reprovar nao descobre que EXISTEM ramos de
                # excecao nem o que cada um exige para valer - e a reacao errada
                # eh mexer no form (inventando botao/campo que o legado nao tem)
                # em vez de conferir se o gate eh satisfazivel para este legado.
                if ($metodosFaltantes.Count -gt 0 -and $FormType -eq "OPERACIONAL") {
                    Write-Host "  [i] Fase 8: ramos de excecao (todos exigem o dump do legado PRESENTE) - despachante: sem lista, sem campos e sem CRUD; exibicao: sem lista, sem CRUD e todo campo ReadOnly; visualizador: sem CRUD, sem botao de gravar e todo campo somente-leitura (aceita When -> .f. e heranca de Grid/Column), dispensa apenas BtnCancelarClick/FormParaBO/BOParaForm e mantem CarregarLista; fluxo-unico: sem CRUD mas COM lista e campo editavel reais (campo dispara a carga da lista), dispensa BtnCancelarClick/FormParaBO/BOParaForm/CarregarLista exigindo em troca um metodo Carregar* que alimente o grid; linha-imediata: dialogo filho de grade 1-N com Inserir/Excluir por linha e gravacao imediata, sem Salvar/Confirmar, sem Cancelar e sem PageFrame no SCX, dispensa apenas BtnCancelarClick e a exigencia de botao de acao, exigindo em troca os handlers de linha, a persistencia no BO e os hooks FormParaBO/BOParaForm; calculadora: dialogo de calculo em memoria - COM campo editavel, sem lista/grade, sem CRUD, sem persistencia e UM unico botao cujo Click so fecha -, dispensa apenas BtnCancelarClick/CarregarLista e a exigencia de botao de acao, exigindo em troca os hooks FormParaBO/BOParaForm e o handler do botao do legado; grafico: a tela EH um grafico - OleBoundControl ligado a campo General de cursor local, ComboBox somente-selecao escolhendo a serie, sem grade, sem CRUD e sem persistencia -, dispensa os QUATRO nomes e a exigencia de botao de GRAVAR, exigindo em troca o OleBoundControl reproduzido, o campo de selecao e o handler do botao do legado; dialogo-entrada: input-box que pergunta um valor e devolve a resposta ao chamador - campo digitavel, sem lista/grade, sem CRUD, sem persistencia e ZERO botao no SCX (nBotoes=0, zero .Click, Class form puro) -, dispensa os QUATRO nomes e a exigencia de botao de acao, exigindo em troca os campos criados, os handlers de captura ligados por BINDEVENT no KeyPress deles e o KeyPress do proprio form" -ForegroundColor DarkGray
                }

                if ($metodosFaltantes.Count -eq 0) {
                    $tamanho = [math]::Round((Get-Item $formFile).Length / 1KB, 2)
                    Write-Host "  ? Form COMPLETO com todos os m�todos: $formFile ($tamanho KB)" -ForegroundColor Green
                    $validado = $true
                } else {
                    Write-Host "  ?? Form existe mas faltam m�todos finais: $($metodosFaltantes -join ', ')" -ForegroundColor Yellow
                }
            } else {
                Write-Host "  ? Form N�O encontrado: $formFile" -ForegroundColor Red
            }
Write-Host "RESULTADO: validado=$validado faltantes=[$($metodosFaltantes -join ", ")] entradaSemBotao=$legadoEntradaSemBotaoF8"
