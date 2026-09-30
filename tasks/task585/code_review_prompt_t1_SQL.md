# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS, CPROS

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
  AllowCellSelection = .T.
Select crSigPrCar
	.Column1.ControlSource = [crSigPrCar.Codigos]
	.Column2.ControlSource = [crSigPrCar.Descrs]
			Select a.Codigos ;
			  From crSigPrCar a ;
			Select crAux
			Select crSigPrCar
			Select a.Codigos ;
			  From crSigPrCar a ;
			Select crAux
Select crSigPrCar
	Delete
		Select crSigPrCar
				Delete In crSigPrCar
Select crSigPrCar
	Insert Into crSigPrCar (CPros, pkChaves) Values (crSigCdPro.CPros, fUniqueIds())
Select crSigPrCar

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS SQL (1502 linhas total):

*-- Linhas 87 a 105:
87:     Themes       = .F.
88: 
89:     *-- DataSession PRIVADA (2): o BO consulta SigPrCar direto no SQL Server
90:     *-- (SQLEXEC + cursor_4c_Dados proprio) e NAO precisa de cursor
91:     *-- compartilhado com o form pai. Isolar evita colidir com o
92:     *-- cursor_4c_Dados que o proprio Cadastro de Produtos usa na sua Lista.
93:     DataSession  = 2
94: 
95:     *-- Referencia ao form pai (para reabilitar ao encerrar)
96:     par_oFormPai  = .NULL.
97: 
98:     *-- Contexto recebido na abertura
99:     this_cCpros   = ""            && SigCdPro.CPros do produto corrente
100:     this_cModoPai = "VISUALIZAR"  && INCLUIR/ALTERAR/VISUALIZAR (modo do pai)
101: 
102:     *-- Grupo (SigCdPro.cgrus) do produto corrente - filtra o lookup de
103:     *-- caracteristicas em SigCrRap (espelha "CGrus In (crSigCdPro.CGrus,
104:     *-- Space(3))" do Valid legado). Carregado em InicializarForm.
105:     this_cCgrus   = ""

*-- Linhas 130 a 154:
130:     *-- escolher a caracteristica). Formato: "|pk1|pk2|".
131:     *--
132:     *-- No legado a grade estava ligada ao cursor crSigPrCar do form PAI, e era
133:     *-- o TABLEUPDATE do Cadastro de Produtos que gravava inclusoes e exclusoes
134:     *-- feitas aqui. O form migrado tem DataSession propria e fala com o banco
135:     *-- pelo proprio SigPrCarBO, entao a gravacao tem de acontecer AQUI - senao
136:     *-- o usuario escolhe a caracteristica, fecha o dialogo e nada foi gravado.
137:     *-- Esta lista eh o que distingue "linha nova ainda sem registro no banco"
138:     *-- (INSERT / exclusao apenas local) de "linha que veio do SELECT do
139:     *-- CarregarLista" (UPDATE / DELETE no banco).
140:     this_cPksNovos = ""
141: 
142:     *==========================================================================
143:     PROCEDURE Init
144:     *==========================================================================
145:         LPARAMETERS par_oFormPai, par_cCpros, par_cModoPai
146: 
147:         *-- Armazenar parametros ANTES de DODEFAULT() para que InicializarForm
148:         *-- (chamado pelo FormBase.Init) tenha acesso ao contexto
149:         IF VARTYPE(par_oFormPai) = "O"
150:             THIS.par_oFormPai = par_oFormPai
151:         ENDIF
152: 
153:         THIS.this_cCpros = IIF(VARTYPE(par_cCpros) = "C", ALLTRIM(par_cCpros), "")
154: 

*-- Linhas 183 a 207:
183:             *-- DataSession = 2 nasce com os SETs no DEFAULT do VFP, NAO com os
184:             *-- do config.prg (mesma armadilha da regra #9.4, que o FormBase ja
185:             *-- cobre para DATE/CENTURY). Medido nesta sessao: sessao 1 tem
186:             *-- DELETED=ON / EXACT=ON, a sessao privada do form vem com
187:             *-- DELETED=OFF / EXACT=OFF.
188:             *-- Sem DELETED ON, o DELETE local do BtnExcluirClick (linha em
189:             *-- branco nunca gravada) marca a linha mas ela CONTINUA aparecendo
190:             *-- na grade: o usuario clica Excluir e nada some. O SCAN do
191:             *-- BtnSairClick tambem tornaria a ver as linhas ja apagadas.
192:             SET DELETED ON
193:             SET EXACT ON
194: 
195:             *-- Produto ausente eh erro de USO (o dialogo so existe para um
196:             *-- produto), mas NAO em modo validacao/teste: o ValidarUIFidelity
197:             *-- instancia o form com CREATEOBJECT(<classe>) SEM ARGUMENTO NENHUM
198:             *-- (ValidarUIFidelity.prg:227) e seta apenas gb_4c_ValidandoUI, sem
199:             *-- gc_4c_ArquivoErroTeste - logo o MsgErro daqui abriria um MODAL de
200:             *-- verdade e o harness ficaria PENDURADO para sempre (medido em
201:             *-- 2026-09-26: o vfp9.exe do 07_validarUI passou dos 8 min preso
202:             *-- nesse dialogo, mantendo o proprio .log aberto). Nesses modos o
203:             *-- form segue montando a UI com cpros vazio - que eh exatamente o
204:             *-- que a validacao visual precisa, ja que toda carga de dados
205:             *-- (CarregarCgrusDoProduto/CarregarLista) ja eh pulada abaixo.
206:             IF EMPTY(THIS.this_cCpros) AND !loc_lModoValidacaoOuTeste
207:                 MsgErro("Produto n" + CHR(227) + "o informado para gerenciar " + ;

*-- Linhas 229 a 247:
229:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
230: 
231:                     *-- Grade (Column1=Codigos, Column2=Descrs) - so estrutura,
232:                     *-- sem ControlSource ainda (cursor_4c_Dados so existe
233:                     *-- depois do CarregarLista - regra #41)
234:                     THIS.ConfigurarGrid()
235: 
236:                     *-- Lookup de Codigos (Column1) - espelha Column1.Text1.Valid
237:                     *-- do legado (fwBuscaExt em SigCrRap + checagem de duplicidade)
238:                     THIS.ConfigurarLookupCaracteristicas()
239: 
240:                     *-- Botoes de acao (cmd_4c_Inserir/cmd_4c_Excluir/cmd_4c_Sair)
241:                     *-- - criados DEPOIS do cabecalho para desenhar por cima dele
242:                     *-- (Top=3, dentro da faixa Top=0..80 - regra #11)
243:                     THIS.ConfigurarBotoes()
244: 
245:                     *-- AddObject cria controles com Visible=.F. por padrao
246:                     THIS.TornarControlesVisiveis()
247: 

*-- Linhas 285 a 325:
285:             .FontSize           = 8
286:             .AllowHeaderSizing  = .F.
287:             .AllowRowSizing     = .F.
288:             .AllowCellSelection = .T.
289:             .DeleteMark         = .F.
290:             .RecordMark         = .F.
291:             .RowHeight          = 17
292:             .ScrollBars         = 2
293:             .GridLineColor      = RGB(238, 238, 238)
294:             .ColumnCount        = 2
295: 
296:             .Column1.FontName          = "Tahoma"
297:             .Column1.FontSize          = 8
298:             .Column1.Width             = 150
299:             .Column1.Movable           = .F.
300:             .Column1.Resizable         = .F.
301:             .Column1.Header1.FontName  = "Tahoma"
302:             .Column1.Header1.FontSize  = 8
303:             .Column1.Header1.Alignment = 2
304:             .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
305:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
306: 
307:             *-- Text1 da coluna (SIGPRCAR.Grade.Column1.Text1 do legado:
308:             *-- FontName/FontSize/Margin). MaxLength vem da LARGURA DA COLUNA no
309:             *-- schema (SigPrCar.codigos char(20)), NUNCA do Width em pixels -
310:             *-- digitar mais do que cabe faria o SQL Server recusar o INSERT com
311:             *-- "String or binary data would be truncated" (CLAUDE.md regra #19)
312:             .Column1.Text1.FontName    = "Tahoma"
313:             .Column1.Text1.FontSize    = 8
314:             .Column1.Text1.Margin      = 0
315:             .Column1.Text1.MaxLength   = 20
316: 
317:             .Column2.FontName          = "Tahoma"
318:             .Column2.FontSize          = 8
319:             .Column2.Width             = 290
320:             .Column2.Movable           = .F.
321:             .Column2.Resizable         = .F.
322:             .Column2.Header1.FontName  = "Tahoma"
323:             .Column2.Header1.FontSize  = 8
324:             .Column2.Header1.Alignment = 2
325:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 504 a 525:
504:                 USE IN cursor_4c_ProdutoCgrus
505:             ENDIF
506: 
507:             loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + ;
508:                        EscaparSQL(THIS.this_cCpros)
509: 
510:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoCgrus")
511: 
512:             IF loc_nResultado > 0 AND USED("cursor_4c_ProdutoCgrus") AND ;
513:                RECCOUNT("cursor_4c_ProdutoCgrus") > 0
514:                 THIS.this_cCgrus = TratarNulo(cursor_4c_ProdutoCgrus.cgrus, "C")
515:             ENDIF
516: 
517:             IF USED("cursor_4c_ProdutoCgrus")
518:                 USE IN cursor_4c_ProdutoCgrus
519:             ENDIF
520:         CATCH TO loc_oErro
521:             MsgErro("Erro ao ler grupo do produto: " + loc_oErro.Message, "Erro")
522:         ENDTRY
523:     ENDPROC
524: 
525:     *==========================================================================

*-- Linhas 581 a 611:
581:             RETURN
582:         ENDIF
583: 
584:         SELECT cursor_4c_Dados
585:         IF EOF()
586:             RETURN
587:         ENDIF
588:         loc_cPkChaves = pkchaves
589: 
590:         IF EMPTY(loc_cValorAtual)
591:             THIS.LimparCampos()
592:         ELSE
593:             THIS.ValidarSelecaoCaracteristica(loc_cValorAtual, loc_cPkChaves, "codigos")
594:         ENDIF
595: 
596:         SELECT cursor_4c_Dados
597:         LOCATE FOR pkchaves == loc_cPkChaves
598:         loc_oTxt.Tag = ALLTRIM(codigos)
599: 
600:         THIS.grd_4c_Dados.Refresh()
601:     ENDPROC
602: 
603:     *==========================================================================
604:     PROCEDURE GrdColumn2GotFocus
605:     *==========================================================================
606:     *-- PUBLIC - alvo de BINDEVENT (regra #3)
607:         THIS.grd_4c_Dados.Column2.Text1.Tag = ALLTRIM(THIS.grd_4c_Dados.Column2.Text1.Value)
608: 
609:         *-- Espelha a 2a condicao do When legado de Column2
610:         *-- (Empty(ThisForm.Grade.Column1.text1.Value)): a Descricao so eh
611:         *-- editavel enquanto o Codigo da MESMA linha estiver vazio - o

*-- Linhas 652 a 682:
652:             RETURN
653:         ENDIF
654: 
655:         SELECT cursor_4c_Dados
656:         IF EOF()
657:             RETURN
658:         ENDIF
659:         loc_cPkChaves = pkchaves
660: 
661:         IF EMPTY(loc_cValorAtual)
662:             THIS.LimparCampos()
663:         ELSE
664:             THIS.ValidarSelecaoCaracteristica(loc_cValorAtual, loc_cPkChaves, "descrs")
665:         ENDIF
666: 
667:         SELECT cursor_4c_Dados
668:         LOCATE FOR pkchaves == loc_cPkChaves
669:         loc_oTxt.Tag = ALLTRIM(descrs)
670: 
671:         THIS.grd_4c_Dados.Refresh()
672:     ENDPROC
673: 
674:     *==========================================================================
675:     PROCEDURE AbrirLookupCaracteristica
676:     *==========================================================================
677:     *-- Picker de caracteristicas (SigCrRap) - transcricao do
678:     *--   CreateObject('fwBuscaExt', <conn>, 'SigCrRap', 'CrListaRemota',
679:     *--                 'Codigos'|'Descrs', This.Value, 'Selecao', .t., .f.,
680:     *--                 [CGrus In (] + crSigCdPro.CGrus + [, Space(3))])
681:     *-- dos DOIS Valid do legado (Column1.Text1 busca por Codigos,
682:     *-- Column2.Text1 busca por Descrs).

*-- Linhas 715 a 769:
715:         *--   CGrus In (crSigCdPro.CGrus, Space(3))
716:         *-- (caracteristicas do grupo do produto + as genericas, de grupo em
717:         *-- branco). THIS.this_cCgrus vem de CarregarCgrusDoProduto.
718:         loc_cFiltroGrupo = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ;
719:                             ", " + EscaparSQL(SPACE(3)) + ")"
720: 
721:         TRY
722:             IF USED(loc_cCursor)
723:                 USE IN SELECT(loc_cCursor)
724:             ENDIF
725: 
726:             *-- 1a consulta: prefixo no campo digitado OU no outro (o usuario
727:             *-- pode digitar parte do codigo na celula de descricao e vice-versa)
728:             IF !EMPTY(loc_cValor)
729:                 loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs" + ;
730:                            " FROM SigCrRap" + ;
731:                            " WHERE (codigos LIKE " + EscaparSQL(loc_cValor + "%") + ;
732:                            " OR descrs LIKE " + EscaparSQL(loc_cValor + "%") + ")" + ;
733:                            " AND (" + loc_cFiltroGrupo + ")" + ;
734:                            " ORDER BY " + loc_cCampo
735:             ELSE
736:                 loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs" + ;
737:                            " FROM SigCrRap" + ;
738:                            " WHERE (" + loc_cFiltroGrupo + ")" + ;
739:                            " ORDER BY " + loc_cCampo
740:             ENDIF
741: 
742:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
743: 
744:             *-- 2a consulta (fallback SHOW-ALL): o prefixo nao casou nada -
745:             *-- mostrar todas as caracteristicas do grupo em vez de abrir o
746:             *-- picker vazio
747:             IF loc_nResultado > 0 AND USED(loc_cCursor) AND ;
748:                RECCOUNT(loc_cCursor) = 0 AND !EMPTY(loc_cValor)
749:                 USE IN SELECT(loc_cCursor)
750:                 loc_cSQL = "SELECT codigos AS Cods, descrs AS Descs" + ;
751:                            " FROM SigCrRap" + ;
752:                            " WHERE (" + loc_cFiltroGrupo + ")" + ;
753:                            " ORDER BY " + loc_cCampo
754:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
755:             ENDIF
756: 
757:             IF loc_nResultado < 0
758:                 MsgErro("Erro ao consultar caracter" + CHR(237) + "sticas:" + CHR(13) + ;
759:                          CapturarErroSQL(), "Erro SQL")
760:             ELSE
761:                 IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
762:                     MsgAviso("Nenhuma caracter" + CHR(237) + "stica dispon" + CHR(237) + ;
763:                               "vel para o grupo deste produto.", loc_cTitulo)
764:                 ELSE
765:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
766: 
767:                     IF VARTYPE(loc_oBusca) = "O"
768:                         *-- DefinirCursor fixa os campos que o Mostrar() le de
769:                         *-- volta (Cods/Descs) e ja monta 2 colunas

*-- Linhas 794 a 820:
794:             ENDIF
795: 
796:             IF USED(loc_cCursor)
797:                 USE IN SELECT(loc_cCursor)
798:             ENDIF
799:         CATCH TO loc_oErro
800:             MsgErro("Erro ao abrir a busca de caracter" + CHR(237) + "sticas:" + CHR(13) + ;
801:                      loc_oErro.Message + CHR(13) + ;
802:                      "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
803:                      "Procedure: " + loc_oErro.Procedure, "Erro")
804:             IF USED(loc_cCursor)
805:                 USE IN SELECT(loc_cCursor)
806:             ENDIF
807:         ENDTRY
808: 
809:         *-- limpar a guarda DEPOIS do ENDTRY (vale tambem quando o CATCH dispara)
810:         THIS.this_lLookupAberto = .F.
811: 
812:         RETURN loc_lSelecionou
813:     ENDPROC
814: 
815:     *==========================================================================
816:     PROTECTED PROCEDURE ValidarSelecaoCaracteristica
817:     *==========================================================================
818:     *-- par_cValor      - texto digitado pelo usuario (Codigo OU Descricao,
819:     *--                   conforme par_cCampoBusca) na celula da grade
820:     *-- par_cPkChaves   - pkchaves da linha corrente do cursor_4c_Dados

*-- Linhas 827 a 867:
827:     *-- ja filtrado pelo mesmo cgrus (o picker busca por codigo OU descricao,
828:     *-- entao serve aos dois caminhos). Selecionado (ou match exato achado),
829:     *-- confere duplicidade contra as demais linhas do proprio cursor antes
830:     *-- de gravar - igual ao "Select ... Where a.Codigos = ... And
831:     *-- a.pkChaves <> crSigPrCar.pkChaves" dos dois Valid legado.
832:         LPARAMETERS par_cValor, par_cPkChaves, par_cCampoBusca
833:         LOCAL loc_cFiltroGrupo, loc_cSQL, loc_nResultado, loc_lAchou
834:         LOCAL loc_cCodigoSel, loc_cDescrSel, loc_lDuplicado, loc_cCampoBusca
835: 
836:         loc_lAchou    = .F.
837:         loc_cCodigoSel = ""
838:         loc_cDescrSel  = ""
839:         loc_cCampoBusca = IIF(VARTYPE(par_cCampoBusca) = "C" AND !EMPTY(par_cCampoBusca), ;
840:                                par_cCampoBusca, "codigos")
841: 
842:         loc_cFiltroGrupo = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ;
843:                             ", " + EscaparSQL(SPACE(3)) + ")"
844: 
845:         IF USED("cursor_4c_LkpCarExato")
846:             USE IN cursor_4c_LkpCarExato
847:         ENDIF
848: 
849:         loc_cSQL = "SELECT codigos, descrs FROM SigCrRap WHERE " + loc_cCampoBusca + " = " + ;
850:                    EscaparSQL(par_cValor) + " AND " + loc_cFiltroGrupo
851: 
852:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpCarExato")
853: 
854:         IF loc_nResultado > 0 AND USED("cursor_4c_LkpCarExato") AND ;
855:            RECCOUNT("cursor_4c_LkpCarExato") = 1
856:             loc_cCodigoSel = ALLTRIM(cursor_4c_LkpCarExato.codigos)
857:             loc_cDescrSel  = ALLTRIM(cursor_4c_LkpCarExato.descrs)
858:             loc_lAchou     = .T.
859:         ENDIF
860: 
861:         IF USED("cursor_4c_LkpCarExato")
862:             USE IN cursor_4c_LkpCarExato
863:         ENDIF
864: 
865:         IF !loc_lAchou
866:             *-- Sem match exato o legado abre o picker (fwBuscaExt). O par
867:             *-- selecionado vem por PROPERTY, nao lido de volta das celulas da

*-- Linhas 875 a 929:
875:             ENDIF
876:         ENDIF
877: 
878:         SELECT cursor_4c_Dados
879:         LOCATE FOR pkchaves == par_cPkChaves
880: 
881:         IF !loc_lAchou
882:             THIS.LimparCampos()
883:             THIS.grd_4c_Dados.Refresh()
884:             RETURN
885:         ENDIF
886: 
887:         *-- checa duplicidade nas OUTRAS linhas do cursor (mesma caracteristica
888:         *-- ja lancada para este produto)
889:         loc_lDuplicado = .F.
890:         SELECT cursor_4c_Dados
891:         SCAN FOR ALLTRIM(codigos) == loc_cCodigoSel AND pkchaves <> par_cPkChaves
892:             loc_lDuplicado = .T.
893:             EXIT
894:         ENDSCAN
895: 
896:         SELECT cursor_4c_Dados
897:         LOCATE FOR pkchaves == par_cPkChaves
898: 
899:         IF loc_lDuplicado
900:             MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + " informada " + ;
901:                       "para este produto!", "Aten" + CHR(231) + CHR(227) + "o")
902:             THIS.LimparCampos()
903:         ELSE
904:             REPLACE codigos WITH loc_cCodigoSel, descrs WITH loc_cDescrSel IN cursor_4c_Dados
905: 
906:             *-- Grava em SigPrCar na hora (INSERT na linha nova, UPDATE na que
907:             *-- veio do CarregarLista). No legado quem gravava era o TABLEUPDATE
908:             *-- do form pai sobre crSigPrCar; aqui o dialogo tem DataSession e
909:             *-- BO proprios, entao sem esta chamada a escolha do usuario ficaria
910:             *-- so no cursor local e se perderia ao encerrar.
911:             IF !THIS.GravarCaracteristica(par_cPkChaves, loc_cCodigoSel)
912:                 *-- Gravacao recusada (a falha ja foi exibida): desfaz na grade
913:                 *-- para a tela nao mostrar o que o banco nao tem
914:                 SELECT cursor_4c_Dados
915:                 LOCATE FOR pkchaves == par_cPkChaves
916:                 IF FOUND()
917:                     THIS.LimparCampos()
918:                 ENDIF
919:             ENDIF
920:         ENDIF
921: 
922:         THIS.grd_4c_Dados.Refresh()
923:     ENDPROC
924: 
925:     *==========================================================================
926:     PROCEDURE CarregarLista
927:     *==========================================================================
928:         *-- Busca as caracteristicas do produto corrente e vincula a grade.
929:         *-- PUBLIC (nao PROTECTED) - TesteAutomatico.prg chama metodos do form

*-- Linhas 936 a 1011:
936:         ENDIF
937: 
938:         *-- Cursor recem-lido do banco: toda linha existe em SigPrCar, logo nao
939:         *-- ha mais pendencia de INSERT (as linhas em branco que estavam na
940:         *-- lista nao voltam do SELECT)
941:         THIS.this_cPksNovos = ""
942: 
943:         IF USED("cursor_4c_Dados")
944:             SELECT cursor_4c_Dados
945:             GO TOP
946: 
947:             WITH THIS.grd_4c_Dados
948:                 .RecordSource = ""
949:                 .RecordSource = "cursor_4c_Dados"
950:                 .Column1.ControlSource = "cursor_4c_Dados.codigos"
951:                 .Column2.ControlSource = "cursor_4c_Dados.descrs"
952: 
953:                 *-- RecordSource/ControlSource resetam Width e Header1.Caption -
954:                 *-- reconfigurar SEMPRE depois de vincular (Problema 48/CLAUDE.md)
955:                 .Column1.Width           = 150
956:                 .Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
957:                 .Column2.Width           = 290
958:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
959: 
960:                 .Refresh()
961:             ENDWITH
962:         ENDIF
963: 
964:         RETURN loc_lSucesso
965:     ENDPROC
966: 
967:     *==========================================================================
968:     PROCEDURE BtnInserirClick
969:     *==========================================================================
970:         *-- Espelha cmdInserir.Click do legado: garante UMA linha em branco
971:         *-- (Codigos vazio) para o usuario preencher via lookup (Fase 6).
972:         *-- Legado: Locate For CPros = crSigCdPro.CPros And Empty(Codigos) /
973:         *-- If Eof() / Insert Into crSigPrCar (CPros, pkChaves) ...
974:         *-- PUBLIC - alvo de BINDEVENT (regra #3)
975:         LOCAL loc_cPkNovo
976: 
977:         IF !USED("cursor_4c_Dados")
978:             RETURN
979:         ENDIF
980: 
981:         THIS.this_lHouveIncl = .T.
982: 
983:         SELECT cursor_4c_Dados
984:         LOCATE FOR ALLTRIM(cpros) == ALLTRIM(THIS.this_cCpros) AND EMPTY(codigos)
985: 
986:         IF !FOUND()
987:             loc_cPkNovo = fUniqueIds()
988: 
989:             APPEND BLANK
990:             REPLACE cpros    WITH THIS.this_cCpros, ;
991:                     pkchaves WITH loc_cPkNovo, ;
992:                     codigos  WITH "", ;
993:                     descrs   WITH ""
994: 
995:             *-- Linha existe so no cursor local ate o usuario escolher a
996:             *-- caracteristica (GravarCaracteristica faz o INSERT)
997:             THIS.RegistrarPkNovo(loc_cPkNovo)
998:         ENDIF
999: 
1000:         *-- Popular o cursor NAO repinta a grade (regra #21)
1001:         THIS.grd_4c_Dados.Refresh()
1002:         THIS.grd_4c_Dados.Column1.SetFocus()
1003:     ENDPROC
1004: 
1005:     *==========================================================================
1006:     PROCEDURE RegistrarPkNovo
1007:     *==========================================================================
1008:     *-- Marca o pkchaves como linha criada nesta sessao e ainda NAO gravada em
1009:     *-- SigPrCar. PUBLIC - chamado tambem de GravarCaracteristica.
1010:         LPARAMETERS par_cPkChaves
1011:         LOCAL loc_cPk

*-- Linhas 1035 a 1101:
1035:     PROCEDURE EhRegistroNovo
1036:     *==========================================================================
1037:     *-- .T. quando a linha foi criada nesta sessao e ainda nao tem registro
1038:     *-- em SigPrCar (logo: INSERT ao gravar, exclusao apenas local ao apagar).
1039:     *-- PUBLIC - usado pelos handlers de botao e por GravarCaracteristica.
1040:         LPARAMETERS par_cPkChaves
1041:         LOCAL loc_cPk
1042:         loc_cPk = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
1043: 
1044:         RETURN !EMPTY(loc_cPk) AND ;
1045:                ("|" + loc_cPk + "|") $ THIS.this_cPksNovos
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     PROTECTED PROCEDURE FormParaBO
1050:     *==========================================================================
1051:     *-- Transfere a ficha da TELA para o BO. Nesta tela a ficha eh a LINHA
1052:     *-- CORRENTE da grade, nao um conjunto de TextBox soltos: as tres colunas
1053:     *-- persistidas de SigPrCar (pkchaves / cpros / codigos) sao exatamente as
1054:     *-- colunas da linha, e as celulas editaveis da grade estao vinculadas a
1055:     *-- elas por ControlSource (cursor_4c_Dados.codigos / .descrs).
1056:     *--
1057:     *-- Os valores NAO podem ser lidos de Column1.Text1.Value /
1058:     *-- Column2.Text1.Value: em Grid esses controles sao a celula CORRENTE,
1059:     *-- re-vinculada quando o ponteiro do cursor se move - ler do cursor eh o
1060:     *-- unico jeito de garantir que se esta lendo a linha pretendida.
1061:     *--
1062:     *-- Retorno: .T. quando havia linha corrente para transferir.
1063:     *--
1064:     *-- PROTECTED por HERANCA, nao por escolha: FormBase declara FormParaBO,
1065:     *-- BOParaForm e LimparCampos como PROTECTED (sao os hooks que
1066:     *-- FormBase.Salvar/Novo/Excluir/Cancelar chamam por THIS.), e o VFP9 NAO
1067:     *-- deixa a subclasse ALARGAR o escopo. Omitir o PROTECTED aqui nao tornaria
1068:     *-- o metodo publico - so esconderia o fato: medido no VFP9 em 2026-09-26,
1069:     *-- PEMSTATUS(oForm, "FormParaBO", 5) devolve .T. e a chamada de FORA da
1070:     *-- classe estoura "Property FORMPARABO is not found" (mesma armadilha da
1071:     *-- regra #3 do CLAUDE.md). Chamado so de dentro (GravarCaracteristica).
1072:         IF !USED("cursor_4c_Dados") OR VARTYPE(THIS.this_oBusinessObject) != "O"
1073:             RETURN .F.
1074:         ENDIF
1075: 
1076:         SELECT cursor_4c_Dados
1077:         IF EOF()
1078:             RETURN .F.
1079:         ENDIF
1080: 
1081:         WITH THIS.this_oBusinessObject
1082:             .this_cPkChaves = ALLTRIM(cursor_4c_Dados.pkchaves)
1083:             .this_cCpros    = ALLTRIM(cursor_4c_Dados.cpros)
1084:             .this_cCodigos  = ALLTRIM(cursor_4c_Dados.codigos)
1085: 
1086:             *-- descrs nao existe em SigPrCar (vem do JOIN com SigCrRap) - o BO
1087:             *-- so a guarda para exibicao/auditoria, nao a grava
1088:             .this_cDescrs   = ALLTRIM(cursor_4c_Dados.descrs)
1089:         ENDWITH
1090: 
1091:         RETURN .T.
1092:     ENDPROC
1093: 
1094:     *==========================================================================
1095:     PROTECTED PROCEDURE BOParaForm
1096:     *==========================================================================
1097:     *-- Sentido inverso do FormParaBO: escreve as propriedades do BO na LINHA
1098:     *-- CORRENTE da grade. Chamado depois de um Salvar() bem-sucedido para a
1099:     *-- grade exibir o que o BO efetivamente levou ao banco - em especial o
1100:     *-- pkchaves, que SigPrCarBO.Inserir gera por conta propria (fUniqueIds())
1101:     *-- quando chega vazio: sem esta volta a linha ficaria com PK diferente da

*-- Linhas 1109 a 1127:
1109:             RETURN .F.
1110:         ENDIF
1111: 
1112:         SELECT cursor_4c_Dados
1113:         IF EOF()
1114:             RETURN .F.
1115:         ENDIF
1116: 
1117:         REPLACE pkchaves WITH THIS.this_oBusinessObject.this_cPkChaves, ;
1118:                 cpros    WITH THIS.this_oBusinessObject.this_cCpros, ;
1119:                 codigos  WITH THIS.this_oBusinessObject.this_cCodigos, ;
1120:                 descrs   WITH THIS.this_oBusinessObject.this_cDescrs ;
1121:              IN cursor_4c_Dados
1122: 
1123:         *-- Popular/alterar o cursor NAO repinta a grade (CLAUDE.md regra #21)
1124:         THIS.grd_4c_Dados.Refresh()
1125: 
1126:         RETURN .T.
1127:     ENDPROC

*-- Linhas 1147 a 1180:
1147:             RETURN .F.
1148:         ENDIF
1149: 
1150:         SELECT cursor_4c_Dados
1151:         IF EOF()
1152:             RETURN .F.
1153:         ENDIF
1154: 
1155:         REPLACE codigos WITH "", descrs WITH "" IN cursor_4c_Dados
1156: 
1157:         RETURN .T.
1158:     ENDPROC
1159: 
1160:     *==========================================================================
1161:     PROCEDURE GravarCaracteristica
1162:     *==========================================================================
1163:     *-- Persiste em SigPrCar a caracteristica escolhida para a linha
1164:     *-- par_cPkChaves. INSERT quando a linha nasceu nesta sessao (Inserir),
1165:     *-- UPDATE quando o usuario trocou a caracteristica de uma linha que veio
1166:     *-- do CarregarLista. Chamado por ValidarSelecaoCaracteristica assim que o
1167:     *-- par Codigo/Descricao eh resolvido - a gravacao eh imediata, igual a
1168:     *-- exclusao (BtnExcluirClick), porque este dialogo nao tem botao Confirmar
1169:     *-- e o Encerrar do legado nao grava nada.
1170:     *-- PUBLIC - chamado de ValidarSelecaoCaracteristica.
1171:         LPARAMETERS par_cPkChaves, par_cCodigos
1172:         LOCAL loc_cPk, loc_cCodigos, loc_lNovo, loc_lSucesso
1173: 
1174:         loc_lSucesso = .F.
1175:         loc_cPk      = IIF(VARTYPE(par_cPkChaves) = "C", ALLTRIM(par_cPkChaves), "")
1176:         loc_cCodigos = IIF(VARTYPE(par_cCodigos)  = "C", ALLTRIM(par_cCodigos),  "")
1177: 
1178:         IF EMPTY(loc_cPk) OR EMPTY(loc_cCodigos) OR ;
1179:            VARTYPE(THIS.this_oBusinessObject) != "O"
1180:             RETURN .F.

*-- Linhas 1191 a 1209:
1191:         ENDIF
1192: 
1193:         *-- FormParaBO le a LINHA CORRENTE - posicionar nela antes de chamar
1194:         SELECT cursor_4c_Dados
1195:         LOCATE FOR ALLTRIM(pkchaves) == loc_cPk
1196:         IF !FOUND()
1197:             RETURN .F.
1198:         ENDIF
1199: 
1200:         IF !THIS.FormParaBO()
1201:             RETURN .F.
1202:         ENDIF
1203: 
1204:         *-- A linha acabou de receber o codigo resolvido pelo chamador, entao
1205:         *-- FormParaBO ja o trouxe; reafirmar o argumento deixa explicito qual
1206:         *-- codigo esta sendo gravado e protege contra a linha ter sido
1207:         *-- reposicionada entre a escolha e a gravacao
1208:         THIS.this_oBusinessObject.this_cCodigos = loc_cCodigos
1209:         THIS.this_oBusinessObject.this_cCpros   = THIS.this_cCpros

*-- Linhas 1218 a 1236:
1218: 
1219:             IF loc_lNovo
1220:                 *-- Registro passou a existir no banco: sai da lista de
1221:                 *-- linhas ainda nao gravadas (dai em diante UPDATE, e Excluir apaga la).
1222:                 *-- Usa o pkchaves QUE FOI GRAVADO (BOParaForm acabou de
1223:                 *-- sincroniza-lo), nao o original - se o BO tiver gerado outro,
1224:                 *-- remover o antigo deixaria a linha marcada como nao-gravada para sempre.
1225:                 THIS.RemoverPkNovo(loc_cPk)
1226:                 THIS.RemoverPkNovo(THIS.this_oBusinessObject.this_cPkChaves)
1227:                 THIS.this_lHouveIncl = .T.
1228:             ENDIF
1229:         ELSE
1230:             *-- BusinessBase.Salvar ja exibiu a falha (CLAUDE.md regra #20) -
1231:             *-- so complementa quando ele nao exibiu nada
1232:             IF !THIS.this_oBusinessObject.this_lErroExibido
1233:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar a " + ;
1234:                         "caracter" + CHR(237) + "stica.", "Erro")
1235:             ENDIF
1236:         ENDIF

*-- Linhas 1251 a 1269:
1251:             RETURN
1252:         ENDIF
1253: 
1254:         SELECT cursor_4c_Dados
1255:         IF EOF()
1256:             RETURN
1257:         ENDIF
1258: 
1259:         *-- Guard do legado: "If Not Eof() And (crSigPrCar.CPros =
1260:         *-- crSigCdPro.CPros)" - so apaga linha do produto corrente
1261:         IF ALLTRIM(cpros) != ALLTRIM(THIS.this_cCpros)
1262:             RETURN
1263:         ENDIF
1264: 
1265:         loc_cPkChaves = ALLTRIM(pkchaves)
1266: 
1267:         IF !EMPTY(codigos) AND !THIS.EhRegistroNovo(loc_cPkChaves)
1268:             *-- Linha veio do banco (ou ja foi gravada nesta sessao): apaga la
1269:             THIS.this_oBusinessObject.this_cPkChaves     = loc_cPkChaves

*-- Linhas 1280 a 1357:
1280:             ENDIF
1281:         ELSE
1282:             *-- Linha criada nesta sessao e ainda sem registro em SigPrCar -
1283:             *-- remove so localmente, igual ao Delete/Skip/Skip-1 do legado
1284:             *-- (SET DELETED ON no config.prg ja esconde o registro da grade)
1285:             THIS.RemoverPkNovo(loc_cPkChaves)
1286: 
1287:             DELETE
1288:             SKIP
1289:             SKIP -1
1290: 
1291:             THIS.this_lHouveExcl = .T.
1292:             THIS.grd_4c_Dados.Refresh()
1293:         ENDIF
1294:     ENDPROC
1295: 
1296:     *==========================================================================
1297:     PROCEDURE BtnSairClick
1298:     *==========================================================================
1299:         *-- Espelha cmdSair.Click do legado: em modo INSERIR/ALTERAR, descarta
1300:         *-- linhas deixadas em branco (Codigos vazio) antes de encerrar.
1301:         *--
1302:         *-- Linha em branco que NAO esta na lista das linhas ainda nao gravadas eh linha que veio
1303:         *-- do banco e teve a caracteristica limpa (picker cancelado / escolha
1304:         *-- duplicada): no legado ela ficava marcada para Delete e o TABLEUPDATE
1305:         *-- do form pai a apagava de SigPrCar - aqui isso tem de ser feito pelo
1306:         *-- BO, senao o registro antigo sobrevive ao que o usuario apagou.
1307:         *-- PUBLIC - alvo de BINDEVENT (regra #3)
1308:         LOCAL loc_cPkChaves
1309: 
1310:         IF (THIS.cmd_4c_Inserir.Visible OR THIS.cmd_4c_Excluir.Visible) AND ;
1311:            INLIST(THIS.this_cModoPai, "INSERIR", "ALTERAR")
1312: 
1313:             IF USED("cursor_4c_Dados")
1314:                 SELECT cursor_4c_Dados
1315:                 SCAN
1316:                     IF EMPTY(codigos)
1317:                         loc_cPkChaves = ALLTRIM(pkchaves)
1318: 
1319:                         IF !THIS.EhRegistroNovo(loc_cPkChaves)
1320:                             THIS.this_oBusinessObject.this_cPkChaves     = loc_cPkChaves
1321:                             THIS.this_oBusinessObject.this_lNovoRegistro = .F.
1322: 
1323:                             IF THIS.this_oBusinessObject.Excluir()
1324:                                 THIS.this_lHouveExcl = .T.
1325:                             ELSE
1326:                                 IF !THIS.this_oBusinessObject.this_lErroExibido
1327:                                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
1328:                                             "vel excluir a caracter" + CHR(237) + ;
1329:                                             "stica.", "Erro")
1330:                                 ENDIF
1331:                             ENDIF
1332:                         ELSE
1333:                             THIS.RemoverPkNovo(loc_cPkChaves)
1334:                         ENDIF
1335: 
1336:                         *-- Excluir() do BO faz SQLEXEC (DELETE + auditoria) e
1337:                         *-- pode deixar outra area corrente - reposicionar antes
1338:                         *-- de apagar a linha local
1339:                         SELECT cursor_4c_Dados
1340:                         LOCATE FOR ALLTRIM(pkchaves) == loc_cPkChaves
1341:                         IF FOUND()
1342:                             DELETE
1343:                         ENDIF
1344:                     ENDIF
1345:                 ENDSCAN
1346:             ENDIF
1347:         ENDIF
1348: 
1349:         THIS.Release()
1350:     ENDPROC
1351: 
1352:     *==========================================================================
1353:     PROTECTED PROCEDURE ConfigurarDecoracao
1354:     *==========================================================================
1355:         LOCAL loc_cImgFundo
1356: 
1357:         *-- Picture = ..\framework\imagens\new_background.jpg (SIGPRCAR original).


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*====================================================================
* SigPrCarBO.prg
*
* Business Object para SigPrCar (Caracteristicas do Produto)
* Tabela: SigPrCar (codigos char(20), cpros char(14), pkchaves char(20) - PK)
* Sub-formulario modal chamado de dentro do Cadastro de Produtos (SigCdPro)
* para gerenciar as caracteristicas vinculadas ao produto corrente.
* A descricao (Descrs) nao existe na tabela SigPrCar - vem do lookup em
* SigCrRap (tabela de caracteristicas) filtrado pelo Cgrus do produto.
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCar)
    this_cPkChaves = ""    && pkchaves char(20) - PK (fUniqueIds())
    this_cCpros    = ""    && cpros char(14) - FK para SigCdPro.CPros
    this_cCodigos  = ""    && codigos char(20) - FK para SigCrRap.Codigos

    *-- Propriedade de apoio (NAO persistida em SigPrCar - vem do JOIN com SigCrRap)
    this_cDescrs   = ""    && descrs - descricao da caracteristica (SigCrRap.Descrs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCar"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCarBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
                THIS.this_cCpros    = TratarNulo(cpros,    "C")
                THIS.this_cCodigos  = TratarNulo(codigos,  "C")

                *-- descrs so existe se o cursor veio de um JOIN com SigCrRap
                IF TYPE(par_cAliasCursor + ".descrs") = "C"
                    THIS.this_cDescrs = TratarNulo(descrs, "C")
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrCarBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCpros)
            MsgAviso("Produto n" + CHR(227) + "o informado!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCodigos)
            MsgAviso("Caracter" + CHR(237) + "stica n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCar (codigos, cpros, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCar
                SET codigos = <<EscaparSQL(THIS.this_cCodigos)>>,
                    cpros   = <<EscaparSQL(THIS.this_cCpros)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCar WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCarBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca as caracteristicas vinculadas a um produto (par_cCpros)
    * Retorna cursor_4c_Dados com pkchaves, cpros, codigos, descrs
    * (descrs vem do JOIN com SigCrRap)
    *====================================================================
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.pkchaves, a.cpros, a.codigos, b.descrs
                FROM SigPrCar a
                INNER JOIN SigCrRap b ON b.codigos = a.codigos
                WHERE a.cpros = <<EscaparSQL(par_cCpros)>>
                ORDER BY b.descrs
            ENDTEXT

            *-- SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            *-- (Inserir) e apagar (Excluir) linhas localmente, entao o
            *-- resultado eh copiado para um cursor READWRITE (CLAUDE.md:
            *-- "Grid com coluna EDITAVEL exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SigPrCarBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

