# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 196: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 221: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormDCC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1045 linhas total):

*-- Linhas 120 a 202:
120:         TRY
121:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
122:             WITH THIS.cnt_4c_Cabecalho
123:                 .Top         = 0
124:                 .Left        = 0
125:                 .Width       = THIS.Width
126:                 .Height      = 80
127:                 .BackStyle   = 1
128:                 .BackColor   = RGB(100, 100, 100)
129:                 .BorderWidth = 0
130:                 .Visible     = .T.
131:             ENDWITH
132: 
133:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
134:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
135:                 .FontBold      = .T.
136:                 .FontName      = "Tahoma"
137:                 .FontSize      = 18
138:                 .FontUnderline = .F.
139:                 .WordWrap      = .T.
140:                 .Alignment     = 0
141:                 .BackStyle     = 0
142:                 .AutoSize      = .F.
143:                 .Caption       = "Descontos Concedido no Caixa"
144:                 .Height        = 40
145:                 .Left          = 10
146:                 .Top           = 18
147:                 .Width         = THIS.Width - 20
148:                 .ForeColor     = RGB(0, 0, 0)
149:                 .Visible       = .T.
150:             ENDWITH
151: 
152:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
153:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
154:                 .FontBold      = .T.
155:                 .FontName      = "Tahoma"
156:                 .FontSize      = 18
157:                 .WordWrap      = .T.
158:                 .Alignment     = 0
159:                 .BackStyle     = 0
160:                 .AutoSize      = .F.
161:                 .Caption       = "Descontos Concedido no Caixa"
162:                 .Height        = 46
163:                 .Left          = 10
164:                 .Top           = 17
165:                 .Width         = THIS.Width - 20
166:                 .ForeColor     = RGB(255, 255, 255)
167:                 .ToolTipText   = "T" + CHR(237) + "tulo"
168:                 .Visible       = .T.
169:             ENDWITH
170:         CATCH TO loc_oErro
171:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
172:         ENDTRY
173:     ENDPROC
174: 
175:     *==========================================================================
176:     * ConfigurarBotoes - Cria cmd_4c_Inserir, cmd_4c_Excluir, cmd_4c_Encerrar
177:     * Original (800px): cmdInserir.Left=573, cmdExcluir.Left=649, cmdSair.Left=725
178:     * Escalado (1000px): Inserir=716, Excluir=811, Encerrar=906
179:     * Todos sobrepem o cnt_4c_Cabecalho (Top=7, dentro da faixa 0-80)
180:     *==========================================================================
181:     PROTECTED PROCEDURE ConfigurarBotoes()
182:         LOCAL loc_lPodeInserir, loc_lPodeExcluir, loc_oErro
183:         loc_lPodeInserir = THIS.this_lModoEdicao
184:         loc_lPodeExcluir = THIS.this_lModoEdicao
185: 
186:         TRY
187:             THIS.AddObject("cmd_4c_Inserir", "CommandButton")
188:             WITH THIS.cmd_4c_Inserir
189:                 .Top             = 7
190:                 .Left            = 716
191:                 .Width           = 75
192:                 .Height          = 75
193:                 .Caption         = "Inserir"
194:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
195:                 .ToolTipText     = "Inserir Item"
196:                 .FontName        = "Comic Sans MS"
197:                 .FontBold        = .T.
198:                 .FontItalic      = .T.
199:                 .FontSize        = 8
200:                 .ForeColor       = RGB(90, 90, 90)
201:                 .BackColor       = RGB(255, 255, 255)
202:                 .Themes           = .T.

*-- Linhas 209 a 227:
209:                 .Enabled         = loc_lPodeInserir
210:             ENDWITH
211: 
212:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
213:             WITH THIS.cmd_4c_Excluir
214:                 .Top             = 7
215:                 .Left            = 811
216:                 .Width           = 75
217:                 .Height          = 75
218:                 .Caption         = "Excluir"
219:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
220:                 .ToolTipText     = "Excluir Item"
221:                 .FontName        = "Comic Sans MS"
222:                 .FontBold        = .T.
223:                 .FontItalic      = .T.
224:                 .FontSize        = 8
225:                 .ForeColor       = RGB(90, 90, 90)
226:                 .BackColor       = RGB(255, 255, 255)
227:                 .Themes           = .T.

*-- Linhas 234 a 252:
234:                 .Enabled         = loc_lPodeExcluir
235:             ENDWITH
236: 
237:             THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
238:             WITH THIS.cmd_4c_Encerrar
239:                 .Top             = 7
240:                 .Left            = 906
241:                 .Width           = 75
242:                 .Height          = 75
243:                 .Caption         = "Encerrar"
244:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
245:                 .Cancel          = .T.
246:                 .FontName        = "Comic Sans MS"
247:                 .FontBold        = .T.
248:                 .FontItalic      = .T.
249:                 .FontSize        = 8
250:                 .ForeColor       = RGB(90, 90, 90)
251:                 .BackColor       = RGB(255, 255, 255)
252:                 .Themes           = .T.

*-- Linhas 277 a 296:
277:         TRY
278:             THIS.AddObject("pgf_4c_Principal", "PageFrame")
279:             WITH THIS.pgf_4c_Principal
280:                 .Top       = 80
281:                 .Left      = 0
282:                 .Width     = THIS.Width
283:                 .Height    = THIS.Height - 80
284:                 .PageCount = 1
285:                 .Tabs      = .F.
286:                 .BorderWidth = 0
287:                 .Visible   = .T.
288:             ENDWITH
289: 
290:             WITH THIS.pgf_4c_Principal.Page1
291:                 .Caption = "Descontos"
292:                 .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
293:             ENDWITH
294:         CATCH TO loc_oErro
295:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
296:         ENDTRY

*-- Linhas 474 a 486:
474:                     loc_oGrid.SetFocus()
475:                 ENDIF
476:             ENDIF
477:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
478:                 THIS.cmd_4c_Inserir.Enabled = .F.
479:             ENDIF
480:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
481:                 THIS.cmd_4c_Excluir.Enabled = .F.
482:             ENDIF
483:             THIS.AtualizarTotal()
484:         CATCH TO loc_oErro
485:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
486:         ENDTRY

*-- Linhas 538 a 547:
538:             *-- Grid grd_4c_Dados
539:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
540:             WITH loc_oPagina.grd_4c_Dados
541:                 .Top                = 15
542:                 .Left               = 20
543:                 .Width              = 960
544:                 .Height             = 455
545:                 .ColumnCount        = 4
546:                 .RecordSource       = "xEestDsc"
547:                 .RecordMark         = .F.

*-- Linhas 565 a 573:
565:                     .Resizable         = .F.
566:                     .Sparse            = .F.
567:                     .ReadOnly          = .F.
568:                     .Header1.Caption   = "Motivo"
569:                     .Header1.FontName  = "Tahoma"
570:                     .Header1.FontSize  = 8
571:                     .Header1.Alignment = 2
572:                     .Header1.ForeColor = RGB(90, 90, 90)
573:                     .Text1.BorderStyle = 0

*-- Linhas 584 a 592:
584:                     .Resizable         = .F.
585:                     .Sparse            = .F.
586:                     .ReadOnly          = .T.
587:                     .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
588:                     .Header1.FontName  = "Tahoma"
589:                     .Header1.FontSize  = 8
590:                     .Header1.Alignment = 2
591:                     .Header1.ForeColor = RGB(90, 90, 90)
592:                     .Text1.BorderStyle = 0

*-- Linhas 603 a 611:
603:                     .Resizable         = .F.
604:                     .Sparse            = .F.
605:                     .ReadOnly          = .F.
606:                     .Header1.Caption   = "Valor"
607:                     .Header1.FontName  = "Tahoma"
608:                     .Header1.FontSize  = 8
609:                     .Header1.Alignment = 2
610:                     .Header1.ForeColor = RGB(90, 90, 90)
611:                     .Text1.BorderStyle = 0

*-- Linhas 622 a 630:
622:                     .Movable           = .F.
623:                     .Sparse            = .F.
624:                     .ReadOnly          = .F.
625:                     .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
626:                     .Header1.FontName  = "Tahoma"
627:                     .Header1.FontSize  = 8
628:                     .Header1.Alignment = 2
629:                     .Header1.ForeColor = RGB(90, 90, 90)
630:                     .Text1.BorderStyle = 0

*-- Linhas 637 a 647:
637:             ENDWITH
638: 
639:             *-- BINDEVENTs: botoes (criados em ConfigurarBotoes, acima do PageFrame)
640:             BINDEVENT(THIS.cmd_4c_Inserir,  "Click", THIS, "CmdInserirClick")
641:             BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
642:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
643: 
644:             *-- BINDEVENT: Column1.Text1 KeyPress -> lookup de motivo (F4=115, Enter=13, Tab=9)
645:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdMotivoKeyPress")
646: 
647:             *-- BINDEVENT: Grid AfterRowColChange -> recalcula total ao sair de Column3 (Valor)

*-- Linhas 673 a 687:
673:             loc_oPagina = THIS.pgf_4c_Principal.Page1
674: 
675:             *-- Label "Total R$:" (rotulo do campo de total, alinhado a direita)
676:             loc_oPagina.AddObject("lbl_4c_Total", "Label")
677:             WITH loc_oPagina.lbl_4c_Total
678:                 .Top       = 487
679:                 .Left      = 525
680:                 .Width     = 125
681:                 .Height    = 23
682:                 .Caption   = "Total R$:"
683:                 .FontName  = "Tahoma"
684:                 .FontSize  = 10
685:                 .FontBold  = .T.
686:                 .ForeColor = RGB(90, 90, 90)
687:                 .BackStyle = 0

*-- Linhas 693 a 702:
693:             *-- TextBox txt_4c_Total (equivalente ao Get_total original - somente leitura)
694:             loc_oPagina.AddObject("txt_4c_Total", "TextBox")
695:             WITH loc_oPagina.txt_4c_Total
696:                 .Top       = 483
697:                 .Left      = 658
698:                 .Width     = 130
699:                 .Height    = 23
700:                 .FontName  = "Tahoma"
701:                 .FontSize  = 10
702:                 .FontBold  = .T.

*-- Linhas 964 a 976:
964:         LOCAL loc_lEditar, loc_oErro
965:         loc_lEditar = par_lHabilitar AND THIS.this_lModoEdicao
966:         TRY
967:             IF PEMSTATUS(THIS, "cmd_4c_Inserir", 5)
968:                 THIS.cmd_4c_Inserir.Enabled = loc_lEditar
969:             ENDIF
970:             IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
971:                 THIS.cmd_4c_Excluir.Enabled = loc_lEditar
972:             ENDIF
973:             IF VARTYPE(THIS.pgf_4c_Principal) = "O"
974:                 IF PEMSTATUS(THIS.pgf_4c_Principal.Page1, "grd_4c_Dados", 5)
975:                     THIS.pgf_4c_Principal.Page1.grd_4c_Dados.ReadOnly = !loc_lEditar
976:                 ENDIF


### BO (C:\4c\projeto\app\classes\DCCBO.prg):
*==============================================================================
* DCCBO.prg - Business Object para Descontos Concedido no Caixa
* Origem: SIGCDDCC.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DCCBO AS BusinessBase

    *-- Campos do cursor xEestDsc (cursor VFP local pre-criado pelo form pai)
    this_cCidchaves = ""    && Chave interna do registro (inserida com '  ')
    this_cMotDscs   = ""    && Codigo do motivo de desconto (de SigCdFs.Codigos)
    this_cDescs     = ""    && Descricao do motivo (auto-preenchida de SigCdFs.Descrs)
    this_nValos     = 0     && Valor do desconto
    this_cObs       = ""    && Observacao livre

    *-- Totalizador calculado (SUM(Valos) de xEestDsc)
    this_nTotal     = 0

    *-- Contexto da operacao (populados pelo form ao inicializar o BO)
    this_cEmpresa   = ""    && Codigo da empresa (filtra SigCdFsI.Emps)
    this_cDopes     = ""    && Operacao corrente (filtra SigCdFsO.Dopes, de TprMvCab.Dopes)
    this_dDatas     = {}    && Data do movimento (filtro de periodo PerInis/PerFins)
    this_cContaDs   = ""    && Conta do cliente (Iclis de TprMvCab.ContaDs)

    *-- Dados do cliente para validacao de aniversario (ChkDtAnivs)
    this_dNascs     = {}    && Data de nascimento do cliente (SigCdCli.Nascs)
    this_dDtnCons   = {}    && Data de concessao (SigCdCli.DtnCons)

    *-- Controle de acesso (verificado via VerificarAcesso antes de habilitar botoes)
    this_lPodeInserir = .F.
    this_lPodeExcluir = .F.

    *-- Modo de operacao herdado do form pai (pcEscolha)
    this_lModoEdicao  = .F. && .T. quando pcEscolha IN ('INSERIR','ALTERAR')

    PROCEDURE Init()
        THIS.this_cTabela     = "XEestDsc"
        THIS.this_cCampoChave = "Cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor xEestDsc para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAlias)
            SELECT (par_cAlias)
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "C")
            THIS.this_cMotDscs   = TratarNulo(MotDscs, "C")
            THIS.this_cDescs     = TratarNulo(Descs, "C")
            THIS.this_nValos     = TratarNulo(Valos, "N")
            THIS.this_cObs       = TratarNulo(Obs, "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere linha em branco no cursor local xEestDsc
    * Equivalente ao cmdInserir.Click original (INSERT INTO XEestDsc)
    * OPERACIONAL: opera sobre cursor VFP local, nao SQL Server
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                INSERT INTO xEestDsc (Cidchaves) VALUES ('  ')
                SELECT xEestDsc
                THIS.RegistrarAuditoria("INCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Cursor xEestDsc n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza linha corrente do cursor xEestDsc com props do BO
    * Equivalente ao commit implicito do grid (ControlSource -> REPLACE)
    * OPERACIONAL: opera sobre cursor VFP local, nao SQL Server
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                SELECT xEestDsc
                IF NOT EOF() AND NOT BOF()
                    REPLACE Cidchaves WITH THIS.this_cCidchaves, ;
                            MotDscs   WITH THIS.this_cMotDscs, ;
                            Descs     WITH THIS.this_cDescs, ;
                            Valos     WITH THIS.this_nValos, ;
                            Obs       WITH THIS.this_cObs ;
                            IN xEestDsc
                    THIS.RegistrarAuditoria("ALTERAR")
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Nenhuma linha selecionada para atualiza" + CHR(231) + CHR(227) + "o.", "Atualizar")
                ENDIF
            ELSE
                MsgErro("Cursor xEestDsc n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirLinhaAtual - Exclui linha corrente do cursor xEestDsc
    * Equivalente ao cmdExcluir.Click original
    *--------------------------------------------------------------------------
    FUNCTION ExcluirLinhaAtual()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                SELECT xEestDsc
                IF NOT EOF()
                    DELETE
                    SKIP
                    SKIP -1
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ExcluirLinhaAtual")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarTodos - Valida todas as linhas antes de fechar o form
    * Equivalente ao cmdSair.Click original (parte de validacao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarTodos()
        LOCAL loc_lValido
        loc_lValido = .T.
        TRY
            IF USED("xEestDsc")
                SELECT xEestDsc
                SCAN
                    IF Valos <> 0 AND EMPTY(MotDscs)
                        MsgAviso("Favor informar os dados corretamente. Todos os campos dever" + CHR(227) + "o estar preenchidos.", "Valida" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTodos")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularTotal - Calcula SUM(Valos) de xEestDsc e armazena em this_nTotal
    * Equivalente ao Column3.LostFocus original
    *--------------------------------------------------------------------------
    FUNCTION CalcularTotal()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("xEestDsc")
                SELECT [] AS agrupar, SUM(Valos) AS valos FROM xEestDsc GROUP BY 1 INTO CURSOR cursor_4c_TotalDcc READWRITE
                IF USED("cursor_4c_TotalDcc")
                    IF !EOF("cursor_4c_TotalDcc")
                        THIS.this_nTotal = NVL(cursor_4c_TotalDcc.valos, 0)
                    ELSE
                        THIS.this_nTotal = 0
                    ENDIF
                    USE IN cursor_4c_TotalDcc
                ELSE
                    THIS.this_nTotal = 0
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CalcularTotal")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMotivos - Carrega cursor_4c_TmpMdsc com motivos disponiveis
    * Replica Column1.Text1.Valid original (queries SQL + filtro VFP local)
    * par_cContaDs - conta/cliente corrente (TprMvCab.ContaDs / Iclis)
    * par_dDatas   - data do movimento (TprMvCab.Datas)
    * par_cDopes   - operacao corrente (TprMvCab.Dopes)
    * par_cEmpresa - codigo da empresa atual
    *--------------------------------------------------------------------------
    FUNCTION BuscarMotivos(par_cContaDs, par_dDatas, par_cDopes, par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_dNascs, loc_dDtnCons
        loc_lSucesso = .F.
        loc_dNascs   = {}
        loc_dDtnCons = {}
        TRY
            *-- 1. Dados do cliente para verificacao de aniversario
            loc_cSQL = "SELECT Nascs, DtnCons FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cContaDs))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli") < 1
                MsgErro("Falha ao carregar dados do cliente.", "Erro em BuscarMotivos")
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_LocalCli") AND !EOF("cursor_4c_LocalCli")
                IF !ISNULL(cursor_4c_LocalCli.Nascs)
                    loc_dNascs = cursor_4c_LocalCli.Nascs
                ENDIF
                IF !ISNULL(cursor_4c_LocalCli.DtnCons)
                    loc_dDtnCons = cursor_4c_LocalCli.DtnCons
                ENDIF
            ENDIF
            THIS.this_dNascs   = loc_dNascs
            THIS.this_dDtnCons = loc_dDtnCons
            IF USED("cursor_4c_LocalCli")
                USE IN cursor_4c_LocalCli
            ENDIF

            *-- 2. Motivos de desconto do SQL Server (SigCdFs + juncoes)
            loc_cSQL = "SELECT a.*, b.Emps, c.Dopes " + ;
                       "FROM SigCdFs a " + ;
                       "LEFT JOIN SigCdFsI b ON a.Codigos = b.Codigos " + ;
                       "LEFT JOIN SigCdFsO c ON a.Codigos = c.Codigos " + ;
                       "WHERE a.Tipos = 'D' AND a.TpDescs <> 2 " + ;
                       "ORDER BY a.Codigos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMdsc2") < 1
                MsgErro("Falha ao carregar motivos de desconto.", "Erro em BuscarMotivos")
                loc_lSucesso = .F.
            ENDIF

            *-- 3. Filtro VFP local por periodo (replica legado: PerInis >= Datas AND PerFins >= Datas)
            SELECT 1 AS Flag, * FROM cursor_4c_LocalMdsc2 ;
                WHERE (ISNULL(PerFins) OR EMPTY(PerFins) OR PerFins >= m.par_dDatas) AND ;
                      (ISNULL(PerInis) OR EMPTY(PerInis) OR PerInis >= m.par_dDatas) ;
                INTO CURSOR cursor_4c_LocalMdsc1 READWRITE

            *-- 4. Marca Flag=0 para registros que falham verificacao de aniversario
            SELECT cursor_4c_LocalMdsc1
            SCAN
                IF ConverterParaLogico(cursor_4c_LocalMdsc1.ChkDtAnivs)
                    IF NOT ( ;
                        (!ISNULL(m.loc_dNascs) AND !EMPTY(m.loc_dNascs) AND MONTH(m.par_dDatas) = MONTH(m.loc_dNascs)) OR ;
                        (!ISNULL(m.loc_dDtnCons) AND !EMPTY(m.loc_dDtnCons) AND MONTH(m.par_dDatas) = MONTH(m.loc_dDtnCons)) ;
                        )
                        REPLACE Flag WITH 0 IN cursor_4c_LocalMdsc1
                    ENDIF
                ENDIF
            ENDSCAN

            *-- 5. Selecao final filtrando por empresa e operacao
            IF USED("cursor_4c_TmpMdsc")
                USE IN cursor_4c_TmpMdsc
            ENDIF
            SELECT DISTINCT Codigos, Descrs FROM cursor_4c_LocalMdsc1 ;
                WHERE NVL(Emps, m.par_cEmpresa) = m.par_cEmpresa ;
                AND NVL(Dopes, m.par_cDopes) = m.par_cDopes ;
                INTO CURSOR cursor_4c_TmpMdsc READWRITE

            SELECT cursor_4c_TmpMdsc
            INDEX ON Codigos TAG Codigos

            IF USED("cursor_4c_LocalMdsc2")
                USE IN cursor_4c_LocalMdsc2
            ENDIF
            IF USED("cursor_4c_LocalMdsc1")
                USE IN cursor_4c_LocalMdsc1
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BuscarMotivos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarMotivo - Verifica codigo em cursor_4c_TmpMdsc e atualiza Descs em xEestDsc
    * par_cCodigos - codigo digitado pelo usuario na coluna Motivo
    * Retorna .T. se encontrado (Descs atualizado); .F. se nao encontrado (Form abre picker)
    *--------------------------------------------------------------------------
    FUNCTION ValidarMotivo(par_cCodigos)
        LOCAL loc_lEncontrado
        loc_lEncontrado = .F.
        TRY
            IF USED("cursor_4c_TmpMdsc")
                IF SEEK(ALLTRIM(m.par_cCodigos), "cursor_4c_TmpMdsc", "Codigos")
                    IF USED("xEestDsc")
                        REPLACE Descs WITH cursor_4c_TmpMdsc.Descrs IN xEestDsc
                    ENDIF
                    loc_lEncontrado = .T.
                ELSE
                    IF USED("xEestDsc")
                        REPLACE Descs WITH ' ' IN xEestDsc
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarMotivo")
        ENDTRY
        RETURN loc_lEncontrado
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDescricao - Limpa Descs quando motivo eh vazio
    * Equivalente ao ELSE de Column1.Text1.Valid quando This.Value eh vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparDescricao()
        IF USED("xEestDsc")
            REPLACE Descs WITH ' ' IN xEestDsc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores gerenciados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            IF USED("cursor_4c_TmpMdsc")
                USE IN cursor_4c_TmpMdsc
            ENDIF
            IF USED("cursor_4c_TotalDcc")
                USE IN cursor_4c_TotalDcc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

