$alvo = 'C:\4c\projeto\app\forms\operacionais\FormSigOpLoc.prg'
$linhas = [System.Collections.Generic.List[string]]( [IO.File]::ReadAllText($alvo) -split "`r`n" )

$bloco = @'
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
*   Esta fase NAO acrescentou metodo novo, e isso eh o resultado correto: a
*   superficie que o legado tem ja estava inteira ao fim da Fase 7. Os 10
*   metodos/eventos do dump foram conferidos um a um contra o migrado:
*     SIGOPLOC.Init ................. InicializarForm + ConfigurarGrade +
*                                     CarregarDados + Caption nos 2 labels
*     Check1.Click .................. ChkMarcacaoClick      (NODEFAULT)
*     Check1.KeyPress ............... ChkMarcacaoKeyPress   (13/32 + toggle)
*     Check1.MouseDown .............. ChkMarcacaoMouseDown  (NODEFAULT)
*     Check1.MouseUp ................ ChkMarcacaoMouseUp    (toggle - par canonico)
*     Column2.Text1.When -> .f. ..... Column2.ReadOnly = .T.
*     Column3.Text1.When -> .f. ..... Column3.ReadOnly = .T.
*     DesmarcarEmp.Click ............ CmdDesmarcarEmpClick
*     MarcarEmp.Click ............... CmdMarcarEmpClick
*     btnSair.Click ................. CmdBtnSairClick
*
*   OS QUATRO NOMES CANONICOS DA FASE 8 NAO TEM REFERENTE NESTE LEGADO
*   BtnCancelarClick, FormParaBO, BOParaForm e CarregarLista sao convencao do
*   par Page2(Dados) + modo INCLUIR/ALTERAR do frmcadastro. Aqui nao existe
*   nenhum dos dois, e escrever os quatro obrigaria a INVENTAR superficie
*   (viola o PILAR 1) ou a criar metodo vazio (proibido pela regra de
*   completude). O gate da Fase 8 reconhece exatamente este formato no ramo
*   FLUXO-UNICO - "sem CRUD mas COM lista e campo editavel reais" -, que
*   dispensa os quatro em troca de um metodo Carregar* alimentando a grade
*   (CarregarDados, acima). Os predicados foram MEDIDOS em 2026-11-08
*   (automation\MedirGateF8Task763.ps1, que reusa os helpers do proprio
*   orquestrador em vez de reimplementa-los):
*     temListaLegadoF8  = True   (BaseClass: grid no dump)
*     temCamposLegadoF8 = True   (BaseClass: checkbox/textbox no dump)
*     semCrudLegadoF8   = True   (sem frmcadastro, Grupo_Op, pcEscolha nem
*                                 botao com verbo Incluir/Alterar/Visualizar/Excluir)
*     legadoSemSalvar   = True   (sem btnSalvar/btnGravar/mGravaDados)
*     Test-LegadoSomenteLeitura = False  -> NAO eh visualizador/exibicao: a
*                                 caixa de marcacao da Column1 eh editavel
*                                 (ReadOnly = .F. no dump, e sem When -> .f.)
*     => legadoFluxoUnicoF8 = True
*   E a exigencia de BOTAO DE ACAO eh satisfeita por
*   Test-AcaoDoLegadoTemHandler = True: o verbo vem do proprio dump
*   ("DesmarcarEmp") e o migrado tem CmdDesmarcarEmpClick. Nao se acrescenta
*   BtnSalvarClick/BtnConfirmarClick - a acao desta tela nao eh gravar.
*
*   INTEGRACAO - o que NAO se faz neste form, e por que
*     - menu.prg: NENHUM item. Esta tela eh dialogo FILHO modal cuja grade
*       vive do crSigOpOco do CHAMADOR (ver "CONTRATO EXTERNO" acima); aberta
*       pelo menu, sem chamador, abriria com a grade VAZIA. Mesmo criterio ja
*       aplicado aos outros dialogos filhos migrados - FormSigOpCtd,
*       FormSigOpCcj, FormSigPrCar, FormSigPrEml e FormSIGPRSTF tambem nao
*       tem entrada em menu.prg. Quem abre esta tela eh o form de
*       movimentacao que monta o cursor, e ele chama GarantirClasse antes do
*       CREATEOBJECT.
*     - config.prg: NENHUM SET PROCEDURE. Desde 2026-10-28 a carga eh SOB
*       DEMANDA (CLAUDE.md, secao config.prg): acrescentar BO/Form ali eh
*       proibido. forms\operacionais ja esta no escopo de
*       automation\GerarIndiceClasses.ps1, entao start\indice_classes.txt
*       passa a listar FormSigOpLoc/SigOpLocBO sozinho na proxima abertura.
*
*   VERIFICACAO DESTA FASE (2026-11-08)
*     COMPILACAO PROVADA: o smoke test do VFP9 desta sessao FALHOU (exit = 0,
*     .FXP criado, arquivo de saida ausente - o VFP compila e sai sem
*     executar), entao vale a variante que ainda prova compilacao: passar o
*     proprio .prg em "vfp9.exe -T". FormSigOpLoc.FXP e SigOpLocBO.FXP
*     gerados, nenhum .ERR. Com CONTROLE NEGATIVO na mesma rodada - uma copia
*     deste form com "PUBLIC PROCEDURE" (regra #9.1) colada no fim gerou .ERR
*     apontando SO as linhas acrescentadas (1020-1022: "Syntax error" /
*     "Statement is not valid in a class definition" / "Nesting error") -, o
*     que prova de uma vez que o detector funciona E que as 1017 linhas deste
*     arquivo compilam limpas.
*     NAO FOI PROVADO runtime/instanciacao: sem execucao no VFP9 desta sessao
*     nao ha como afirmar CREATEOBJECT nem o bind real da grade.
*     Estatico, tudo medido e com resultado ZERO: acento literal em .prg
*     (regra #4), "this_X .Value" (regra #43), RETURN dentro de TRY (regra
*     #1, por profundidade), MESSAGEBOX direto, ISEMPTY/MostrarAviso/.Self/
*     Controls("nome") (regras #2/#9.3/#38/#34), chamada a nome nao resolvido
*     contra utils + metodos da classe + heranca (regra #13), THIS.<membro>
*     sem referente, Test-CompletudeCodigo (TODO/stub) nos dois arquivos e
*     VerificarPropriedadesInexistentes.ps1 (regra #33). Os 4 arquivos de
*     .Picture conferidos em disco (regra #25): onebit_33.ico,
*     to-do-list_checked2.ico e cadastro_sair_60.jpg em vbmp\, mais
*     imagens\new_background.jpg em Framework\. Os 3 metodos do BO que o form
*     chama (MarcarTodos, DesmarcarTodos, AlternarSelecao) conferidos PUBLIC
*     no BO E na BusinessBase (regra #51).
*
'@

$idx = $linhas.FindIndex({ param($l) $l -match '^\*\s*O QUE ESTE FORM NAO TEM, e por que' })
if ($idx -lt 0) { throw 'ancora nao encontrada' }

$novas = @($bloco -split "`r`n|`n")
$linhas.InsertRange($idx, [string[]]$novas)

[IO.File]::WriteAllText($alvo, ($linhas -join "`r`n"), [Text.Encoding]::ASCII)
Write-Host "inserido em linha $($idx+1); total agora = $($linhas.Count)"
