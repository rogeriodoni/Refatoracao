# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NDOPES, CODIGOS

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
  Column1.ControlSource = ""
  ControlSource = "tmpoperacao.CODIGOS"
Select BarBonus
	.Column1.ControlSource = 'BarBonus.Codigos'
	.Column2.ControlSource = 'BarBonus.Valors'
Select BarBonus
	lcSql = [Select Dopes From SigCdOpe Where ndopes = ]+Str(nDope)
	ThisForm.PodataMgr.Sqlexecute(lcSql,'LocalSnOpe')
	Select BarBonus
	Select Sum(1) as Qt, Codigos From BarBonus ;
	Select BarBonus
		Insert Into BarBonus( Codigos ) Values ( 0 )
Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPPGC.prg) - TRECHOS RELEVANTES PARA PASS SQL (2088 linhas total):

*-- Linhas 48 a 67:
48: * fica vazio de proposito, ver cabecalho de SIGOPPGCBO.prg) eh criado por
49: * este proprio form, no mesmo padrao de GarantirCursorGrade de
50: * Formsigoppei.prg - entra na Fase 4/8, junto com a grade que o consome
51: * (ColumnCount -> RecordSource -> ControlSource, regra CLAUDE.md #41 -
52: * Column.ControlSource de cursor que ainda nao existe derruba o Init).
53: *
54: * Esta tela NAO eh acessada pelo menu principal (nenhum "Abrir*" em
55: * menu.prg) - eh sempre aberta por um form pai de pagamento que ja mantem
56: * o cursor crSigOpFp e o saldo a distribuir, exatamente como Formsigopped.prg
57: * (tambem sem entrada propria no menu). A carga sob demanda
58: * (start\indice_classes.txt) resolve a dependencia de SIGOPPGCBO.prg
59: * automaticamente quando o form pai instanciar esta classe - nao requer
60: * SET PROCEDURE manual em config.prg (regra CLAUDE.md "Carga SOB DEMANDA").
61: *
62: * Caption/acentos sempre por CHR() - nunca literal acentuado em .PRG.
63: *
64: * Herda de: FormBase          BO associado: SIGOPPGCBO
65: * Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
66: *
67: * Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).

*-- Linhas 189 a 207:
189: 
190:     *==========================================================================
191:     * this_cCursorGrade - nome do alias que a grade consome ("BarBonus" no
192:     * legado: "Select BarBonus / Zap / Append Blank" e ".RecordSource =
193:     * 'BarBonus'" no Init). Fonte UNICA do nome, compartilhada por
194:     * GarantirCursorGrade, VincularGrade e CarregarDados - sem isso o alias
195:     * diverge entre as fases seguintes (que ainda vao mexer no mesmo cursor
196:     * no Valid/LostFocus da celula e nos handlers de Ok/Cancela).
197:     *
198:     * O alias eh do form CHAMADOR quando a tela eh aberta pelo pai (o Init
199:     * faz SET DATASESSION TO a sessao dele, entao BarBonus ja esta aberto);
200:     * GarantirCursorGrade so o cria quando ele NAO existe - caso do harness
201:     * de teste e da validacao de UI, que instanciam o form sem chamador.
202:     *==========================================================================
203:     this_cCursorGrade = "BarBonus"
204: 
205:     *==========================================================================
206:     * this_cCursorFormaPagto - nome do alias da forma de pagamento CORRENTE no
207:     * form pai ("crSigOpFp" no legado: "AllTrim(crSigOpFp.fpags)" no Init e

*-- Linhas 230 a 248:
230:     * como os outros residuos): eh ela que distingue linha NOVA de CORRECAO de
231:     * uma linha ja digitada, que eh a escolha entre
232:     * SIGOPPGCBO.Inserir()/Atualizar() e, por consequencia, o rotulo
233:     * "INSERT"/"UPDATE" que o BO grava em LogAuditoria
234:     * ("RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, ...))"). Sem ela toda
235:     * barra digitada seria auditada com o mesmo rotulo.
236:     *
237:     * NUMERICA (nao CHARACTER como o "_" do legado sugere): a coluna
238:     * BarBonus.Codigos eh N(10,0) e o legado compara com numero ("If
239:     * This.Value > 0", "Where Codigos = This.Value").
240:     *==========================================================================
241:     this_nCodigoBarraAnterior = 0
242: 
243:     *==========================================================================
244:     * Init - replica "LParameters poForm, pnDataSes, poValor, pConexao" do
245:     * legado. Todos os 4 parametros sao OPCIONAIS: o harness de teste e a
246:     * validacao de UI instanciam o form sem parametro nenhum
247:     * (CREATEOBJECT("FormSIGOPPGC")). par_oConexaoLegado (equivale a
248:     * "pConexao"/"Podatamgr" do legado) eh aceito so por compatibilidade de

*-- Linhas 314 a 340:
314: 
315:                 THIS.TornarControlesVisiveis(THIS)
316: 
317:                 *-- "Select BarBonus / Zap / Append Blank" do Init legado -
318:                 *-- deixa o cursor com UMA linha em branco, pronta para a 1a
319:                 *-- barra. Roda ANTES de CarregarDados (que faz o bind e o
320:                 *-- Refresh), na mesma ordem do legado.
321:                 THIS.PrepararLinhaInicial()
322: 
323:                 *-- Funil de carga da grade - equivale ao bloco final do Init
324:                 *-- legado ("With Thisform.Grade / .RecordSource = 'BarBonus'
325:                 *-- / .Column1.ControlSource ... / .Refresh / EndWith /
326:                 *-- ThisForm.Grade.Refresh"). Chamado DEPOIS de
327:                 *-- TornarControlesVisiveis: Refresh em controle ainda
328:                 *-- invisivel nao pinta (regra CLAUDE.md #21/#46). O retorno
329:                 *-- NAO condiciona loc_lSucesso - sem o cursor do chamador
330:                 *-- (harness/validacao de UI) o bind eh pulado e a tela abre
331:                 *-- do mesmo jeito.
332:                 THIS.CarregarDados()
333: 
334:                 loc_lSucesso = .T.
335:             ENDIF
336:         CATCH TO loc_oErro
337:             MsgErro(loc_oErro.Message + CHR(13) + ;
338:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
339:                 "Procedure: " + loc_oErro.Procedure, ;
340:                 "Erro em InicializarForm")

*-- Linhas 479 a 512:
479:     * ConfigurarGrade - a grade de 2 colunas (Barra/Valor), transcrita do
480:     * dump ("PROPRIEDADES DE: SIGOPPGC.Grade"): Top=117, Left=156, Width=188,
481:     * Height=236, ColumnCount=2, FontName="Tahoma", FontSize=8,
482:     * HeaderHeight=16, RowHeight=16, DeleteMark=.F., TabIndex=14. ZOrderSet
483:     * NAO eh transcrito (regra #33 - bookkeeping do Form Designer, sem
484:     * equivalente em runtime).
485:     *
486:     * Classe no legado: fwgrade (ClassLoc ..\framework\framework.vcx) - o que
487:     * o SCX nao sobrepoe vem da classe (docs\FRAMEWORK_class_codigo_fonte.txt,
488:     * secao "PROPRIEDADES DE: fwgrade"): AllowHeaderSizing=.F.,
489:     * AllowRowSizing=.F., ScrollBars=2, GridLineColor=238,238,238,
490:     * HighlightBackColor=90,90,90. RecordMark=.F. tambem por ser form
491:     * OPERACIONAL (regra generica do projeto).
492:     *
493:     * ColumnCount/RecordSource/ControlSource das colunas NAO ficam aqui:
494:     * ficam em VincularGrade, alcancado pelo funil CarregarDados (Problema
495:     * 48/regra #41), porque atribuir ColumnCount RECRIA os objetos Column e
496:     * porque o cursor BarBonus (GarantirCursorGrade, chamado dentro de
497:     * VincularGrade) tem de existir ANTES do ControlSource apontar para ele.
498:     * Este metodo guarda so o que NAO depende de dado - geometria, fonte,
499:     * cores e marcadores da grade - e por isso roda uma unica vez, na
500:     * montagem, enquanto o funil eh reexecutado a cada recarga.
501:     *==========================================================================
502:     PROTECTED PROCEDURE ConfigurarGrade()
503:         LOCAL loc_oErro
504: 
505:         TRY
506:             THIS.AddObject("grd_4c_Dados", "Grid")
507:             WITH THIS.grd_4c_Dados
508:                 .Top                = 117
509:                 .Left               = 156
510:                 .Width              = 188
511:                 .Height             = 236
512:                 .TabIndex           = 14

*-- Linhas 518 a 536:
518:                 .AllowHeaderSizing  = .F.
519:                 .AllowRowSizing     = .F.
520:                 .RecordMark         = .F.
521:                 .DeleteMark         = .F.
522:                 .GridLineColor      = RGB(238, 238, 238)
523:                 .HighlightBackColor = RGB(90, 90, 90)
524:                 .Visible            = .T.
525:             ENDWITH
526:         CATCH TO loc_oErro
527:             MsgErro(loc_oErro.Message + CHR(13) + ;
528:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
529:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.ConfigurarGrade")
530:         ENDTRY
531:     ENDPROC
532: 
533:     *==========================================================================
534:     * ConfigurarMolduraFormaPagto - o bloco superior do dump, entre o
535:     * cabecalho e os botoes: a moldura decorativa (Shape1) e o rotulo da
536:     * forma de pagamento (Label1). Transcritos das secoes "PROPRIEDADES DE:

*-- Linhas 779 a 797:
779:     * sem exibir nada - mesma guarda por USED() de VincularGrade/
780:     * CarregarDados.
781:     *
782:     * CarregarDoCursor faz SELECT no alias que recebe, entao a area de
783:     * trabalho corrente eh salva e restaurada aqui: quem chama depois
784:     * (CarregarDados) conta com o alias da grade posicionado por ele mesmo,
785:     * e deixar a area trocada eh fonte classica de leitura na tabela errada.
786:     *
787:     * RETURN unico e FORA do TRY/CATCH, por flag (regra CLAUDE.md #1).
788:     *==========================================================================
789:     PROTECTED FUNCTION AplicarRotuloFormaPagto()
790:         LOCAL loc_lSucesso, loc_cAliasAnterior, loc_oErro
791:         loc_lSucesso = .F.
792: 
793:         TRY
794:             loc_cAliasAnterior = ALIAS()
795: 
796:             IF USED(THIS.this_cCursorFormaPagto) AND ;
797:                VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 804 a 886:
804:             ENDIF
805: 
806:             IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
807:                 SELECT (loc_cAliasAnterior)
808:             ENDIF
809:         CATCH TO loc_oErro
810:             MsgErro(loc_oErro.Message + CHR(13) + ;
811:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
812:                 "Procedure: " + loc_oErro.Procedure, ;
813:                 "Erro em FormSIGOPPGC.AplicarRotuloFormaPagto")
814:         ENDTRY
815: 
816:         RETURN loc_lSucesso
817:     ENDFUNC
818: 
819:     *==========================================================================
820:     * GarantirCursorGrade - garante que o cursor LOCAL BarBonus existe antes
821:     * de qualquer Column.ControlSource apontar para ele (regra CLAUDE.md #41
822:     * - sem isto a tela NAO ABRE: Alias nao encontrado dentro do TRY de
823:     * InicializarForm, que devolve .F., e o usuario clica no menu/form pai e
824:     * nada acontece).
825:     *
826:     * Estrutura: Codigos N(10,0) - This.Value do legado eh comparado/somado
827:     * como numerico ("If This.Value > 0", "Where Codigos = This.Value",
828:     * "Insert Into BarBonus(Codigos) Values(0)"), e o Column1.InputMask do
829:     * dump ("9999999999", 10 noves) confirma largura 10 sem decimais;
830:     * Valors N(14,2) - recebe CrSigOpFp.VlrFpgs (valor monetario por barra),
831:     * mesmo padrao de coluna de valor do projeto.
832:     *
833:     * So CREATE CURSOR (sem Zap/Append Blank): o "Select BarBonus / Zap /
834:     * Append Blank" do Init legado eh orquestracao de ABERTURA de tela (um
835:     * registro em branco pronto para o usuario digitar a 1a barra) e mora em
836:     * PrepararLinhaInicial - aqui so garante que o ALIAS existe, vazio, para
837:     * a grade ter onde ligar.
838:     *
839:     * Os dois andam em sequencia (PrepararLinhaInicial chama este primeiro) e
840:     * este eh idempotente: com o alias ja aberto pelo chamador nao faz nada,
841:     * preservando a estrutura de 3 colunas que o SIGOPPAG cria. Sem chamador
842:     * (harness de teste, validacao de UI) eh ele que abre o cursor de 2
843:     * colunas que esta tela usa.
844:     *==========================================================================
845:     PROTECTED PROCEDURE GarantirCursorGrade()
846:         LOCAL loc_oErro
847: 
848:         TRY
849:             IF !USED(THIS.this_cCursorGrade)
850:                 CREATE CURSOR BarBonus (Codigos N(10, 0), Valors N(14, 2))
851:             ENDIF
852:         CATCH TO loc_oErro
853:             MsgErro(loc_oErro.Message + CHR(13) + ;
854:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
855:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.GarantirCursorGrade")
856:         ENDTRY
857:     ENDPROC
858: 
859:     *==========================================================================
860:     * VincularGrade - liga grd_4c_Dados ao cursor BarBonus e configura as 2
861:     * colunas. NAO eh chamado direto: quem o alcanca eh o funil
862:     * CarregarDados, tanto na montagem quanto em cada recarga das fases
863:     * seguintes (mesmo funil unico de Formsigoppei.prg, Problema 48).
864:     *
865:     * ORDEM obrigatoria: ColumnCount -> RecordSource -> ControlSource -> o
866:     * resto (Width/InputMask/Header1.Caption por ultimo dentro do bloco da
867:     * coluna, pois RecordSource/ControlSource recalculam largura e caption
868:     * para o default). Grid.ReadOnly vem ANTES das colunas (regra #18 - o do
869:     * grid propaga e sobrescreveria).
870:     *
871:     * RecordSource e ControlSource sao condicionados a USED(alias): quando a
872:     * tela eh instanciada SEM chamador (harness de teste, validacao de UI) e
873:     * GarantirCursorGrade nao conseguiu abrir o cursor, o bind eh pulado em
874:     * vez de estourar "Alias is not found" dentro do TRY de InicializarForm -
875:     * que devolveria .F. e faria a tela nao abrir (regra #41). Largura,
876:     * fonte, mascara e caption de cabecalho sao aplicados SEMPRE, inclusive
877:     * nesse caminho, senao a grade ficaria com "Column1"/largura default.
878:     *
879:     * Column1 "Barra" <- BarBonus.Codigos: editavel (eh a celula que o
880:     * usuario digita - Grade.Column1.Text1.When/Valid/LostFocus do legado).
881:     * Width=80 e InputMask="9999999999" transcritos do dump
882:     * (Column1.Width/Column1.InputMask).
883:     *
884:     * Column2 "Valor" <- BarBonus.Valors: o dump NAO declara ReadOnly aqui -
885:     * quem bloqueia a digitacao eh "Grade.Column2.Text1.When / Return .f."
886:     * (a celula nunca recebe foco; o valor so eh gravado por codigo, no

*-- Linhas 901 a 964:
901:     * chamado no FIM deste metodo porque atribuir RecordSource DERRUBA o
902:     * CurrentControl das colunas.
903:     *
904:     * ControlSource vai para BarBonus.Codigos/BarBonus.Valors - o
905:     * "Column1.Text1.ControlSource = tmpoperacao.CODIGOS" do dump eh residuo
906:     * de template (mesma familia de "antvalue"/"gravadados", ver cabecalho da
907:     * classe) e eh SOBRESCRITO em runtime pelo Init legado ("With
908:     * Thisform.Grade / .Column1.ControlSource = 'BarBonus.Codigos' /
909:     * .Column2.ControlSource = 'BarBonus.Valors'") - essa eh a ligacao real,
910:     * transcrita aqui direto (nao ha motivo para esperar a Fase 7 so para
911:     * trocar o residuo pelo valor que o proprio legado atribui).
912:     *==========================================================================
913:     PROTECTED PROCEDURE VincularGrade()
914:         LOCAL loc_oGrid, loc_oErro
915: 
916:         TRY
917:             THIS.GarantirCursorGrade()
918: 
919:             loc_oGrid = THIS.grd_4c_Dados
920: 
921:             WITH loc_oGrid
922:                 .ReadOnly    = .F.
923:                 .ColumnCount = 2
924: 
925:                 IF USED(THIS.this_cCursorGrade)
926:                     .RecordSource = THIS.this_cCursorGrade
927:                 ENDIF
928: 
929:                 WITH .Column1
930:                     IF USED(THIS.this_cCursorGrade)
931:                         .ControlSource = "BarBonus.Codigos"
932:                     ENDIF
933:                     .FontName      = "Tahoma"
934:                     .FontSize      = 8
935:                     .Movable       = .F.
936:                     .Resizable     = .F.
937:                     .InputMask     = "9999999999"
938:                     .Width         = 80
939:                     WITH .Header1
940:                         .FontName  = "Tahoma"
941:                         .FontSize  = 8
942:                         .Alignment = 2
943:                         .Caption   = "Barra"
944:                     ENDWITH
945:                 ENDWITH
946: 
947:                 WITH .Column2
948:                     IF USED(THIS.this_cCursorGrade)
949:                         .ControlSource = "BarBonus.Valors"
950:                     ENDIF
951:                     .FontName      = "Tahoma"
952:                     .FontSize      = 8
953:                     WITH .Header1
954:                         .FontName  = "Tahoma"
955:                         .FontSize  = 8
956:                         .Alignment = 2
957:                         .Caption   = "Valor"
958:                     ENDWITH
959:                 ENDWITH
960:             ENDWITH
961: 
962:             *-- Celulas da grade (subclasses com o When/Valid do legado).
963:             *-- DEPOIS do bloco acima: atribuir RecordSource derruba o
964:             *-- CurrentControl das colunas, e eh ele que faz a subclasse

*-- Linhas 1130 a 1192:
1130:     *         Set Decimals to 0
1131:     *         nDope = Val( Left( Str( This.Value, 10 ), 4 ) )
1132:     *         Nume  = Val( Right( Str( This.Value, 10 ), 6 ) )
1133:     *         lcSql = [Select Dopes From SigCdOpe Where ndopes = ]+Str(nDope)
1134:     *         ThisForm.PodataMgr.Sqlexecute(lcSql,'LocalSnOpe')
1135:     *         If Used('LocalSnOpe') And Reccount('LocalSnOpe') = 0
1136:     *             MessageBox('Barra Invalido!!!!',0+16,'') / This.Value = 0 / Return .f.
1137:     *         EndIf
1138:     *         Select BarBonus / Skip / Skip -1
1139:     *         Select Sum(1) as Qt, Codigos From BarBonus Where Codigos = This.Value ...
1140:     *         If CheckDup.Qt > 1
1141:     *             MessageBox('Barra ja digitado !!!',0+48,'') / This.Value = 0 / Return .F.
1142:     *         Endif
1143:     *         Replace Valors With CrSigOpFp.VlrFpgs in BarBonus
1144:     *         Select BarBonus / Skip
1145:     *         If Eof()
1146:     *             Insert Into BarBonus( Codigos ) Values ( 0 ) / KeyBoard "{DNARROW}"
1147:     *         EndIf
1148:     *     Endif
1149:     *     Return .t.
1150:     *
1151:     * A REGRA (decodificar a barra, conferir a operacao em SigCdOpe, conferir
1152:     * duplicidade e gravar o valor da forma de pagamento) mora no BO, em
1153:     * SIGOPPGCBO.Inserir()/Atualizar() - fonte unica, ja escrita na Fase 2.
1154:     * Este metodo eh a parte que pertence a TELA: ler o valor digitado,
1155:     * descarregar o buffer da celula no cursor, escolher Inserir x Atualizar,
1156:     * zerar a celula quando a barra eh recusada e abrir a linha seguinte.
1157:     *
1158:     * O valor digitado vem de par_oTxt.Value, NAO do cursor (regra CLAUDE.md
1159:     * #46): dentro do Valid o cursor ainda tem o valor ANTIGO - validar pelo
1160:     * cursor conferiria a barra anterior. O "Select BarBonus / Skip / Skip -1"
1161:     * do legado existe justamente para FORCAR a descarga do buffer da celula
1162:     * no cursor ANTES da consulta de duplicidade (mover o ponteiro grava a
1163:     * edicao ainda em buffer); sem ele a propria linha corrente nao entraria na
1164:     * contagem e o "Qt > 1" nunca acusaria duplicata. Transcrito, com guarda
1165:     * de EOF/RECCOUNT - no legado o ponteiro esta sempre numa linha valida
1166:     * (a celula ativa), e com cursor vazio nao ha buffer a descarregar.
1167:     *
1168:     * O RECNO eh salvo e restaurado em volta da chamada ao BO porque ele faz
1169:     * SELECT-SQL sobre o proprio BarBonus (a consulta de duplicidade) e troca
1170:     * a area de trabalho corrente; o legado tambem re-seleciona BarBonus
1171:     * explicitamente depois do Replace. Sem repor o ponteiro, o
1172:     * "Skip / If Eof() / Insert" seguinte abriria linha nova no lugar errado.
1173:     *
1174:     * Inserir x Atualizar: this_nCodigoBarraAnterior (o _OldCodigo capturado
1175:     * pelo When) distingue linha NOVA (celula estava em 0) de CORRECAO de uma
1176:     * barra ja digitada. As duas delegam a MESMA validacao no BO - o que muda
1177:     * eh so o rotulo gravado em LogAuditoria ("INSERT" x "UPDATE").
1178:     *
1179:     * Barra recusada: a celula volta a 0 ("This.Value = 0" do legado) e o
1180:     * retorno .F. mantem o cursor nela. NAO ha mensagem acrescentada aqui - o
1181:     * BO ja exibiu a dele ("Barra Invalido!!!!" / "Barra ja digitado !!!") e
1182:     * marcou this_lErroExibido; duplicar a mensagem faria o usuario dispensar
1183:     * dois dialogos pelo mesmo motivo (regra CLAUDE.md #20).
1184:     *
1185:     * RETURN unico, FORA do TRY/CATCH, por flag (regra CLAUDE.md #1).
1186:     *
1187:     * PUBLIC: chamado de FORA da classe, pelo Valid da subclasse de celula.
1188:     *==========================================================================
1189:     PROCEDURE ValidarBarraDigitada(par_oTxt)
1190:         LOCAL loc_lValido, loc_nValor, loc_nRecnoAtual, loc_lGravou, loc_oErro
1191:         loc_lValido = .T.
1192: 

*-- Linhas 1203 a 1259:
1203:             IF loc_nValor > 0 AND VARTYPE(THIS.this_oBusinessObject) = "O" ;
1204:                AND USED(THIS.this_cCursorGrade)
1205: 
1206:                 *-- "Select BarBonus / Skip / Skip -1" - descarrega para o
1207:                 *-- cursor a edicao que ainda esta no buffer da celula.
1208:                 SELECT (THIS.this_cCursorGrade)
1209:                 IF RECCOUNT() > 0 AND !EOF()
1210:                     SKIP
1211:                     SKIP -1
1212:                 ENDIF
1213:                 loc_nRecnoAtual = RECNO()
1214: 
1215:                 *-- Inserir x Atualizar: FormParaBO ja resolveu em
1216:                 *-- this_lNovoRegistro, a partir do _OldCodigo que o When da
1217:                 *-- celula capturou. As duas rodam a MESMA validacao no BO -
1218:                 *-- o que muda eh so o rotulo gravado em LogAuditoria.
1219:                 IF THIS.this_oBusinessObject.this_lNovoRegistro
1220:                     loc_lGravou = THIS.this_oBusinessObject.Inserir()
1221:                 ELSE
1222:                     loc_lGravou = THIS.this_oBusinessObject.Atualizar()
1223:                 ENDIF
1224: 
1225:                 *-- Repoe a area/ponteiro que o SELECT-SQL do BO pode ter
1226:                 *-- trocado ("Select BarBonus" do legado apos o Replace).
1227:                 IF USED(THIS.this_cCursorGrade)
1228:                     SELECT (THIS.this_cCursorGrade)
1229:                     IF loc_nRecnoAtual >= 1 AND loc_nRecnoAtual <= RECCOUNT()
1230:                         GO loc_nRecnoAtual
1231:                     ENDIF
1232:                 ENDIF
1233: 
1234:                 IF loc_lGravou
1235:                     *-- "Select BarBonus / Skip / If Eof() / Insert Into
1236:                     *-- BarBonus(Codigos) Values(0) / KeyBoard {DNARROW}":
1237:                     *-- estando na ULTIMA linha, abre a proxima em branco e
1238:                     *-- desce o cursor para ela, para o usuario seguir lendo
1239:                     *-- barras sem tocar no mouse.
1240:                     IF !EOF()
1241:                         SKIP
1242:                     ENDIF
1243:                     IF EOF()
1244:                         INSERT INTO (THIS.this_cCursorGrade) (Codigos) VALUES (0)
1245:                         KEYBOARD "{DNARROW}"
1246:                     ENDIF
1247: 
1248:                     *-- Encher o cursor NAO repinta a grade ligada a ele
1249:                     *-- (regra CLAUDE.md #21): sem este Refresh a linha nova
1250:                     *-- fica invisivel, com o cursor ja certo.
1251:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1252:                         THIS.grd_4c_Dados.Refresh()
1253:                     ENDIF
1254:                 ELSE
1255:                     *-- "This.Value = 0" do legado - a barra recusada sai da
1256:                     *-- celula e o .F. mantem o cursor nela para redigitar.
1257:                     IF VARTYPE(par_oTxt) = "O"
1258:                         par_oTxt.Value = 0
1259:                     ENDIF

*-- Linhas 1279 a 1298:
1279:     * "Grade.Column1.Text1.LostFocus" do legado:
1280:     *
1281:     *     Set Confirm Off
1282:     *     Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor
1283:     *         From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1
1284:     *     ThisForm.label3.Caption  = '[ '+Alltrim(Str(Selecao.Qt))+' ]'
1285:     *     ThisForm.Get_Saldo.Value = ThisForm.Saldo - Selecao.Valor
1286:     *     ThisForm.label3.Refresh
1287:     *     ThisForm.Get_Saldo.Refresh
1288:     *     If ThisForm.Get_Saldo.Value < 0
1289:     *         MessageBox('Quantidade de Barras excedida!!!',0+16,'Valor a Maior')
1290:     *     Endif
1291:     *     If This.Value = 0 And Lastkey() = 13
1292:     *         ThisForm.Ok.SetFocus
1293:     *     EndIf
1294:     *
1295:     * A CONTA eh regra de negocio e tem FONTE UNICA no BO
1296:     * (SIGOPPGCBO.RecalcularSaldoEQuantidade, que soma BarBonus e grava
1297:     * this_nQtdeBarras/this_nSaldoAtual) - regra CLAUDE.md #17. Este metodo
1298:     * so ESPELHA o resultado nos dois controles. O criterio do legado vai

*-- Linhas 1386 a 1418:
1386:     *
1387:     *     With Thisform.Grade
1388:     *         .RecordSource          = 'BarBonus'
1389:     *         .Column1.ControlSource = 'BarBonus.Codigos'
1390:     *         .Column2.ControlSource = 'BarBonus.Valors'
1391:     *         .Refresh
1392:     *     EndWith
1393:     *     THisForm.Grade.Refresh
1394:     *
1395:     * Tres passos, nesta ordem: vincular (VincularGrade), posicionar o alias
1396:     * (SELECT + GO TOP) e repintar (Grid.Refresh). O ultimo passo eh o que o
1397:     * migrador costuma jogar fora: encher ou reordenar o cursor NAO repinta a
1398:     * grade ligada a ele (regra CLAUDE.md #21) - sem o Refresh a grade fica
1399:     * visualmente vazia com o cursor cheio, sem erro e sem log, e o sintoma
1400:     * ("a tela nao traz os barras") manda o diagnostico para o SQL.
1401:     *
1402:     * Tem de ser o UNICO caminho de carga: cada ponto das fases seguintes que
1403:     * mexer em BarBonus (o "Insert Into BarBonus(Codigos) Values(0)" do Valid
1404:     * da celula, o "Zap" do Cancela.Click) fecha chamando este metodo, nunca
1405:     * VincularGrade nua - re-atribuir RecordSource reseta Column.Width e
1406:     * Header1.Caption (Problema 48/regra #41) e o funil ja os repoe.
1407:     *
1408:     * PUBLIC de proposito: o harness (TesteAutomatico.prg) procura
1409:     * MontaGrade/CarregarDados/CarregarLista/... com PEMSTATUS(...,5) e chama
1410:     * THIS.oForm.<metodo>() de FORA da classe. PEMSTATUS com atributo 5 so
1411:     * testa EXISTENCIA, nao escopo: com PROTECTED o harness entraria no
1412:     * branch e estouraria "Property CARREGARDADOS is not found" em runtime
1413:     * (regra CLAUDE.md #3).
1414:     *
1415:     * Devolve .F. quando nao ha alias para carregar (tela instanciada sem o
1416:     * form chamador) - mas NAO lanca excecao, porque o harness chama o metodo
1417:     * sem argumento e sem cursor. O RETURN fica FORA do TRY/CATCH, por flag
1418:     * (regra CLAUDE.md #1).

*-- Linhas 1425 a 1505:
1425:             THIS.VincularGrade()
1426: 
1427:             IF USED(THIS.this_cCursorGrade)
1428:                 SELECT (THIS.this_cCursorGrade)
1429:                 GO TOP
1430:                 loc_lSucesso = .T.
1431:             ENDIF
1432: 
1433:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1434:                 THIS.grd_4c_Dados.Refresh()
1435:             ENDIF
1436:         CATCH TO loc_oErro
1437:             MsgErro(loc_oErro.Message + CHR(13) + ;
1438:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1439:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPPGC.CarregarDados")
1440:         ENDTRY
1441: 
1442:         RETURN loc_lSucesso
1443:     ENDPROC
1444: 
1445:     *==========================================================================
1446:     * PrepararLinhaInicial - transcreve o bloco do Init legado que deixa o
1447:     * cursor da grade pronto para a leitura das barras:
1448:     *
1449:     *     Select BarBonus
1450:     *     Zap
1451:     *     Append Blank
1452:     *
1453:     * APPEND BLANK eh o que torna a tela USAVEL: sem ele a grade abre com
1454:     * ZERO linha e o usuario nao tem onde digitar a primeira barra - o
1455:     * "Insert Into BarBonus(Codigos) Values(0)" do Valid da celula so abre a
1456:     * linha SEGUINTE, e depende de uma barra ja aceita.
1457:     *
1458:     * ZAP, e NAO "USE IN + CREATE CURSOR": o cursor eh do CHAMADOR - o
1459:     * SIGOPPAG faz "Create Cursor BarBonus (Codigos n(10), Valors n(12,2),
1460:     * Seqs n(3))" ANTES de abrir este dialogo e le o resultado nele depois
1461:     * ("If Reccount('BarBonus') > 0 / Select BarBonus / Scan ..."). ZAP
1462:     * esvazia PRESERVANDO a estrutura - inclusive a coluna Seqs, que esta
1463:     * tela nao usa - e o binding da grade; fechar e recriar o alias
1464:     * derrubaria Grid.RecordSource/Column.ControlSource e a grade ficaria
1465:     * permanentemente vazia com o cursor cheio, sem erro e sem log.
1466:     *
1467:     * SAFETY: este form declara DataSession = 2 e SET SAFETY eh escopado por
1468:     * data session - dentro da sessao privada ele vale ON mesmo com o SET
1469:     * SAFETY OFF do main.prg, e ai o ZAP abre o dialogo modal "Zap ... Are
1470:     * you sure?" e CONGELA a tela esperando um clique que ninguem ve (em
1471:     * teste headless aparece como timeout, nao como erro). Por isso o ZAP vai
1472:     * entre salvar e restaurar o SET("SAFETY").
1473:     *
1474:     * GarantirCursorGrade vem primeiro: quando a tela eh instanciada SEM
1475:     * chamador (harness de teste, validacao de UI) o alias nao existe, e
1476:     * SELECT em alias ausente estouraria dentro do TRY de InicializarForm -
1477:     * que devolveria .F. e faria a tela nao abrir (regra CLAUDE.md #41).
1478:     *
1479:     * Deixa BarBonus como area de trabalho corrente, como o legado: quem roda
1480:     * em seguida eh CarregarDados, que reposiciona o alias da grade ele mesmo
1481:     * (SELECT + GO TOP).
1482:     *==========================================================================
1483:     PROTECTED PROCEDURE PrepararLinhaInicial()
1484:         LOCAL loc_cSafetyAnterior, loc_oErro
1485: 
1486:         TRY
1487:             THIS.GarantirCursorGrade()
1488: 
1489:             IF USED(THIS.this_cCursorGrade)
1490:                 SELECT (THIS.this_cCursorGrade)
1491: 
1492:                 loc_cSafetyAnterior = SET("SAFETY")
1493:                 SET SAFETY OFF
1494:                 ZAP
1495:                 IF loc_cSafetyAnterior = "ON"
1496:                     SET SAFETY ON
1497:                 ENDIF
1498: 
1499:                 APPEND BLANK
1500:             ENDIF
1501:         CATCH TO loc_oErro
1502:             MsgErro(loc_oErro.Message + CHR(13) + ;
1503:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1504:                 "Procedure: " + loc_oErro.Procedure, ;
1505:                 "Erro em FormSIGOPPGC.PrepararLinhaInicial")

*-- Linhas 1581 a 1599:
1581:     * BtnCancelarClick - "PROCEDURE Click" de SIGOPPGC.Cancela (Caption
1582:     * "Cancelar"):
1583:     *
1584:     *     Select BarBonus
1585:     *     Zap
1586:     *     Thisform.parentform.enabled = .T.
1587:     *     Thisform.release
1588:     *
1589:     * O ZAP eh o que COMUNICA o cancelamento: o chamador decide pelo
1590:     * conteudo do cursor ("If Reccount('BarBonus') > 0" no SIGOPPAG), entao
1591:     * esvaziar BarBonus eh como ele distingue cancelar de confirmar - nao eh
1592:     * limpeza cosmetica, e suprimi-lo faria o pai processar as barras lidas
1593:     * como se o usuario tivesse confirmado. Diferente do Confirmar, aqui o
1594:     * cursor NAO recebe APPEND BLANK: fica com RECCOUNT = 0.
1595:     *
1596:     * SAFETY pelo mesmo motivo de PrepararLinhaInicial (DataSession = 2
1597:     * escopa o SET SAFETY e o ZAP congelaria a tela num dialogo modal
1598:     * invisivel).
1599:     *

*-- Linhas 1620 a 1638:
1620: 
1621:         TRY
1622:             IF USED(THIS.this_cCursorGrade)
1623:                 SELECT (THIS.this_cCursorGrade)
1624: 
1625:                 loc_cSafetyAnterior = SET("SAFETY")
1626:                 SET SAFETY OFF
1627:                 ZAP
1628:                 IF loc_cSafetyAnterior = "ON"
1629:                     SET SAFETY ON
1630:                 ENDIF
1631:             ENDIF
1632:         CATCH TO loc_oErro
1633:             MsgErro(loc_oErro.Message + CHR(13) + ;
1634:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1635:                 "Procedure: " + loc_oErro.Procedure, ;
1636:                 "Erro em FormSIGOPPGC.BtnCancelarClick")
1637:         ENDTRY
1638: 

*-- Linhas 1698 a 1721:
1698:     *                         (Inserir), celula que ja tinha barra eh
1699:     *                         CORRECAO (Atualizar). As duas rodam a MESMA
1700:     *                         validacao no BO - o que muda eh so o rotulo
1701:     *                         ("INSERT"/"UPDATE") gravado em LogAuditoria.
1702:     *
1703:     * Le o CONTROLE e NUNCA o cursor (regra CLAUDE.md #46): dentro do Valid o
1704:     * cursor ainda tem o valor ANTIGO, entao validar pelo cursor conferiria a
1705:     * barra anterior. Pelo mesmo motivo nao importa que este metodo rode
1706:     * ANTES do "Select BarBonus / Skip / Skip -1" que descarrega o buffer da
1707:     * celula - ele nao depende do cursor.
1708:     *
1709:     * par_oTxt eh OPCIONAL: a celula ativa chega por parametro quando quem
1710:     * chama eh o Valid da subclasse (que a recebe como THIS), e eh resolvida
1711:     * pelo caminho conhecido na grade quando o metodo eh chamado sem
1712:     * argumento. A Column tem UMA instancia do CurrentControl, compartilhada
1713:     * por todas as linhas, entao os dois caminhos alcancam o MESMO objeto.
1714:     * NUNCA Controls(<nome>) para alcancar membro por nome (regra CLAUDE.md
1715:     * #34), e PEMSTATUS so prova EXISTENCIA, nao escopo (regra CLAUDE.md #3).
1716:     *
1717:     * O saldo recebido do form pai (poValor) NAO passa por aqui: ele chega ao
1718:     * BO em InicializarForm, ANTES de qualquer controle existir - eh
1719:     * parametro do Init ("ThisForm.Saldo = poValor"), nao campo de tela.
1720:     *
1721:     * Devolve .F. quando nao ha BO ou nao ha celula a ler (tela instanciada


### BO (C:\4c\projeto\app\classes\SIGOPPGCBO.prg):
*==============================================================================
* SIGOPPGCBO.prg - Business Object para FormSIGOPPGC (Informe os Barras)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal) aberto por um form pai
* para informar as "barras" (codigos de barra) usadas como forma de pagamento
* por barras/bonus. O dialogo NAO possui tabela propria no SQL Server: ele
* grava os codigos digitados no cursor local BarBonus (criado pelo proprio
* form, no mesmo padrao de SIGOPPED), e por isso this_cTabela fica vazio.
* this_cCampoChave aponta para a coluna que identifica cada linha desse
* cursor (Codigos), usada pelo legado em "Where Codigos = This.Value".
*==============================================================================
DEFINE CLASS SIGOPPGCBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades (dados manipulados pelo dialogo Informe os Barras)
    *--------------------------------------------------------------------------
    this_nSaldoInicial    = 0    && poValor - saldo recebido do form pai (ThisForm.Saldo)
    this_nSaldoAtual      = 0    && saldo apos descontar a soma dos valores das barras validas (Get_Saldo.Value)
    this_nQtdeBarras      = 0    && quantidade de barras validas digitadas (label3 "[ N ]")
    this_cDescFormaPagto  = ""   && crSigOpFp.fpags - descricao da forma de pagamento (label1.Caption)
    this_nValorPorBarra   = 0    && crSigOpFp.VlrFpgs - valor atribuido a cada barra digitada (Replace Valors)
    this_cCodigoBarra     = ""   && ultimo codigo de barra validado na celula da grade (BarBonus.Codigos)
    this_nDopeBarra       = 0    && nDope - codigo da operacao decodificado dos 4 primeiros digitos da barra
    this_nNumeBarra       = 0    && Nume - numero sequencial decodificado dos 6 ultimos digitos da barra
    this_lBarraValida     = .F.  && resultado da ultima validacao de barra contra SigCdOpe

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Codigos"
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega da forma de pagamento (cursor crSigOpFp,
    * aberto pelo form pai e repassado na mesma datasession) a descricao
    * (fpags, equivalente ao label1.Caption do Init legado) e o valor
    * atribuido a cada barra (VlrFpgs, equivalente ao Replace Valors do
    * Valid legado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cDescFormaPagto = TratarNulo(fpags, "")
                THIS.this_nValorPorBarra  = TratarNulo(VlrFpgs, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo de barra validado por ultimo (Codigos, a
    * mesma coluna usada pelo legado em "Where Codigos = This.Value")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigoBarra
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Este dialogo nao grava em tabela do SQL Server (so
    * atualiza o cursor local BarBonus - ver Init, que por isso deixa
    * this_cTabela vazio de proposito). Sobrescrito aqui so para o log de
    * auditoria identificar o cursor afetado em vez de uma tabela vazia.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cChave, loc_cSQL, loc_lResultado
        loc_lResultado = .F.

        loc_cChave = THIS.ObterChavePrimaria()

        IF !EMPTY(loc_cChave) AND !(TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + EscaparSQL("BarBonus") + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")) + ", GETDATE())"
            loc_lResultado = (SQLEXEC(gnConnHandle, loc_cSQL) > 0)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - A grade aceita uma barra nova por linha (sempre Codigos = 0
    * antes de validar - ver Insert Into BarBonus(Codigos) Values(0) do
    * legado); a validacao e a gravacao sao a MESMA operacao do Valid
    * legado, por isso delega para o mesmo metodo que Atualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Revalida uma barra ja existente na grade (usuario corrige
    * o codigo de uma linha) - mesma operacao de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ValidarBarraEAtualizarCursor()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarBarraEAtualizarCursor - Transcricao de
    * SIGOPPGC.Grade.Column1.Text1.Valid: decodifica o codigo de barra
    * (this_cCodigoBarra, 10 digitos) nos 4 primeiros digitos (codigo da
    * operacao, this_nDopeBarra) e nos 6 ultimos (numero sequencial,
    * this_nNumeBarra); confere o codigo da operacao contra SigCdOpe;
    * confere duplicidade da mesma barra dentro do cursor local BarBonus; e,
    * se tudo valido, grava o valor da forma de pagamento (this_nValorPorBarra,
    * carregado de crSigOpFp.VlrFpgs em CarregarDoCursor) na linha corrente
    * de BarBonus.Valors.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarBarraEAtualizarCursor()
        LOCAL loc_lResultado, loc_nCodigoBarra, loc_cSqlOpe, loc_nResultado, loc_oErro

        loc_lResultado   = .T.
        loc_nCodigoBarra = VAL(THIS.this_cCodigoBarra)

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        THIS.this_lBarraValida  = .F.
        THIS.this_nDopeBarra    = 0
        THIS.this_nNumeBarra    = 0

        TRY
            IF loc_nCodigoBarra > 0
                SET DECIMALS TO 0
                THIS.this_nDopeBarra = VAL(LEFT(STR(loc_nCodigoBarra, 10), 4))
                THIS.this_nNumeBarra = VAL(RIGHT(STR(loc_nCodigoBarra, 10), 6))

                loc_cSqlOpe = "SELECT Dopes FROM SigCdOpe WHERE ndopes = " + STR(THIS.this_nDopeBarra)

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSqlOpe, "cursor_4c_ValidaOpe")

                IF loc_nResultado < 0 OR !USED("cursor_4c_ValidaOpe") OR RECCOUNT("cursor_4c_ValidaOpe") = 0
                    THIS.this_cMensagemErro = "Barra Inv" + CHR(225) + "lido!!!!"
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                    loc_lResultado = .F.
                ELSE
                    IF USED("BarBonus")
                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF

                        *-- m. OBRIGATORIO: em SELECT VFP local, nome solto eh
                        *-- resolvido primeiro como COLUNA - sem o prefixo a
                        *-- consulta de duplicidade pode estourar "Column
                        *-- LOC_NCODIGOBARRA is not found" em vez de comparar
                        *-- com a variavel.
                        SELECT SUM(1) AS Qt, Codigos FROM BarBonus ;
                            WHERE Codigos = m.loc_nCodigoBarra ;
                            GROUP BY Codigos ;
                            INTO CURSOR cursor_4c_CheckDup

                        IF USED("cursor_4c_CheckDup") AND cursor_4c_CheckDup.Qt > 1
                            THIS.this_cMensagemErro = "Barra j" + CHR(225) + " digitado !!!"
                            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.this_lErroExibido = .T.
                            loc_lResultado = .F.
                        ELSE
                            REPLACE Valors WITH THIS.this_nValorPorBarra IN BarBonus
                            THIS.this_lBarraValida = .T.
                        ENDIF

                        IF USED("cursor_4c_CheckDup")
                            USE IN cursor_4c_CheckDup
                        ENDIF
                    ELSE
                        THIS.this_cMensagemErro = "Cursor de barras (BarBonus) n" + CHR(227) + "o est" + CHR(225) + " aberto."
                        THIS.this_lErroExibido = .T.
                        loc_lResultado = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_ValidaOpe")
                    USE IN cursor_4c_ValidaOpe
                ENDIF
            ENDIF

            IF loc_lResultado AND THIS.this_lBarraValida
                THIS.RegistrarAuditoria(IIF(THIS.this_lNovoRegistro, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar barra: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * RecalcularSaldoEQuantidade - Transcricao da conta que
    * SIGOPPGC.Grade.Column1.Text1.LostFocus faz no legado:
    *
    *     Select [ ] as Agrupar, Sum(1) as Qt, Sum(valors) as Valor
    *         From BarBonus Where Codigos <> 0 Into Cursor Selecao group by 1
    *     ThisForm.label3.Caption  = '[ '+Alltrim(Str(Selecao.Qt))+' ]'
    *     ThisForm.Get_Saldo.Value = ThisForm.Saldo - Selecao.Valor
    *
    * Fica NO BO porque eh regra de negocio com FONTE UNICA (regra CLAUDE.md
    * #17 - totais calculados pelo BO, o form so espelha): grava
    * this_nQtdeBarras (contador "[ N ]" de label3) e this_nSaldoAtual (saldo
    * restante de Get_Saldo), que FormSIGOPPGC.AtualizarSaldoEQuantidade le
    * para repintar os dois controles.
    *
    * O CRITERIO do legado vai junto e eh parte da regra: "Where Codigos <> 0"
    * EXCLUI a linha em branco que o Valid acabou de abrir (o
    * "Insert Into BarBonus(Codigos) Values(0)"), senao ela entraria na
    * contagem de barras e inflaria o total em um.
    *
    * Cursor vazio / nenhuma barra valida: no legado o GROUP BY devolve ZERO
    * linhas e "Selecao.Qt"/"Selecao.Valor" lidos em EOF valem 0, ou seja
    * contador 0 e saldo = saldo inicial. Reproduzido com guarda EXPLICITA de
    * RECCOUNT, que da o mesmo resultado sem depender da leitura em EOF.
    *
    * A area de trabalho corrente eh salva e restaurada: o SELECT-SQL a troca,
    * e quem chama (o Valid da celula) depende do ponteiro de BarBonus para
    * decidir se abre linha nova.
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularSaldoEQuantidade(par_cAliasGrade)
        LOCAL loc_lResultado, loc_cAlias, loc_cAliasAnterior, loc_nRecno, loc_oErro
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasGrade) = "C" AND !EMPTY(par_cAliasGrade), ;
                         ALLTRIM(par_cAliasGrade), "BarBonus")

        THIS.this_nQtdeBarras = 0
        THIS.this_nSaldoAtual = THIS.this_nSaldoInicial

        TRY
            IF USED(loc_cAlias)
                loc_cAliasAnterior = ALIAS()
                SELECT (loc_cAlias)
                loc_nRecno = RECNO()

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- FROM por MACRO (&), nao "(loc_cAlias)": o FROM de um
                *-- SELECT-SQL do VFP nao aceita expressao de nome entre
                *-- parenteses - so literal ou substituicao de macro. Sem o
                *-- ponto final o VFP leria o "nome" ate o ";" da continuacao.
                *-- O "[ ] as Agrupar ... group by 1" do legado existe so para
                *-- forcar UMA linha de resultado; a agregacao sem GROUP BY ja
                *-- devolve exatamente uma linha, inclusive quando nenhuma
                *-- barra casa (ai com total zerado), entao a coluna constante
                *-- nao eh reproduzida - ninguem a le.
                SELECT SUM(1) AS Qt, SUM(Valors) AS Valor ;
                    FROM &loc_cAlias. ;
                    WHERE Codigos <> 0 ;
                    INTO CURSOR cursor_4c_Selecao

                IF USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
                    SELECT cursor_4c_Selecao
                    GO TOP
                    THIS.this_nQtdeBarras = NVL(cursor_4c_Selecao.Qt, 0)
                    THIS.this_nSaldoAtual = THIS.this_nSaldoInicial - ;
                                            NVL(cursor_4c_Selecao.Valor, 0)
                ENDIF

                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF

                *-- Repoe area e ponteiro para quem chamou (o Valid da celula
                *-- depende do RECNO de BarBonus).
                IF USED(loc_cAlias)
                    SELECT (loc_cAlias)
                    IF loc_nRecno >= 1 AND loc_nRecno <= RECCOUNT()
                        GO loc_nRecno
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao recalcular saldo: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

