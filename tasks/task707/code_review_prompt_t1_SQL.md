# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NOCCORS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CSERIES, CNFIS, NKEYCODE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CSERIES, CNFIS, NKEYCODE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CORRECS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CSERIES, CNFIS, NKEYCODE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CSERIES, CNFIS, NKEYCODE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CSERIES, CNFIS, NKEYCODE

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  Column3.ControlSource = ""
lcQryCorNf = [Select * From SigNfCor ]+;
lcQryEmp   = [Select * From SigCdEmp Where cemps = ?pcEmps ]
Select CrSigCcOco
	Insert Into XCorNf (cods,descs,retifs) ;
	.Column1.ControlSource = 'XCorNf.cods'
	.Column2.ControlSource = 'XCorNf.descs'
	.Column3.ControlSource = 'XCorNf.retifs'
Select XCorNf
		Select XCorNf
		Select XCorNf

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCOR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1687 linhas total):

*-- Linhas 60 a 78:
60: *   FormBuscaAuxiliar ...... 0
61: *
62: * O .sct tambem foi lido direto (as unicas cadeias de codigo guardadas nele
63: * sao o "Insert Into XCorNf" do Init e as propriedades dos dois TextBox), e a
64: * SECAO 3 do dump traz codigo para apenas CINCO metodos: Load e Init do form,
65: * o When das colunas 1 e 2 da grade e o KeyPress do Edit1 da coluna 3. Nenhum
66: * campo desta tela referencia outra tabela, entao NAO existem BINDEVENT de F4/
67: * DblClick nem metodo AbrirLookup*/AbrirBusca* aqui. Fabricar um lookup para
68: * "preencher a fase" violaria o PILAR 1 e a regra "NUNCA inventar tabelas de
69: * lookup que nao existem no original" - e gravaria dado consultando tabela que
70: * o legado nunca abriu.
71: *
72: * O que a fase entrega no lugar e a regra dos campos: ValidarFaixaNotas().
73: * Ver o comentario do proprio metodo para a origem da guarda (Ok.Click do form
74: * irmao SIGOPCCO, de onde o SIGOPCORBO.ValidarDados tambem a transcreveu na
75: * Fase 2) e para o motivo de NAO ser chamada do KeyPress dos campos.
76: *
77: * DIFERENCA DE REGRA em relacao ao irmao SIGOPCCO, que tem os mesmos dois
78: * objetos no mesmo lugar: la o Get_NotaIni declara "When -> Return .f." (campo

*-- Linhas 342 a 386:
342: 
343:     *--------------------------------------------------------------------------
344:     * CriarCursorOcorrencias - cursor LOCAL (nao SQL) de ocorrencias da carta
345:     * de correcao, equivalente ao "Create Cursor XCorNf (cods n(3),descs c(30),
346:     * retifs m NULL)" do PROCEDURE Load legado - mesmos tres campos, mesmos
347:     * tipos e mesma ordem (a ordem tem de ser identica em todo lugar que cria
348:     * o cursor, porque a grade liga cada coluna por nome).
349:     *
350:     * SET NULL ON antes do CREATE CURSOR: o legado declara "retifs m NULL" e a
351:     * coluna de origem (SigNfCor.mretifs) e text NULL no schema.
352:     *
353:     * O legado NAO cria indice neste cursor (diferente do form irmao SIGOPCCO,
354:     * que precisa de Seek para casar a retificacao gravada com a ocorrencia) -
355:     * aqui nao ha busca por chave, entao nenhum indice e criado.
356:     *--------------------------------------------------------------------------
357:     PROTECTED PROCEDURE CriarCursorOcorrencias()
358:         IF USED("cursor_4c_Ocorrencias")
359:             USE IN cursor_4c_Ocorrencias
360:         ENDIF
361: 
362:         SET NULL ON
363:         CREATE CURSOR cursor_4c_Ocorrencias (cods N(3), descs C(30), retifs M NULL)
364:         SET NULL OFF
365:     ENDPROC
366: 
367:     *--------------------------------------------------------------------------
368:     * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPCOR.Grade: 3 colunas
369:     * (Ocorrencia/Descricao/Retificacao), geometria TRANSCRITA do dump
370:     * (Top=118, Left=98, Width=604, Height=298, RowHeight=16, GridLines=3,
371:     * ScrollBars=2, TabIndex=5, DeleteMark=.F.).
372:     *
373:     * Column3 usa EditBox (o legado tem Column3.Edit1, nao Text1): por isso
374:     * precisa de AddObject + CurrentControl + Sparse = .F. - sem o
375:     * CurrentControl a coluna continua desenhando o Text1 default e o texto da
376:     * retificacao digitada nunca aparece; sem Sparse = .F. o EditBox so
377:     * apareceria na linha ativa.
378:     *
379:     * ReadOnly das COLUNAS vem DEPOIS do ReadOnly do Grid, porque o do grid
380:     * propaga para as colunas e sobrescreveria. O legado declara o grid como
381:     * somente-leitura e abre a excecao na Column3 (Column3.ReadOnly = .F.);
382:     * aqui o grid fica editavel e as duas primeiras colunas sao travadas - o
383:     * resultado visivel ao usuario e identico (Ocorrencia e Descricao nao
384:     * aceitam digitacao, Retificacao aceita) e reproduz tambem o
385:     * "Return(.F.)" que o legado declara no When dos Text1 dessas colunas.
386:     *--------------------------------------------------------------------------

*-- Linhas 405 a 450:
405:             .ForeColor         = RGB(0, 0, 0)
406:             .AllowHeaderSizing = .F.
407:             .AllowRowSizing    = .F.
408:             .DeleteMark        = .F.
409:             .RecordMark        = .F.
410:             .GridLines         = 3
411:             .GridLineWidth     = 1
412:             .ReadOnly          = .F.
413:             .RowHeight         = 16
414:             .ScrollBars        = 2
415:             .TabIndex          = 5
416: 
417:             .Column1.ControlSource     = "cursor_4c_Ocorrencias.cods"
418:             .Column1.Width             = 70
419:             .Column1.FontName          = "Tahoma"
420:             .Column1.FontSize          = 8
421:             .Column1.Movable           = .F.
422:             .Column1.Resizable         = .F.
423:             .Column1.ForeColor         = RGB(0, 0, 0)
424:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
425:             .Column1.Header1.Alignment = 2
426:             .Column1.Header1.FontName  = "Tahoma"
427:             .Column1.Header1.FontSize  = 8
428:             .Column1.Text1.BorderStyle = 0
429:             .Column1.Text1.Margin      = 0
430:             .Column1.Text1.ForeColor   = RGB(0, 0, 0)
431:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
432:             *-- POR ULTIMO de proposito (ver comentario do metodo)
433:             .Column1.ReadOnly          = .T.
434: 
435:             .Column2.ControlSource     = "cursor_4c_Ocorrencias.descs"
436:             .Column2.Width             = 220
437:             .Column2.FontName          = "Tahoma"
438:             .Column2.FontSize          = 8
439:             .Column2.Movable           = .F.
440:             .Column2.Resizable         = .F.
441:             .Column2.ForeColor         = RGB(0, 0, 0)
442:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
443:             .Column2.Header1.Alignment = 2
444:             .Column2.Header1.FontName  = "Tahoma"
445:             .Column2.Header1.FontSize  = 8
446:             .Column2.Text1.BorderStyle = 0
447:             .Column2.Text1.Margin      = 0
448:             .Column2.Text1.ForeColor   = RGB(0, 0, 0)
449:             .Column2.Text1.BackColor   = RGB(255, 255, 255)
450:             *-- POR ULTIMO, mesmo motivo da Column1

*-- Linhas 472 a 490:
472:             .Column3.edt_4c_Retificacao.ReadOnly  = .F.
473:             .Column3.edt_4c_Retificacao.ForeColor = RGB(0, 0, 0)
474:             .Column3.CurrentControl    = "edt_4c_Retificacao"
475:             .Column3.ControlSource     = "cursor_4c_Ocorrencias.retifs"
476:             .Column3.Sparse            = .F.
477:             .Column3.ReadOnly          = .F.
478: 
479:             .Visible = .T.
480:         ENDWITH
481: 
482:         *-- SIGOPCOR.Grade.Column3.Edit1.KeyPress (legado): navegacao por
483:         *-- registro dentro da grade. O metodo alvo ja existe nesta classe e e
484:         *-- PUBLIC - o vinculo e validado no momento do registro, nao no
485:         *-- disparo do evento, entao so pode apontar para metodo existente.
486:         BINDEVENT(THIS.grd_4c_Dados.Column3.edt_4c_Retificacao, "KeyPress", ;
487:                   THIS, "GradeRetificacaoKeyPress")
488:     ENDPROC
489: 
490:     *--------------------------------------------------------------------------

*-- Linhas 749 a 767:
749:     * deste form - conferido no dump (a SECAO 3 traz codigo para apenas cinco
750:     * metodos: Load e Init do form, o When das colunas 1 e 2 da grade e o
751:     * KeyPress do Edit1 da coluna 3) e tambem no proprio .sct, cujas unicas
752:     * cadeias de codigo sao o "Insert Into XCorNf" do Init. A guarda transcrita
753:     * aqui e a do Ok.Click do form IRMAO SIGOPCCO, que grava a MESMA tabela
754:     * (SigNfCor) a partir da MESMA grade (XCorNf):
755:     *
756:     *     If Not IsEmpty(ThisForm.Get_NotaIni.Value)
757:     *         ...
758:     *     Else
759:     *         MessageBox('Nota Fiscal Invalida !!',0+48,'')
760:     *     EndIf
761:     *
762:     * Mesma decisao, mesma justificativa e MESMA cadeia de mensagem que a Fase
763:     * 2 ja adotou em SIGOPCORBO.ValidarDados - fonte unica da regra, PILAR 3.
764:     * La o BO critica a LINHA que vai ser gravada (this_cNfis); aqui o form
765:     * critica a FAIXA que o usuario digitou, que e superficie da tela. O irmao
766:     * tem UM campo de nota e este tem DOIS, logo a guarda vale para os dois
767:     * limites: com qualquer um em branco a clausula "between" fica com um lado

*-- Linhas 863 a 928:
863:     * O Ok.Click de SIGOPCOR chegou VAZIO no acervo - conferido no dump (a
864:     * SECAO 3 traz codigo para apenas CINCO metodos: Load e Init do form, o
865:     * When das colunas 1 e 2 da grade e o KeyPress do Edit1 da coluna 3) e
866:     * tambem no proprio .sct, cujas unicas cadeias de codigo sao o "Insert Into
867:     * XCorNf" do Init. O MESMO extrator capturou Ok.Click e Cancela.Click no
868:     * irmao SIGOPCCO, do mesmo formato de .sct - a ausencia aqui e do legado,
869:     * nao da extracao (o irmao ainda carrega um "Suspend" de depuracao solto no
870:     * meio do Ok.Click, sinal de que esta familia de telas ficou inacabada).
871:     *
872:     * Por isso o comportamento vem da FAMILIA: o Ok.Click do irmao SIGOPCCO,
873:     * que grava a MESMA tabela (SigNfCor) a partir da MESMA grade (XCorNf). E a
874:     * mesma fonte, com a mesma justificativa, que a Fase 2 usou em
875:     * SIGOPCORBO.ValidarDados/Inserir e a Fase 6 em ValidarFaixaNotas - fonte
876:     * unica da regra (PILAR 3).
877:     *
878:     * O QUE O CHAMADOR PROVA (tasks/task375/SIGCDCNF_form_codigo_fonte.txt,
879:     * SIGCDCNF.Pagina.Lista.InserirCarta.Click):
880:     *
881:     *     Locate For CrSigMvNfi.correcs = .F.
882:     *     If !Found()
883:     *         MessageBox('Todas as Notas desta selecao possuem Cartas de Correcao !!')
884:     *     Else
885:     *         ThisForm.Enabled = .F.
886:     *         Do Form SigOpCor With ThisForm,pcemps,lcSerie,ldEmisDe,ldEmisAte
887:     *         Select CrSigMvNfi / Go Bottom / ThisForm.Pagina.Lista.Grade.Refresh
888:     *     EndIf
889:     *
890:     * Esta tela e o botao "InserirCarta": CRIA cartas de correcao para as notas
891:     * da selecao que ainda nao tem uma. O irmao SIGOPCCO e o botao
892:     * "AlteraCarta" e recebe UMA nota (CrSigMvNfi.NFis) - dai ele comecar com
893:     * Delete/Update para REFAZER a carta existente, passo que aqui nao se
894:     * aplica, porque o registro nao existe ainda.
895:     *
896:     * Quem repinta a lista do form chamador e o PROPRIO chamador, no retorno do
897:     * "Do Form" (Select CrSigMvNfi / Go Bottom / Grade.Refresh) - este form e
898:     * modal em producao (WindowType = 1 no Init), entao o controle volta para la
899:     * depois do Release e nada precisa ser feito daqui.
900:     *
901:     * FLUXO (transcrito do irmao, com as diferencas da FAIXA anotadas):
902:     *
903:     *   1) guarda "Nota Fiscal Invalida !!" -> THIS.ValidarFaixaNotas(), que a
904:     *      Fase 6 escreveu exatamente para ser chamada daqui, e que tambem faz
905:     *      o espelho tela -> objeto de negocio dos dois limites (this_cNfisDe /
906:     *      this_cNfisAte, os pcNFisDe/pcNFisAte do Init legado);
907:     *   2) o "Scan While llTaOK / If Not IsEmpty(XCorNf.Retifs)" do irmao -
908:     *      so a ocorrencia COM retificacao digitada e gravada;
909:     *   3) "ThisForm.Release" somente no caminho de SUCESSO; os ramos de erro
910:     *      do legado fazem "Return 0" e deixam a tela aberta.
911:     *
912:     * O passo 2 do irmao que NAO e portado aqui e a atualizacao do flag
913:     * SigMvNfi.Correcs (Update SigMvNfi Set Correcs = ... + Commit/RollBack do
914:     * fSqlConector), que no irmao migrado mora num LOTE T-SQL unico dentro do
915:     * objeto de negocio. SIGOPCORBO nao expoe metodo equivalente, e esta fase
916:     * entrega EVENTOS do form - acrescentar SQL no form violaria a separacao de
917:     * camadas (PILAR 3). Esta ausencia esta registrada como pendencia explicita
918:     * em vez de simulada por um stub que devolveria sucesso sem gravar o flag.
919:     *
920:     * A contagem previa de retificacoes digitadas (passo entre 1 e 2) e a regra
921:     * CLAUDE.md #20: gravacao que percorre cursor de detalhe e nao encontra
922:     * nenhuma linha valida NAO pode reportar sucesso - avisa, devolve o foco a
923:     * grade e mantem a tela aberta.
924:     *
925:     * PUBLIC (nao PROTECTED) porque e alvo de BINDEVENT - regra CLAUDE.md #3.
926:     *--------------------------------------------------------------------------
927:     PROCEDURE BtnConfirmarClick()
928:         LOCAL loc_lProsseguir, loc_nRetificacoes, loc_nGravadas, loc_oErro

*-- Linhas 1024 a 1073:
1024:         loc_nQtd = 0
1025: 
1026:         IF USED("cursor_4c_Ocorrencias")
1027:             SELECT cursor_4c_Ocorrencias
1028:             GO TOP IN cursor_4c_Ocorrencias
1029: 
1030:             DO WHILE !EOF("cursor_4c_Ocorrencias")
1031:                 loc_cRetifs = cursor_4c_Ocorrencias.retifs
1032: 
1033:                 IF ISNULL(loc_cRetifs) OR VARTYPE(loc_cRetifs) != "C"
1034:                     loc_cRetifs = ""
1035:                 ENDIF
1036: 
1037:                 IF !EMPTY(ALLTRIM(loc_cRetifs))
1038:                     loc_nQtd = loc_nQtd + 1
1039:                 ENDIF
1040: 
1041:                 SELECT cursor_4c_Ocorrencias
1042:                 SKIP IN cursor_4c_Ocorrencias
1043:             ENDDO
1044: 
1045:             GO TOP IN cursor_4c_Ocorrencias
1046:         ENDIF
1047: 
1048:         RETURN loc_nQtd
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * GravarRetificacoesDaFaixa - o Scan do Ok.Click do irmao SIGOPCCO,
1053:     * adaptado a FAIXA desta tela:
1054:     *
1055:     *     Select XCorNf / Go Top In XCorNf
1056:     *     Scan While llTaOK
1057:     *         If llTaOK And Not IsEmpty(XCorNf.Retifs)
1058:     *             Insert Into crSigNfCor (cEmps, cSeries, cNfis, nOccors,
1059:     *                                     mRetifs, cIdChaves) ;
1060:     *                             Values (ThisForm.Emp, ThisForm.Serie,
1061:     *                                     ThisForm.Get_NotaIni.Value,
1062:     *                                     XCorNf.Cods, XCorNf.Retifs,
1063:     *                                     fUniqueIds())
1064:     *         EndIf
1065:     *     EndScan
1066:     *
1067:     * O "While llTaOK" do legado para na PRIMEIRA falha - reproduzido em
1068:     * loc_lContinua: sem isso uma falha de banco renderia um dialogo de erro
1069:     * por linha da grade.
1070:     *
1071:     * AS NOTAS DA FAIXA. O irmao tem UM campo de nota e grava "Get_NotaIni.
1072:     * Value" como cnfis. Esta tela tem DOIS limites, que no legado parametrizam
1073:     * "cnfis between ?pcNFisDe And ?pcNFisAte" - um FILTRO. Para GRAVAR e

*-- Linhas 1154 a 1176:
1154:         ENDIF
1155: 
1156:         IF loc_lContinua
1157:             *-- "ThisForm.Emp" / "ThisForm.Serie" do Insert legado: o contexto
1158:             *-- que o form chamador passou no Init vale para a faixa inteira
1159:             loc_nLarg = LEN(loc_cNotaIni)
1160: 
1161:             SELECT cursor_4c_Ocorrencias
1162:             GO TOP IN cursor_4c_Ocorrencias
1163: 
1164:             DO WHILE !EOF("cursor_4c_Ocorrencias") AND loc_lContinua
1165:                 loc_nCods   = cursor_4c_Ocorrencias.cods
1166:                 loc_cRetifs = cursor_4c_Ocorrencias.retifs
1167: 
1168:                 IF ISNULL(loc_cRetifs) OR VARTYPE(loc_cRetifs) != "C"
1169:                     loc_cRetifs = ""
1170:                 ENDIF
1171: 
1172:                 *-- "If llTaOK And Not IsEmpty(XCorNf.Retifs)"
1173:                 IF !EMPTY(ALLTRIM(loc_cRetifs))
1174:                     IF loc_lNotaUnica
1175:                         IF THIS.GravarOcorrencia(loc_cNotaIni, loc_nCods, loc_cRetifs)
1176:                             loc_nGravadas = loc_nGravadas + 1

*-- Linhas 1196 a 1359:
1196:                 ENDIF
1197: 
1198:                 IF loc_lContinua
1199:                     SELECT cursor_4c_Ocorrencias
1200:                     SKIP IN cursor_4c_Ocorrencias
1201:                 ENDIF
1202:             ENDDO
1203: 
1204:             SELECT cursor_4c_Ocorrencias
1205:             GO TOP IN cursor_4c_Ocorrencias
1206:         ENDIF
1207: 
1208:         RETURN loc_nGravadas
1209:     ENDPROC
1210: 
1211:     *--------------------------------------------------------------------------
1212:     * GravarOcorrencia - grava UMA linha de SigNfCor (uma ocorrencia de uma
1213:     * nota), equivalente a UM "Insert Into crSigNfCor" do Scan do Ok.Click do
1214:     * irmao. Toda a montagem de SQL fica no objeto de negocio (PILAR 3): aqui
1215:     * so se preenchem as propriedades da linha e se chama Salvar().
1216:     *
1217:     * NovoRegistro() e OBRIGATORIO antes de cada linha, por dois motivos:
1218:     * limpa a linha anterior (cidchaves/cnfis/noccors/mretifs) preservando o
1219:     * contexto da faixa, que e o que SIGOPCORBO.LimparDados faz de proposito;
1220:     * e liga this_lEmEdicao/this_lNovoRegistro, sem os quais Salvar() recusa
1221:     * com "Nao esta em modo de edicao" e NAO grava nada.
1222:     *
1223:     * A chave primaria (cidchaves) nao e preenchida aqui: NovoRegistro a limpa
1224:     * e SIGOPCORBO.Inserir a gera com fUniqueIds(), igual ao Insert legado.
1225:     *
1226:     * Falha NUNCA e muda: Salvar() de BusinessBase exibe a mensagem em todo
1227:     * caminho de recusa (ValidarDados/AntesDeGravar/Inserir/CATCH) e marca
1228:     * this_lErroExibido, entao este metodo nao repete a mensagem (regra
1229:     * CLAUDE.md #20) - so devolve .F. para o laco parar.
1230:     *--------------------------------------------------------------------------
1231:     PROTECTED PROCEDURE GravarOcorrencia(par_cNfis, par_nNoccors, par_cMretifs)
1232:         LOCAL loc_lSucesso, loc_oBO
1233:         loc_lSucesso = .F.
1234:         loc_oBO      = THIS.this_oBusinessObject
1235: 
1236:         IF VARTYPE(loc_oBO) = "O"
1237:             loc_oBO.NovoRegistro()
1238: 
1239:             *-- "ThisForm.Emp" / "ThisForm.Serie" do Insert legado
1240:             loc_oBO.this_cEmps    = THIS.this_cEmps
1241:             loc_oBO.this_cSeries  = THIS.this_cSeries
1242:             *-- "ThisForm.Get_NotaIni.Value" -> a nota da faixa
1243:             loc_oBO.this_cNfis    = IIF(VARTYPE(par_cNfis) = "C", par_cNfis, "")
1244:             *-- "XCorNf.Cods" / "XCorNf.Retifs"
1245:             loc_oBO.this_nNoccors = IIF(VARTYPE(par_nNoccors) = "N", par_nNoccors, 0)
1246:             loc_oBO.this_cMretifs = IIF(VARTYPE(par_cMretifs) = "C", par_cMretifs, "")
1247: 
1248:             loc_lSucesso = loc_oBO.Salvar()
1249:         ENDIF
1250: 
1251:         RETURN loc_lSucesso
1252:     ENDPROC
1253: 
1254:     *--------------------------------------------------------------------------
1255:     * GradeRetificacaoKeyPress - navegacao por registro dentro da grade,
1256:     * TRANSCRITA do SIGOPCOR.Grade.Column3.Edit1.KeyPress legado:
1257:     *
1258:     *   Case nKeyCode = 13 or nKeyCode = 24   && Enter / Ctrl+X: avanca
1259:     *       Select XCorNf / If Not Eof() / Skip / EndIf / Grade.Refresh
1260:     *   Case nKeyCode = 5                     && Ctrl+E: volta
1261:     *       Select XCorNf / If Not Bof() / Skip -1 / EndIf / Grade.Refresh
1262:     *   Case nKeyCode = 9                      && Tab: sai da grade
1263:     *       KeyBoard "{CTRL+TAB}"
1264:     *
1265:     * As guardas Eof()/Bof() do legado sao preservadas: elas impedem o Skip de
1266:     * passar do fim e o Skip -1 de passar do inicio do cursor.
1267:     *
1268:     * PUBLIC (nao PROTECTED) porque e alvo de vinculo de evento, que falha em
1269:     * silencio com metodo protegido.
1270:     *--------------------------------------------------------------------------
1271:     PROCEDURE GradeRetificacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1272:         LOCAL loc_oErro
1273: 
1274:         TRY
1275:             DO CASE
1276:                 CASE par_nKeyCode = 13 OR par_nKeyCode = 24
1277:                     IF USED("cursor_4c_Ocorrencias")
1278:                         SELECT cursor_4c_Ocorrencias
1279:                         IF !EOF("cursor_4c_Ocorrencias")
1280:                             SKIP IN cursor_4c_Ocorrencias
1281:                         ENDIF
1282:                         THIS.grd_4c_Dados.Refresh()
1283:                     ENDIF
1284: 
1285:                 CASE par_nKeyCode = 5
1286:                     IF USED("cursor_4c_Ocorrencias")
1287:                         SELECT cursor_4c_Ocorrencias
1288:                         IF !BOF("cursor_4c_Ocorrencias")
1289:                             SKIP -1 IN cursor_4c_Ocorrencias
1290:                         ENDIF
1291:                         THIS.grd_4c_Dados.Refresh()
1292:                     ENDIF
1293: 
1294:                 CASE par_nKeyCode = 9
1295:                     KEYBOARD "{CTRL+TAB}"
1296:             ENDCASE
1297:         CATCH TO loc_oErro
1298:             MsgErro(loc_oErro.Message + CHR(13) + ;
1299:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1300:                     "Procedure: " + loc_oErro.Procedure, ;
1301:                     "Erro em GradeRetificacaoKeyPress")
1302:         ENDTRY
1303:     ENDPROC
1304: 
1305:     *--------------------------------------------------------------------------
1306:     * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
1307:     * "Select XCorNf / Go Top / ThisForm.Grade.Refresh" do Init legado.
1308:     *
1309:     * Popular o cursor NAO repinta a grade: sem o GO TOP + Refresh explicitos
1310:     * a grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
1311:     * nao traz dados") manda o diagnostico para SQL/cursor/permissao. Por isso
1312:     * mora num metodo unico, chamado em TODO caminho que popula o cursor.
1313:     *--------------------------------------------------------------------------
1314:     PROCEDURE AtualizarGrade()
1315:         IF USED("cursor_4c_Ocorrencias")
1316:             SELECT cursor_4c_Ocorrencias
1317:             GO TOP IN cursor_4c_Ocorrencias
1318:         ENDIF
1319: 
1320:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1321:             THIS.grd_4c_Dados.Refresh()
1322:         ENDIF
1323:     ENDPROC
1324: 
1325:     *--------------------------------------------------------------------------
1326:     * CarregarLista - FUNIL de carga da unica lista deste form: a grade de
1327:     * ocorrencias da Carta de Correcao (SIGOPCOR.Grade, ligada ao cursor local
1328:     * XCorNf no legado). Nao ha duas paginas aqui - a "lista" desta tela e essa
1329:     * grade, e e ela que o Init legado popula com o Scan sobre CrSigCcOco:
1330:     *
1331:     *   ThisForm.poDataMgr.Requery('CrSigCcOco')
1332:     *   Select CrSigCcOco
1333:     *   Scan
1334:     *       Insert Into XCorNf (cods,descs,retifs)
1335:     *       Values (CrSigCcOco.ncodigos, CrSigCcOco.cdescrs, '')
1336:     *   EndScan
1337:     *   Select XCorNf / Go Top
1338:     *
1339:     * A retificacao entra em BRANCO de proposito: este form trata uma FAIXA de
1340:     * notas fiscais, e o legado requery CrSigNfCor com os filtros vazios (que
1341:     * nao casa nada) sem nenhum segundo Scan que pre-carregue texto gravado.
1342:     *
1343:     * ZAP em vez de USE IN + CREATE CURSOR: derrubar o alias quebraria
1344:     * RecordSource/ControlSource/CurrentControl da grade ja criada. Por isso
1345:     * CriarCursorOcorrencias() so roda aqui se o alias nao existir.
1346:     *
1347:     * PUBLIC (nao PROTECTED) de proposito: o harness de teste automatico chama
1348:     * este metodo de FORA da classe, e a checagem de existencia que ele faz
1349:     * antes nao verifica escopo - um metodo protegido passaria por ela e
1350:     * falharia em runtime.
1351:     *
1352:     * Retorno: .T. quando a grade ficou com pelo menos uma ocorrencia.
1353:     *--------------------------------------------------------------------------
1354:     PROCEDURE CarregarLista()
1355:         LOCAL loc_lSucesso, loc_oBO, loc_oErro
1356:         loc_lSucesso = .F.
1357:         loc_oBO      = THIS.this_oBusinessObject
1358: 
1359:         TRY

*-- Linhas 1368 a 1407:
1368:                 THIS.CriarCursorOcorrencias()
1369:             ENDIF
1370: 
1371:             SELECT cursor_4c_Ocorrencias
1372:             ZAP
1373: 
1374:             IF VARTYPE(loc_oBO) = "O"
1375:                 IF loc_oBO.CarregarOcorrencias() AND USED("cursor_4c_TiposOcorrencia")
1376:                     SELECT cursor_4c_TiposOcorrencia
1377:                     GO TOP
1378:                     SCAN
1379:                         INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) ;
1380:                              VALUES (cursor_4c_TiposOcorrencia.ncodigos, ;
1381:                                      cursor_4c_TiposOcorrencia.cdescrs, ;
1382:                                      "")
1383:                         *-- INSERT INTO seleciona a tabela de DESTINO: repor o
1384:                         *-- alias do Scan, igual ao "Select" que o legado faz
1385:                         SELECT cursor_4c_TiposOcorrencia
1386:                     ENDSCAN
1387: 
1388:                     loc_lSucesso = (RECCOUNT("cursor_4c_Ocorrencias") > 0)
1389:                 ENDIF
1390:             ENDIF
1391: 
1392:             *-- "Select XCorNf / Go Top / Grade.Refresh" do legado
1393:             THIS.AtualizarGrade()
1394:         CATCH TO loc_oErro
1395:             MsgErro(loc_oErro.Message + CHR(13) + ;
1396:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1397:                     "Procedure: " + loc_oErro.Procedure, ;
1398:                     "Erro em CarregarLista")
1399:         ENDTRY
1400: 
1401:         RETURN loc_lSucesso
1402:     ENDPROC
1403: 
1404:     *--------------------------------------------------------------------------
1405:     * FormParaBO - transferencia TELA -> OBJETO DE NEGOCIO. Reproduz o bloco de
1406:     * atribuicoes do PROCEDURE Init legado, que nao tem esse nome mas e
1407:     * exatamente isto:

*-- Linhas 1414 a 1432:
1414:     *
1415:     * mais a LINHA CORRENTE da grade, que e a ficha editavel desta tela: o
1416:     * Ok.Click do irmao SIGOPCCO le XCorNf.Cods/XCorNf.Retifs para montar cada
1417:     * "Insert Into crSigNfCor (... nOccors, mRetifs ...)".
1418:     *
1419:     * FONTE UNICA do espelho dos dois limites da faixa: ValidarFaixaNotas (Fase
1420:     * 6) tinha o mesmo bloco de atribuicao em duplicata e passou a chamar este
1421:     * metodo - duas copias do mesmo espelho divergiriam na primeira mudanca de
1422:     * regra. CarregarLista tambem chama, para que o objeto de negocio ja nasca
1423:     * com o contexto do form chamador antes da 1a carga da grade.
1424:     *
1425:     * O que este metodo NAO escreve e this_cNfis (a nota CONCRETA de uma linha
1426:     * de SigNfCor): esta tela trata uma FAIXA, e os dois limites nao sao uma
1427:     * nota - no legado eles entram como parametro do "cnfis between ?pcNFisDe
1428:     * And ?pcNFisAte", que e FILTRO. Quem resolve cada nota concreta e
1429:     * GravarRetificacoesDaFaixa, que chama GravarOcorrencia uma vez por nota e
1430:     * atribui this_cNfis ali. Semear this_cNfis aqui com o limite inicial faria
1431:     * BO.ValidarDados aprovar uma gravacao cuja nota ninguem resolveu.
1432:     *

*-- Linhas 1563 a 1581:
1563:                 ENDIF
1564: 
1565:                 IF loc_nNoccors > 0 AND USED("cursor_4c_Ocorrencias")
1566:                     SELECT cursor_4c_Ocorrencias
1567:                     LOCATE FOR cursor_4c_Ocorrencias.cods = loc_nNoccors
1568: 
1569:                     IF FOUND("cursor_4c_Ocorrencias")
1570:                         REPLACE retifs WITH loc_cMretifs IN cursor_4c_Ocorrencias
1571:                     ENDIF
1572:                 ENDIF
1573: 
1574:                 loc_lSucesso = .T.
1575:             ENDIF
1576:         CATCH TO loc_oErro
1577:             MsgErro(loc_oErro.Message + CHR(13) + ;
1578:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1579:                     "Procedure: " + loc_oErro.Procedure, ;
1580:                     "Erro em BOParaForm")
1581:         ENDTRY

*-- Linhas 1587 a 1614:
1587:     * LimparCampos - fonte unica da limpeza da tela: os dois limites da faixa
1588:     * voltam a branco e a coluna de retificacao da grade volta a vazia, que e
1589:     * EXATAMENTE o estado em que o Init legado deixa XCorNf - o terceiro valor
1590:     * do Insert abaixo e a cadeia vazia:
1591:     *
1592:     *     Insert Into XCorNf (cods,descs,retifs)
1593:     *     Values (CrSigCcOco.ncodigos, CrSigCcOco.cdescrs, <vazio>)
1594:     *
1595:     * REPLACE ALL, NUNCA ZAP: a grade desta tela e o CATALOGO de ocorrencias
1596:     * lido de SigCcOco - codigo e descricao nao sao dado digitado e nao se
1597:     * apagam. (O ZAP e o do irmao SIGOPCCO, cuja grade e o RESULTADO da
1598:     * consulta de UMA nota.) Derrubar o alias com USE IN + CREATE CURSOR seria
1599:     * pior ainda: quebraria RecordSource/ControlSource/CurrentControl da grade
1600:     * ja criada e a coluna de retificacao voltaria a desenhar o Text1 default.
1601:     *
1602:     * O objeto de negocio e limpo junto (SIGOPCORBO.LimparDados), senao a
1603:     * proxima gravacao herdaria cidchaves/cnfis/noccors/mretifs da anterior.
1604:     * LimparDados preserva de proposito o contexto da faixa
1605:     * (cemps/cseries/emissao) que veio do form chamador - ver o metodo no BO.
1606:     *
1607:     * Fecha com AtualizarGrade(): esvaziar o cursor NAO repinta a grade, e sem
1608:     * o GO TOP + Refresh a tela continuaria exibindo o texto que acabou de ser
1609:     * apagado (regra CLAUDE.md #21).
1610:     *
1611:     * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED
1612:     * (formbase.prg:276) e VFP9 nao permite ALARGAR o escopo de metodo
1613:     * herdado.
1614:     *--------------------------------------------------------------------------

*-- Linhas 1624 a 1642:
1624:         ENDIF
1625: 
1626:         IF USED("cursor_4c_Ocorrencias")
1627:             SELECT cursor_4c_Ocorrencias
1628:             REPLACE ALL retifs WITH "" IN cursor_4c_Ocorrencias
1629:         ENDIF
1630: 
1631:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1632:             THIS.this_oBusinessObject.LimparDados()
1633:         ENDIF
1634: 
1635:         *-- Reespelha a tela JA limpa: LimparDados zera a linha de SigNfCor
1636:         *-- (cidchaves/cnfis/noccors/mretifs) mas PRESERVA o contexto da
1637:         *-- faixa, entao sem esta chamada this_cNfisDe/this_cNfisAte ficariam
1638:         *-- com os limites que o usuario acabou de apagar - e a proxima
1639:         *-- gravacao usaria faixa fantasma. FormParaBO continua sendo a fonte
1640:         *-- unica do espelho, aqui como em ValidarFaixaNotas e CarregarLista.
1641:         THIS.FormParaBO()
1642: 


### BO (C:\4c\projeto\app\classes\SIGOPCORBO.prg):
*====================================================================
* SIGOPCORBO.prg
*
* Business Object de SIGOPCOR - Carta de Correcao de Nota Fiscal
* (inclusao da carta de correcao para uma FAIXA de notas fiscais de
*  uma mesma empresa e serie)
*
* Tabela principal : SigNfCor  - chave primaria cidchaves
* Tabelas de apoio : SigCcOco  - tipos de ocorrencia da correcao
*                    SigCdEmp  - razao social da empresa
*                    SigMvNfi  - flag correcs da nota fiscal
*
* Origem legado : SIGOPCOR.SCX
*                 tasks\task707\SIGOPCOR_form_codigo_fonte.txt
* Chamado por   : SIGCDCNF, botao InserirCarta da pagina Lista
*                 Do Form SigOpCor With ThisForm, pcemps, lcSerie,
*                                      ldEmisDe, ldEmisAte
*
* Cursores do legado espelhados pelas propriedades abaixo:
*   CrSigNfCor  Select * From SigNfCor
*               Where cemps = ?pcEmps And cseries = ?pcSeries
*                 And cnfis between ?pcNFisDe And ?pcNFisAte
*               Order By cemps, cseries, cnfis, noccors
*   CrSigCcOco  AddCursor('SigCcOco','ncodigos','CrSigCcOco','','')
*               tabela inteira, sem filtro, ordenada por ncodigos
*   CrSigCdEmp  Select * From SigCdEmp Where cemps = ?pcEmps
*   XCorNf      Create Cursor XCorNf (cods n(3), descs c(30), retifs m NULL)
*               grade da tela - uma linha por ocorrencia de SigCcOco
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGOPCORBO AS BusinessBase

    *----------------------------------------------------------------
    * Colunas de SigNfCor (entidade gravada pela tela)
    * Tipos conferidos em docs/schema.sql
    *----------------------------------------------------------------
    this_cCidchaves = ""    && cidchaves char(20) NOT NULL - PK Fortyus (fUniqueIds)
    this_cEmps      = ""    && cemps     char(3)  NOT NULL - empresa
    this_cSeries    = ""    && cseries   char(3)  NOT NULL - serie da nota fiscal
    this_cNfis      = ""    && cnfis     char(6)  NOT NULL - numero da nota fiscal
    this_nNoccors   = 0     && noccors   numeric(3,0) NOT NULL - ocorrencia (FK SigCcOco.ncodigos)
    this_cMretifs   = ""    && mretifs   text NULL - texto da retificacao digitado na grade

    *----------------------------------------------------------------
    * Faixa de notas fiscais informada na tela
    * Get_NotaIni / Get_NotaFim, fwget MaxLength = 6, mesma largura de
    * SigNfCor.cnfis char(6). Alimentam o "cnfis between ?pcNFisDe And
    * ?pcNFisAte" do cursor CrSigNfCor do legado.
    * Sao CHARACTER: o Ok.Click do form irmao SIGOPCCO faz
    * Padr(ThisForm.Get_NotaIni.Value, 6), que exige valor character.
    *----------------------------------------------------------------
    this_cNfisDe    = ""    && pcNFisDe - primeira nota da faixa
    this_cNfisAte   = ""    && pcNFisAte - ultima nota da faixa

    *----------------------------------------------------------------
    * Contexto recebido do form chamador (SIGCDCNF)
    * ThisForm.EmisDe / ThisForm.EmisAte guardam DtIni.Value e
    * DtFim.Value do container de filtros do SIGCDCNF, portanto DATE.
    * O legado nao os usa em consulta nenhuma desta tela: eles sao
    * repassados adiante para o relatorio SigReImc, igual ao que o
    * form irmao SIGOPCCO faz no fim do Ok.Click.
    *----------------------------------------------------------------
    this_dEmisDe    = {}    && data de emissao inicial do filtro de origem
    this_dEmisAte   = {}    && data de emissao final do filtro de origem

    *----------------------------------------------------------------
    * Apoio: SigCdEmp (cursor CrSigCdEmp do legado)
    * Colunas canonicas de SigCdEmp sao cemps e razas - nunca Cemps/Razas
    *----------------------------------------------------------------
    this_cRazas     = ""    && SigCdEmp.razas char(40) - razao social da empresa

    *----------------------------------------------------------------
    * Apoio: SigCcOco (cursor CrSigCcOco do legado)
    * Linha corrente da lista de ocorrencias que monta a grade XCorNf
    * (XCorNf.cods recebe ncodigos e XCorNf.descs recebe cdescrs)
    *----------------------------------------------------------------
    this_nNcodigos  = 0     && SigCcOco.ncodigos numeric(3,0) - codigo da ocorrencia
    this_cCdescrs   = ""    && SigCcOco.cdescrs  char(30) - descricao da ocorrencia

    *----------------------------------------------------------------
    * Resultado da gravacao em lote da carta de correcao: fica .T.
    * quando pelo menos uma linha da grade tinha retificacao digitada
    * (equivale ao buffer crSigNfCor nao vazio do Ok.Click legado) e
    * decide o valor gravado em SigMvNfi.correcs (coluna bit).
    * E estado de SESSAO: tem de ser reposto em cada gravacao, porque
    * o form migrado nao fecha entre uma nota e a seguinte.
    *----------------------------------------------------------------
    this_lTemCorrecoesGravadas = .F.

    *====================================================================
    * Init - define tabela e campo chave da entidade
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigNfCor"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - valor da PK usado pelo RegistrarAuditoria
    * de BusinessBase (chamado em Inserir/Atualizar/ExecutarExclusao)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * LimparDados - zera as propriedades do REGISTRO antes de uma nova
    * inclusao. BusinessBase.LimparDados so limpa this_cMensagemErro, as
    * propriedades da entidade sao responsabilidade da subclasse.
    *
    * O contexto da TELA (this_cEmps, this_cSeries, this_cNfisDe,
    * this_cNfisAte, this_dEmisDe, this_dEmisAte, this_cRazas) e
    * preservado de proposito: ele vem do form chamador e vale para a
    * faixa inteira de notas, nao para um registro so.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves = ""
        THIS.this_cNfis      = ""
        THIS.this_nNoccors   = 0
        THIS.this_cMretifs   = ""
        THIS.this_nNcodigos  = 0
        THIS.this_cCdescrs   = ""

        THIS.this_lTemCorrecoesGravadas = .F.

        RETURN .T.
    ENDPROC


    *====================================================================
    * CarregarOcorrencias - popula cursor_4c_TiposOcorrencia com a LISTA
    * COMPLETA de tipos de ocorrencia da carta de correcao (SigCcOco).
    *
    * Equivalente ao cursor CrSigCcOco do legado, criado SEM query e SEM
    * filtro, ordenado pela chave:
    *   .AddCursor('SigCcOco','ncodigos','CrSigCcOco','','')
    *   ThisForm.poDataMgr.Requery('CrSigCcOco')
    *
    * E a fonte da grade da tela: o Scan unico do Init legado percorre
    * este cursor e insere uma linha em XCorNf por ocorrencia, com a
    * retificacao em BRANCO (Insert Into XCorNf (cods,descs,retifs)
    * Values (CrSigCcOco.ncodigos, CrSigCcOco.cdescrs, '')).
    *
    * Diferente do form irmao SIGOPCCO, esta tela NAO casa retificacoes
    * ja gravadas com as linhas da grade: o legado requery CrSigNfCor com
    * os filtros vazios (pcEmps/pcSeries/pcNFisDe/pcNFisAte), que nao
    * casa nada de proposito, e nao tem um segundo Scan. E coerente com a
    * natureza da tela: a correcao vale para uma FAIXA de notas, logo nao
    * ha texto de uma nota especifica para pre-carregar.
    *
    * Colunas conferidas em docs/schema.sql: SigCcOco tem exatamente
    * ncodigos numeric(3,0) NOT NULL (PK) e cdescrs char(30) NOT NULL.
    *
    * Sem conexao viva (harness headless / validacao de UI, onde
    * gnConnHandle fica -1) o metodo devolve .F. em silencio: SQLEXEC com
    * handle invalido dispara excecao, e o dialogo de erro travaria a
    * execucao sem supervisao.
    *====================================================================
    PROCEDURE CarregarOcorrencias()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT ncodigos, cdescrs" + ;
                           "  FROM SigCcOco" + ;
                           " ORDER BY ncodigos"

                IF USED("cursor_4c_TiposOcorrencia")
                    IF CURSORGETPROP("Buffering", "cursor_4c_TiposOcorrencia") > 1
                        TABLEREVERT(.T., "cursor_4c_TiposOcorrencia")
                    ENDIF
                    USE IN cursor_4c_TiposOcorrencia
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOcorrencia")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MostrarErro("Erro ao carregar as ocorr" + CHR(234) + "ncias da Carta de Corre" + ;
                                CHR(231) + CHR(227) + "o:" + CHR(13) + THIS.this_cMensagemErro, ;
                                "Erro SQL")
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "SIGOPCORBO.CarregarOcorrencias")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *====================================================================
    * CarregarDoCursor - mapeia as 6 colunas de SigNfCor para as
    * propriedades this_* do BO (equivale a leitura do cursor CrSigNfCor
    * do legado, criado por
    *   .AddCursor('SigNfCor','cidchaves','CrSigNfCor','','',lcQryCorNf)
    * com lcQryCorNf = Select * From SigNfCor Where cemps = ?pcEmps And
    * cseries = ?pcSeries And cnfis between ?pcNFisDe And ?pcNFisAte).
    *
    * Colunas conferidas em docs/schema.sql - SigNfCor tem exatamente
    * estas seis: cemps char(3), cseries char(3), cnfis char(6),
    * noccors numeric(3,0), mretifs text NULL, cidchaves char(20) PK.
    *
    * TratarNulo(valor, PADRAO): o 2o argumento e o VALOR de fallback
    * usado quando a coluna vem NULL - NAO o tipo. Por isso "" para
    * char/text e 0 para numeric. mretifs e a UNICA coluna NULL do
    * schema, logo o caso NULL e real e nao teorico.
    *
    * SELECT (par_cAliasCursor) antes de ler os campos: VFP nao aceita a
    * forma campo.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_cEmps      = TratarNulo(cemps,     "")
                THIS.this_cSeries    = TratarNulo(cseries,   "")
                THIS.this_cNfis      = TratarNulo(cnfis,     "")
                THIS.this_nNoccors   = TratarNulo(noccors,   0)
                THIS.this_cMretifs   = TratarNulo(mretifs,   "")

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor [" + ;
                    IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "") + ;
                    "] n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - guarda chamada por BusinessBase.Salvar() antes de
    * Inserir()/Atualizar().
    *
    * O dump de SIGOPCOR.SCX traz codigo para apenas cinco metodos (Load,
    * Init, o When das colunas 1 e 2 da grade e o KeyPress do Edit1 da
    * coluna 3) - o Ok.Click do CommandGroup Sair chegou VAZIO no acervo
    * (conferido tambem no .sct, que so guarda esses cinco). A guarda
    * transcrita aqui e a do Ok.Click do form IRMAO SIGOPCCO, que grava a
    * MESMA tabela (SigNfCor) a partir da MESMA grade (XCorNf):
    *     If Not IsEmpty(ThisForm.Get_NotaIni.Value)
    *         ...
    *     Else
    *         MessageBox('Nota Fiscal Invalida !!',0+48,'')
    *     EndIf
    * Mensagem reproduzida LITERALMENTE, com o acento em CHR(225).
    *
    * Nenhuma outra coluna e criticada, de proposito: cemps, cseries e
    * noccors chegam do form chamador (SIGCDCNF) e o legado nunca os
    * valida. Sao NOT NULL, mas NOT NULL aceita branco/zero - exigir
    * conteudo seria inventar restricao que o legado nao tem.
    *
    * Preenche this_cMensagemErro e devolve .F.: quem EXIBE e o
    * ExibirFalha() de BusinessBase, para a mensagem nao sair duas vezes.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF VARTYPE(THIS.this_cNfis) != "C" OR EMPTY(ALLTRIM(THIS.this_cNfis))
            THIS.this_cMensagemErro = "Nota Fiscal Inv" + CHR(225) + "lida !!"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - grava UMA ocorrencia de Carta de Correcao em SigNfCor.
    *
    * Transcreve o Insert do Ok.Click do form irmao SIGOPCCO (mesma
    * tabela, mesma grade):
    *     Insert Into crSigNfCor (cEmps, cSeries, cNfis, nOccors,
    *                             mRetifs, cIdChaves) ;
    *                     Values (ThisForm.Emp, ThisForm.Serie,
    *                             ThisForm.Get_NotaIni.Value,
    *                             XCorNf.Cods, XCorNf.Retifs, fUniqueIds())
    *
    * As SEIS colunas de SigNfCor entram no INSERT - as CINCO NOT NULL
    * (cemps, cseries, cnfis, noccors, cidchaves) mais mretifs, que e a
    * carga util da tela. A tabela nao tem DEFAULT em coluna nenhuma
    * (conferido em docs/schema.sql), portanto omitir qualquer NOT NULL
    * faria o SQL Server recusar o INSERT inteiro.
    *
    * cidchaves vem de fUniqueIds() - cCodEmpresa(3) + RIGHT(SYS(2015),9)
    * + 8 digitos = exatamente os char(20) da coluna. NUNCA string vazia:
    * a PK e unica e o 2o registro colidiria no indice signfcor_cidchaves.
    *
    * PADR nas larguras do schema reproduz o Padr(...,3)/Padr(...,6) que o
    * Ok.Click legado aplica nas mesmas tres colunas, e evita o
    * "String or binary data would be truncated" quando o valor chega
    * maior que a coluna. mretifs e text: leva ALLTRIM, nunca PADR.
    *====================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cChave, loc_cEmps, loc_cSeries, loc_cNfis, loc_cMretifs
        loc_lSucesso = .F.

        TRY
            *-- EMPTY(.NULL.) devolve .F. no VFP9, por isso o teste de
            *-- VARTYPE vem ANTES: sem ele uma PK nula escaparia da geracao
            *-- e estouraria no ALLTRIM logo abaixo
            IF VARTYPE(THIS.this_cCidchaves) != "C" OR EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            loc_cChave   = LEFT(ALLTRIM(THIS.this_cCidchaves), 20)
            loc_cEmps    = PADR(ALLTRIM(THIS.this_cEmps),   3)
            loc_cSeries  = PADR(ALLTRIM(THIS.this_cSeries), 3)
            loc_cNfis    = PADR(ALLTRIM(THIS.this_cNfis),   6)
            loc_cMretifs = IIF(VARTYPE(THIS.this_cMretifs) = "C", ALLTRIM(THIS.this_cMretifs), "")

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigNfCor
                       (cemps, cseries, cnfis, noccors, mretifs, cidchaves)
                VALUES (
                    <<EscaparSQL(loc_cEmps)>>,
                    <<EscaparSQL(loc_cSeries)>>,
                    <<EscaparSQL(loc_cNfis)>>,
                    <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                    <<EscaparSQL(loc_cMretifs)>>,
                    <<EscaparSQL(loc_cChave)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao incluir a Carta de Corre" + CHR(231) + CHR(227) + "o:" + ;
                            CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - altera uma ocorrencia de Carta de Correcao ja gravada.
    *
    * Equivale ao ramo "a ocorrencia ja existe" do Ok.Click do form irmao
    * SIGOPCCO, que reaproveita a linha em vez de incluir outra:
    *     Locate For crSigNfCor.nOccors = XCorNf.Cods
    *     If Eof([crSigNfCor])
    *         Insert Into crSigNfCor (...)
    *     Else
    *         Replace mRetifs With XCorNf.Retifs In crSigNfCor
    *     EndIf
    *
    * O UPDATE leva as cinco colunas de dados e filtra pela PK cidchaves
    * (this_cCampoChave definido no Init). Sem PK no objeto o WHERE ficaria
    * aberto, entao a operacao e recusada com mensagem - BusinessBase.
    * Salvar() a exibe pelo ExibirFalha().
    *====================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cChave, loc_cEmps, loc_cSeries, loc_cNfis, loc_cMretifs
        loc_lSucesso = .F.

        TRY
            loc_cChave = IIF(VARTYPE(THIS.this_cCidchaves) = "C", ALLTRIM(THIS.this_cCidchaves), "")

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Carta de Corre" + CHR(231) + CHR(227) + ;
                    "o sem chave (cidchaves) - altera" + CHR(231) + CHR(227) + "o n" + ;
                    CHR(227) + "o realizada."
            ELSE
                loc_cEmps    = PADR(ALLTRIM(THIS.this_cEmps),   3)
                loc_cSeries  = PADR(ALLTRIM(THIS.this_cSeries), 3)
                loc_cNfis    = PADR(ALLTRIM(THIS.this_cNfis),   6)
                loc_cMretifs = IIF(VARTYPE(THIS.this_cMretifs) = "C", ALLTRIM(THIS.this_cMretifs), "")

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    UPDATE SigNfCor
                       SET cemps   = <<EscaparSQL(loc_cEmps)>>,
                           cseries = <<EscaparSQL(loc_cSeries)>>,
                           cnfis   = <<EscaparSQL(loc_cNfis)>>,
                           noccors = <<FormatarNumeroSQL(THIS.this_nNoccors, 0)>>,
                           mretifs = <<EscaparSQL(loc_cMretifs)>>
                     WHERE cidchaves = <<EscaparSQL(LEFT(loc_cChave, 20))>>
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MostrarErro("Erro ao alterar a Carta de Corre" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - apaga uma ocorrencia de Carta de Correcao.
    *
    * PROTECTED de proposito: de fora o form chama sempre Excluir(), que e
    * o metodo PUBLIC de BusinessBase e dispara AntesDeExcluir/
    * DepoisDeExcluir/LimparDados em volta desta exclusao.
    *
    * Equivale ao Delete do Ok.Click do form irmao SIGOPCCO, que limpa as
    * retificacoes da nota antes de regravar a carta:
    *     Delete From SigNfCor Where CEmps = '<emp>' And
    *                                CSeries = '<serie>' And CNfis = '<nf>'
    * Aqui o filtro e a PK cidchaves (this_cCampoChave), para apagar
    * exatamente a ocorrencia carregada e nenhuma outra. Sem PK no objeto a
    * exclusao e recusada com mensagem, que Excluir() exibe pelo
    * ExibirFalha() - um WHERE aberto apagaria a tabela inteira.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cChave = IIF(VARTYPE(THIS.this_cCidchaves) = "C", ALLTRIM(THIS.this_cCidchaves), "")

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Carta de Corre" + CHR(231) + CHR(227) + ;
                    "o sem chave (cidchaves) - exclus" + CHR(227) + "o n" + CHR(227) + "o realizada."
            ELSE
                loc_cSQL = "DELETE FROM SigNfCor" + ;
                           " WHERE cidchaves = " + EscaparSQL(LEFT(loc_cChave, 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    *-- Auditoria ANTES de perder a chave: BusinessBase.
                    *-- Excluir() chama LimparDados() depois deste metodo
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MostrarErro("Erro ao excluir a Carta de Corre" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SIGOPCORBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

