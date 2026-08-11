# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 290: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICO.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (823 linhas total):

*-- Linhas 49 a 57:
49:             ENDIF
50: 
51:             *-- Propriedades dinamicas do form (Caption e Picture requerem CHR/FILE)
52:             THIS.Caption = "Cadastro de " + CHR(205) + "cones"
53:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
54:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
55:             ENDIF
56: 
57:             THIS.LockScreen = .T.

*-- Linhas 67 a 75:
67:                     THIS.grd_4c_Dados.ColumnCount              = 1
68:                     THIS.grd_4c_Dados.RecordSource             = "crTmpcdico"
69:                     THIS.grd_4c_Dados.Column1.ControlSource    = "crTmpcdico.carqicones"
70:                     THIS.grd_4c_Dados.Column1.Header1.Caption  = CHR(205) + "cones"
71:                     THIS.grd_4c_Dados.Visible = .T.
72:                     THIS.grd_4c_Dados.Refresh()
73:                     THIS.AtualizarPreview()
74:                     THIS.grd_4c_Dados.SetFocus()
75:                 ENDIF

*-- Linhas 107 a 157:
107:     *--------------------------------------------------------------------------
108:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
109:         WITH THIS.cnt_4c_Cabecalho
110:             .Top         = -1
111:             .Left        = 0
112:             .Width       = THIS.Width
113:             .Height      = 80
114:             .BorderWidth = 0
115:             .BackStyle   = 1
116:             .BackColor   = RGB(100, 100, 100)
117:             .Visible     = .T.
118:         ENDWITH
119: 
120:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
121:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
122:             .Top           = 18
123:             .Left          = 10
124:             .Width         = 769
125:             .Height        = 40
126:             .FontBold      = .T.
127:             .FontName      = "Tahoma"
128:             .FontSize      = 18
129:             .FontUnderline = .F.
130:             .WordWrap      = .T.
131:             .Alignment     = 0
132:             .BackStyle     = 0
133:             .AutoSize      = .F.
134:             .Caption       = "Cadastro de " + CHR(205) + "cones"
135:             .ForeColor     = RGB(0, 0, 0)
136:             .Visible       = .T.
137:         ENDWITH
138: 
139:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
140:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
141:             .Top       = 17
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 46
145:             .FontBold  = .T.
146:             .FontName  = "Tahoma"
147:             .FontSize  = 18
148:             .WordWrap  = .T.
149:             .Alignment = 0
150:             .BackStyle = 0
151:             .AutoSize  = .F.
152:             .Caption   = "Cadastro de " + CHR(205) + "cones"
153:             .ForeColor = RGB(255, 255, 255)
154:             .Visible   = .T.
155:         ENDWITH
156:     ENDPROC
157: 

*-- Linhas 174 a 183:
174:         THIS.AddObject("grd_4c_Dados", "Grid")
175:         THIS.grd_4c_Dados.ColumnCount = 1
176:         WITH THIS.grd_4c_Dados
177:             .Top               = 85
178:             .Left              = 30
179:             .Width             = 414
180:             .Height            = 526
181:             .ReadOnly          = .T.
182:             .AllowHeaderSizing = .F.
183:             .AllowRowSizing    = .F.

*-- Linhas 213 a 296:
213:         *-- Imagem de preview do icone selecionado (img_4c_Icone) - "Icone" do legado
214:         THIS.AddObject("img_4c_Icone", "Image")
215:         WITH THIS.img_4c_Icone
216:             .Top         = 220
217:             .Left        = 456
218:             .Width       = 305
219:             .Height      = 247
220:             .Stretch     = 1
221:             .BackStyle   = 1
222:             .BorderStyle = 1
223:             .Visible     = .F.
224:         ENDWITH
225: 
226:         *-- CommandGroup de acoes (obj_4c_Commandgroup1) - Commandgroup1 do legado
227:         THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
228:         WITH THIS.obj_4c_Commandgroup1
229:             .Top           = -2
230:             .Left          = 567
231:             .Width         = 237
232:             .Height        = 85
233:             .ButtonCount   = 3
234:             .BackStyle     = 0
235:             .BorderStyle   = 0
236:             .SpecialEffect = 1
237:             .Visible       = .T.
238:         ENDWITH
239: 
240:         WITH THIS.obj_4c_Commandgroup1.Buttons(1)
241:             .AutoSize        = .F.
242:             .Top             = 5
243:             .Left            = 5
244:             .Width           = 75
245:             .Height          = 75
246:             .Caption         = "Incluir"
247:             .ToolTipText     = "Inserir"
248:             .FontBold        = .T.
249:             .FontItalic      = .T.
250:             .FontName        = "Comic Sans MS"
251:             .FontSize        = 8
252:             .WordWrap        = .T.
253:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
254:             .ForeColor       = RGB(90, 90, 90)
255:             .BackColor       = RGB(255, 255, 255)
256:             .Themes          = .F.
257:             .PicturePosition = 13
258:         ENDWITH
259: 
260:         WITH THIS.obj_4c_Commandgroup1.Buttons(2)
261:             .AutoSize        = .F.
262:             .Top             = 5
263:             .Left            = 81
264:             .Width           = 75
265:             .Height          = 75
266:             .Caption         = "Excluir"
267:             .ToolTipText     = "Excluir"
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontName        = "Comic Sans MS"
271:             .FontSize        = 8
272:             .WordWrap        = .T.
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
274:             .ForeColor       = RGB(90, 90, 90)
275:             .BackColor       = RGB(255, 255, 255)
276:             .Themes          = .F.
277:             .PicturePosition = 13
278:         ENDWITH
279: 
280:         WITH THIS.obj_4c_Commandgroup1.Buttons(3)
281:             .Top             = 5
282:             .Left            = 157
283:             .Width           = 75
284:             .Height          = 75
285:             .Caption         = "Encerrar"
286:             .ToolTipText     = "[ESC] Sair"
287:             .Cancel          = .T.
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .FontName        = "Comic Sans MS"
291:             .FontSize        = 8
292:             .WordWrap        = .T.
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
294:             .ForeColor       = RGB(90, 90, 90)
295:             .BackColor       = RGB(255, 255, 255)
296:             .Themes          = .F.

*-- Linhas 331 a 340:
331:         ELSE
332:             THIS.img_4c_Icone.Visible = .F.
333:         ENDIF
334:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
335:             THIS.lbl_4c_NomeIcone.Caption = loc_cNomeArq
336:         ENDIF
337:     ENDPROC
338: 
339:     *--------------------------------------------------------------------------
340:     * GrdDadosScrolled - Atualiza preview ao rolar o grid (Grid1.Scrolled do legado)

*-- Linhas 621 a 675:
621:     * Area entre cabecalho (bottom=79) e imagem (top=220) ~ 140px disponiveis
622:     *--------------------------------------------------------------------------
623:         *-- Instrucao: orienta o usuario a selecionar um icone na lista
624:         THIS.AddObject("lbl_4c_Instrucao", "Label")
625:         WITH THIS.lbl_4c_Instrucao
626:             .Top       = 95
627:             .Left      = 456
628:             .Width     = 320
629:             .Height    = 20
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .FontBold  = .T.
633:             .BackStyle = 0
634:             .AutoSize  = .F.
635:             .Caption   = "Selecione um " + CHR(237) + "cone da lista:"
636:             .ForeColor = RGB(90, 90, 90)
637:             .Visible   = .T.
638:         ENDWITH
639: 
640:         *-- Exibe o nome do arquivo do icone correntemente selecionado no grid
641:         THIS.AddObject("lbl_4c_NomeIcone", "Label")
642:         WITH THIS.lbl_4c_NomeIcone
643:             .Top       = 120
644:             .Left      = 456
645:             .Width     = 320
646:             .Height    = 75
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .FontBold  = .F.
650:             .WordWrap  = .T.
651:             .BackStyle = 0
652:             .AutoSize  = .F.
653:             .Caption   = ""
654:             .ForeColor = RGB(36, 84, 155)
655:             .Visible   = .T.
656:         ENDWITH
657: 
658:         *-- Titulo da secao de preview (imagem do icone selecionado)
659:         THIS.AddObject("lbl_4c_Preview", "Label")
660:         WITH THIS.lbl_4c_Preview
661:             .Top       = 200
662:             .Left      = 456
663:             .Width     = 320
664:             .Height    = 18
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .FontBold  = .T.
668:             .BackStyle = 0
669:             .AutoSize  = .F.
670:             .Caption   = "Pr" + CHR(233) + "via:"
671:             .ForeColor = RGB(90, 90, 90)
672:             .Visible   = .T.
673:         ENDWITH
674:     ENDPROC
675: 

*-- Linhas 685 a 693:
685:                 THIS.grd_4c_Dados.ColumnCount             = 1
686:                 THIS.grd_4c_Dados.RecordSource            = "crTmpcdico"
687:                 THIS.grd_4c_Dados.Column1.ControlSource   = "crTmpcdico.carqicones"
688:                 THIS.grd_4c_Dados.Column1.Header1.Caption = CHR(205) + "cones"
689:                 THIS.grd_4c_Dados.Visible = .T.
690:                 THIS.grd_4c_Dados.Refresh()
691:                 THIS.AtualizarPreview()
692:                 THIS.HabilitarCampos()
693:             ENDIF

*-- Linhas 749 a 758:
749:     * BOParaForm - Sincroniza o BO com a area de preview e label de nome
750:     *--------------------------------------------------------------------------
751:     PROCEDURE BOParaForm()
752:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
753:             THIS.lbl_4c_NomeIcone.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cCarqIcones)
754:         ENDIF
755:         IF PEMSTATUS(THIS, "img_4c_Icone", 5)
756:             LOCAL loc_cArq
757:             loc_cArq = ALLTRIM(THIS.this_oBusinessObject.this_cCtmpIcones)
758:             IF !EMPTY(loc_cArq) AND FILE(loc_cArq)

*-- Linhas 783 a 792:
783:             THIS.img_4c_Icone.Picture = ""
784:             THIS.img_4c_Icone.Visible = .F.
785:         ENDIF
786:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
787:             THIS.lbl_4c_NomeIcone.Caption = ""
788:         ENDIF
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------
792:     * AjustarBotoesPorModo - Form OPERACIONAL flat: delega para HabilitarCampos


### BO (C:\4c\projeto\app\classes\ICOBO.prg):
*==============================================================================
* ICOBO.prg - Business Object: Cadastro de Icones (SigSyIco)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS ICOBO AS BusinessBase

    *-- Cursor de dados exibido no grid
    this_cCursorDados   = "crTmpcdico"

    *-- Nome do arquivo de icone selecionado/atual
    this_cCarqIcones    = ""

    *-- Conteudo binario do icone (MEMO)
    this_cMarqIcones    = ""

    *-- Caminho temporario do arquivo extraido para exibicao
    this_cCtmpIcones    = ""

    *-- Diretorio temporario usado para extracao dos icones
    this_cDirTemp       = ""

    *-- Indica se os icones ja foram carregados no cursor
    this_lCarregado     = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela      = "SigSyIco"
        THIS.this_cCampoChave  = "carqicones"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave primaria atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCarqIcones)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCarqIcones = TratarNulo(carqicones, "C")
            THIS.this_cMarqIcones = NVL(marqicones, "")
            IF TYPE("ctmpicones") != "U"
                THIS.this_cCtmpIcones = ALLTRIM(ctmpicones)
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarIcones - Carrega todos os icones do SQL Server para crTmpcdico
    *   par_cDirTemp: diretorio temporario para extrair arquivos de icone
    *--------------------------------------------------------------------------
    FUNCTION CarregarIcones(par_cDirTemp)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_cDirTemp = ADDBS(par_cDirTemp)

            *-- Fechar cursores anteriores
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            IF USED("crTmpcdico")
                USE IN crTmpcdico
            ENDIF

            *-- Criar cursor principal com estrutura identica ao legado
            SET NULL ON
            CREATE CURSOR crTmpcdico ( ;
                carqicones  C(128) NULL, ;
                marqicones  M NULL, ;
                ctmpicones  C(255) NULL ;
            )
            SET NULL OFF

            *-- Carregar dados do SQL Server
            LOCAL loc_cSQL
            loc_cSQL = "SELECT carqicones, marqicones FROM SigSyIco ORDER BY carqicones"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpcdico_Temp")
            IF loc_nResult > 0
                *-- Declarar variaveis do SCAN antes do loop
                LOCAL loc_cNome, loc_cArqTemp, loc_nTam
                loc_cNome    = ""
                loc_cArqTemp = ""
                loc_nTam     = 0

                IF USED("crTmpcdico_Temp") AND RECCOUNT("crTmpcdico_Temp") > 0
                    SELECT crTmpcdico_Temp
                    SCAN
                        loc_cNome    = ALLTRIM(crTmpcdico_Temp.carqicones)
                        loc_cArqTemp = ""

                        *-- Extrair conteudo binario para arquivo temporario
                        IF !EMPTY(crTmpcdico_Temp.marqicones)
                            loc_cArqTemp = THIS.this_cDirTemp + "ArqIcone" + SYS(2015) + ".ico"
                            loc_nTam = STRTOFILE(crTmpcdico_Temp.marqicones, loc_cArqTemp)
                            IF loc_nTam > 0
                                loc_cArqTemp = LOWER(loc_cArqTemp)
                            ELSE
                                loc_cArqTemp = ""
                            ENDIF
                        ENDIF

                        *-- Popular cursor principal
                        SELECT crTmpcdico
                        APPEND BLANK
                        REPLACE carqicones WITH loc_cNome
                        REPLACE marqicones WITH crTmpcdico_Temp.marqicones
                        REPLACE ctmpicones WITH loc_cArqTemp
                        SELECT crTmpcdico_Temp
                    ENDSCAN
                ENDIF

                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF

                *-- Indexar e posicionar no inicio
                SELECT crTmpcdico
                INDEX ON carqicones TAG carqicones
                SET ORDER TO carqicones IN crTmpcdico
                GO TOP IN crTmpcdico

                THIS.this_lCarregado = .T.
                loc_lResultado = .T.
            ELSE
                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao carregar " + CHR(237) + "cones: " + loc_aErros[1,2], "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar " + CHR(205) + "cones")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo icone no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "INSERT INTO SigSyIco (carqicones, marqicones) VALUES (?loc_cNome, ?loc_mConteudo)"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao inserir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Inserir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza icone existente no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "UPDATE SigSyIco SET marqicones = ?loc_mConteudo WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao atualizar " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Atualizar " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui icone do SQL Server (chamado por Excluir())
    *   Requer this_cCarqIcones populado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_cSQL
            loc_cSQL = "DELETE FROM SigSyIco WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao excluir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Excluir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Excluir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoIcone - Verifica se icone esta referenciado em SigCdPrg.barrapict
    *   par_cNomeIcone: nome do arquivo (carqicones)
    *   Retorna .T. se em uso (nao pode excluir)
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoIcone(par_cNomeIcone)
        LOCAL loc_lEmUso, loc_oErro
        loc_lEmUso = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(par_cNomeIcone)

            LOCAL loc_cSQL
            loc_cSQL = "SELECT COUNT(*) AS nQtd FROM SigCdPrg WHERE barrapict = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVerificaUsoIco")
            IF loc_nResult > 0
                IF USED("crVerificaUsoIco")
                    loc_lEmUso = (NVL(crVerificaUsoIco.nQtd, 0) > 0)
                    USE IN crVerificaUsoIco
                ENDIF
            ELSE
                IF USED("crVerificaUsoIco")
                    USE IN crVerificaUsoIco
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("crVerificaUsoIco")
                USE IN crVerificaUsoIco
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Verificar Uso do " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lEmUso
    ENDFUNC

ENDDEFINE

