# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 196: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 222: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPREST.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (458 linhas total):

*-- Linhas 84 a 137:
84: 
85:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
86:         WITH THIS.cnt_4c_Cabecalho
87:             .Top        = -1
88:             .Left       = -1
89:             .Width      = THIS.Width
90:             .Height     = 80
91:             .BackStyle  = 1
92:             .BackColor  = RGB(100,100,100)
93:             .BorderWidth = 0
94:             .Visible     = .T.
95:         ENDWITH
96: 
97:         loc_oCab = THIS.cnt_4c_Cabecalho
98: 
99:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
100:         WITH loc_oCab.lbl_4c_Sombra
101:             .Top          = 18
102:             .Left         = 10
103:             .Width        = THIS.Width
104:             .Height       = 40
105:             .AutoSize     = .F.
106:             .FontBold     = .T.
107:             .FontName     = "Tahoma"
108:             .FontSize     = 18
109:             .FontUnderline = .F.
110:             .WordWrap     = .T.
111:             .Alignment    = 0
112:             .BackStyle    = 0
113:             .ForeColor    = RGB(0,0,0)
114:             .Caption      = "Gerar Estrutura"
115:         ENDWITH
116: 
117:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
118:         WITH loc_oCab.lbl_4c_Titulo
119:             .Top          = 17
120:             .Left         = 10
121:             .Width        = THIS.Width
122:             .Height       = 46
123:             .AutoSize     = .F.
124:             .FontBold     = .T.
125:             .FontName     = "Tahoma"
126:             .FontSize     = 18
127:             .WordWrap     = .T.
128:             .Alignment    = 0
129:             .BackStyle    = 0
130:             .ForeColor    = RGB(255,255,255)
131:             .ToolTipText  = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
132:             .Caption      = "Gerar Estrutura"
133:         ENDWITH
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente

*-- Linhas 169 a 303:
169:     *--------------------------------------------------------------------------
170:     PROTECTED PROCEDURE ConfigurarPaginaLista()
171: 
172:         *-- Shape decorativo que agrupa os checkboxes visualmente
173:         THIS.AddObject("shp_4c_Shape1", "Shape")
174:         WITH THIS.shp_4c_Shape1
175:             .Top           = 9
176:             .Left          = 49
177:             .Height        = 110
178:             .Width         = 173
179:             .BackStyle     = 0
180:             .BorderStyle   = 0
181:             .SpecialEffect = 0
182:         ENDWITH
183: 
184:         *-- Botao Gerar (cmd_4c_OK)
185:         THIS.AddObject("cmd_4c_OK", "CommandButton")
186:         WITH THIS.cmd_4c_OK
187:             .Top             = 3
188:             .Left            = 450
189:             .Width           = 75
190:             .Height          = 75
191:             .Caption         = "Gerar"
192:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
193:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .FontName        = "Comic Sans MS"
197:             .FontSize        = 8
198:             .ForeColor       = RGB(90,90,90)
199:             .BackColor       = RGB(255,255,255)
200:             .Themes          = .T.
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:             .PicturePosition = 13
204:             .SpecialEffect   = 0
205:             .MousePointer    = 15
206:         ENDWITH
207:         BINDEVENT(THIS.cmd_4c_OK, "Click", THIS, "BtnOKClick")
208: 
209:         *-- Botao Encerrar (cmd_4c_Cancela)
210:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
211:         WITH THIS.cmd_4c_Cancela
212:             .Top             = 3
213:             .Left            = 525
214:             .Width           = 75
215:             .Height          = 75
216:             .Caption         = "Encerrar"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
218:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
219:             .Cancel          = .T.
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .FontName        = "Comic Sans MS"
223:             .FontSize        = 8
224:             .ForeColor       = RGB(90,90,90)
225:             .BackColor       = RGB(255,255,255)
226:             .Themes          = .T.
227:             .WordWrap        = .T.
228:             .AutoSize        = .F.
229:             .PicturePosition = 13
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:         ENDWITH
233:         BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelaClick")
234:     ENDPROC
235: 
236:     *--------------------------------------------------------------------------
237:     * ConfigurarPaginaDados - Campos de entrada do dialogo (checkboxes + status)
238:     * SIGPREST eh utilitario sem PageFrame, entao "Dados" aqui sao os controles
239:     * de entrada do usuario (opcoes de processamento) e a label de status.
240:     *--------------------------------------------------------------------------
241:     PROTECTED PROCEDURE ConfigurarPaginaDados()
242: 
243:         *-- Checkbox: Gerar Estrutura
244:         THIS.AddObject("chk_4c_GeraArquivos", "CheckBox")
245:         WITH THIS.chk_4c_GeraArquivos
246:             .Top        = 90
247:             .Left       = 55
248:             .Width      = 75
249:             .Height     = 75
250:             .Caption    = "Estrutura"
251:             .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
252:             .FontBold   = .T.
253:             .FontItalic = .T.
254:             .FontName   = "Comic Sans MS"
255:             .FontSize   = 8
256:             .Alignment  = 2
257:             .BackStyle  = 1
258:             .BackColor  = RGB(255,255,255)
259:             .ForeColor  = RGB(90,90,90)
260:             .Themes     = .F.
261:             .WordWrap   = .T.
262:             .AutoSize   = .F.
263:             .Style      = 1
264:             .Value      = 1
265:         ENDWITH
266: 
267:         *-- Checkbox: Gerar Indices
268:         THIS.AddObject("chk_4c_GeraIndices", "CheckBox")
269:         WITH THIS.chk_4c_GeraIndices
270:             .Top        = 90
271:             .Left       = 136
272:             .Width      = 75
273:             .Height     = 75
274:             .Caption    = CHR(205) + "ndice"
275:             .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
276:             .FontBold   = .T.
277:             .FontItalic = .T.
278:             .FontName   = "Comic Sans MS"
279:             .FontSize   = 8
280:             .Alignment  = 2
281:             .BackStyle  = 1
282:             .BackColor  = RGB(255,255,255)
283:             .ForeColor  = RGB(90,90,90)
284:             .Themes     = .F.
285:             .WordWrap   = .T.
286:             .AutoSize   = .F.
287:             .Style      = 1
288:             .Value      = 1
289:         ENDWITH
290: 
291:         *-- Label de status do processamento
292:         THIS.AddObject("lbl_4c_Mensagem1", "Label")
293:         WITH THIS.lbl_4c_Mensagem1
294:             .Top       = 132
295:             .Left      = 48
296:             .Width     = 480
297:             .Height    = 24
298:             .Caption   = ""
299:             .Alignment = 2
300:             .BackStyle = 0
301:             .FontBold  = .T.
302:             .FontName  = "Tahoma"
303:             .FontSize  = 11

*-- Linhas 343 a 352:
343:     *--------------------------------------------------------------------------
344:     * BtnAlterarClick - Re-executa a geracao (re-processa estrutura/indices)
345:     * Em um dialogo de utilitario, "Alterar" = re-rodar o processamento com as
346:     * opcoes correntes dos checkboxes (Estrutura/Indice). Delegacao explicita
347:     * para BtnOKClick que ja carrega o estado dos checkboxes e chama o BO.
348:     *--------------------------------------------------------------------------
349:     PROCEDURE BtnAlterarClick()
350:         THIS.BtnOKClick()
351:     ENDPROC
352: 

*-- Linhas 399 a 439:
399:     ENDPROC
400: 
401:     *--------------------------------------------------------------------------
402:     * FormParaBO - Transfere opcoes dos checkboxes para o Business Object
403:     *--------------------------------------------------------------------------
404:     PROTECTED PROCEDURE FormParaBO()
405:         THIS.this_oBusinessObject.this_lGeraArquivos = (THIS.chk_4c_GeraArquivos.Value = 1)
406:         THIS.this_oBusinessObject.this_lGeraIndices  = (THIS.chk_4c_GeraIndices.Value = 1)
407:     ENDPROC
408: 
409:     *--------------------------------------------------------------------------
410:     * BOParaForm - Atualiza controles do dialogo com estado do Business Object
411:     *--------------------------------------------------------------------------
412:     PROTECTED PROCEDURE BOParaForm()
413:         THIS.chk_4c_GeraArquivos.Value = IIF(THIS.this_oBusinessObject.this_lGeraArquivos, 1, 0)
414:         THIS.chk_4c_GeraIndices.Value  = IIF(THIS.this_oBusinessObject.this_lGeraIndices, 1, 0)
415:         THIS.lbl_4c_Mensagem1.Caption  = THIS.this_oBusinessObject.this_cMensagem
416:     ENDPROC
417: 
418:     *--------------------------------------------------------------------------
419:     * HabilitarCampos - Habilita ou desabilita controles de entrada
420:     *--------------------------------------------------------------------------
421:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
422:         THIS.chk_4c_GeraArquivos.Enabled = par_lHabilitar
423:         THIS.chk_4c_GeraIndices.Enabled  = par_lHabilitar
424:         THIS.cmd_4c_OK.Enabled           = par_lHabilitar
425:         THIS.cmd_4c_Cancela.Enabled      = par_lHabilitar
426:     ENDPROC
427: 
428:     *--------------------------------------------------------------------------
429:     * LimparCampos - Restaura controles para valores padrao
430:     *--------------------------------------------------------------------------
431:     PROTECTED PROCEDURE LimparCampos()
432:         THIS.chk_4c_GeraArquivos.Value = 1
433:         THIS.chk_4c_GeraIndices.Value  = 1
434:         THIS.lbl_4c_Mensagem1.Caption  = ""
435:     ENDPROC
436: 
437:     *--------------------------------------------------------------------------
438:     * CarregarLista - Nao aplicavel a este dialogo (sem grid de lista)
439:     *--------------------------------------------------------------------------

*-- Linhas 445 a 458:
445:     * AjustarBotoesPorModo - Dialogo utilitario: botoes sempre visiveis/habilitados
446:     *--------------------------------------------------------------------------
447:     PROTECTED PROCEDURE AjustarBotoesPorModo()
448:         IF PEMSTATUS(THIS, "cmd_4c_OK", 5)
449:             THIS.cmd_4c_OK.Visible      = .T.
450:             THIS.cmd_4c_OK.Enabled      = .T.
451:         ENDIF
452:         IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
453:             THIS.cmd_4c_Cancela.Visible = .T.
454:             THIS.cmd_4c_Cancela.Enabled = .T.
455:         ENDIF
456:     ENDPROC
457: 
458: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRESTBO.prg):
*------------------------------------------------------------------------------
* SIGPRESTBO.prg - Business Object para Gerar Estrutura de Arquivos DBF
* Herdado de: BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS SIGPRESTBO AS BusinessBase

    *-- Configuracao da entidade (sem tabela SQL Server - opera em DBFs locais)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Opcoes de processamento (mapeiam checkboxes do form)
    this_lGeraArquivos = .T.
    this_lGeraIndices  = .T.

    *-- Estado do processamento
    this_cMensagem    = ""
    this_cDiretorioBase = ""
    this_lProcessando = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso

        TRY
            loc_lSucesso = DODEFAULT()
            IF !loc_lSucesso
                loc_lSucesso = .F.
            ENDIF

            this_cTabela        = ""
            this_cCampoChave    = ""
            this_lGeraArquivos  = .T.
            this_lGeraIndices   = .T.
            this_cMensagem      = ""
            this_cDiretorioBase = ""
            this_lProcessando   = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *--------------------------------------------------------------------------
        IF !this_lGeraArquivos AND !this_lGeraIndices
            this_cMensagemErro = "Selecione pelo menos uma op" + CHR(231) + ;
                CHR(227) + "o de gera" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Inserir()
    *--------------------------------------------------------------------------
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarEstrutura - Gera ArqDBF.dbf (estrutura) e ArqInd.dbf (indices)
    * a partir de todos os .DBF encontrados no diretorio basededados\
    *--------------------------------------------------------------------------
    FUNCTION GerarEstrutura(par_lGeraArquivos, par_lGeraIndices)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_loBarra, loc_lnArq, loc_lcArquivo
        LOCAL loc_lnGeraArq, loc_lnGeraInd, loc_lnCampos, loc_lnCCampos
        LOCAL loc_lcDbc, loc_lnKey, loc_lcChave, loc_lcFiltro, loc_lcTag
        LOCAL loc_lcDirAtual, loc_lInterrompido
        LOCAL ARRAY loc_laArq[1]
        LOCAL ARRAY loc_laCampos[1]

        loc_lSucesso      = .F.
        loc_lInterrompido = .F.
        loc_lcDirAtual    = ADDBS(SYS(5)) + CURDIR()

        TRY
            this_lProcessando = .T.
            this_cMensagem    = ""

            CLOSE TABLES ALL
            SET DEFAULT TO ".\basededados\"

            IF par_lGeraArquivos

                SELECT 0

                CREATE TABLE ArqDBF FREE ;
                    ( Arquivos c(20), Dbcs c(50), Campos c(20), Tipos c(1), ;
                      Tamanhos n(3), Fracaos n(2), C_05s l, C_06s l, ;
                      C_07s c(20), C_08s c(20), C_09s c(20), C_10s c(20), ;
                      C_11s c(20), C_12s c(20), C_13s c(20), C_14s c(20), ;
                      C_15s c(20), C_16s c(20) )

                INDEX ON Arquivos + Campos TAG ArqCamp

                loc_lnArq = ADIR(loc_laArq, "*.Dbf")
                =ASORT(loc_laArq)

                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Processando Estrutura de Arquivos.", loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show()

                FOR loc_lnGeraArq = 1 TO loc_lnArq

                    loc_lcArquivo = loc_laArq(loc_lnGeraArq, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        "Processando Arquivo : " + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(loc_lcArquivo), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                        LOOP
                    ENDIF

                    USE (loc_lcArquivo) IN 0 ALIAS TmpArquivo AGAIN

                    SELECT TmpArquivo
                    loc_lcDbc    = ALLTRIM(JUSTFNAME(CURSORGETPROP("DataBase")))
                    loc_lnCampos = AFIELDS(loc_laCampos)

                    FOR loc_lnCCampos = 1 TO loc_lnCampos

                        IF loc_lnCCampos = 1
                            IF EMPTY(loc_laCampos(loc_lnCCampos, 12))
                                loc_laCampos(loc_lnCCampos, 12) = ;
                                    STRTRAN(loc_lcArquivo, ".DBF", "")
                            ENDIF
                        ENDIF

                        SELECT ArqDBF
                        INSERT INTO ArqDBF ;
                            ( Arquivos, Dbcs, Campos, Tipos, Tamanhos, Fracaos, ;
                              C_05s, C_06s, C_07s, C_08s, C_09s, C_10s, ;
                              C_11s, C_12s, C_13s, C_14s, C_15s, C_16s ) ;
                            VALUES ;
                            ( loc_lcArquivo, loc_lcDbc, ;
                              loc_laCampos(loc_lnCCampos, 1), loc_laCampos(loc_lnCCampos, 2), ;
                              loc_laCampos(loc_lnCCampos, 3), loc_laCampos(loc_lnCCampos, 4), ;
                              loc_laCampos(loc_lnCCampos, 5), loc_laCampos(loc_lnCCampos, 6), ;
                              loc_laCampos(loc_lnCCampos, 7), loc_laCampos(loc_lnCCampos, 8), ;
                              loc_laCampos(loc_lnCCampos, 9), loc_laCampos(loc_lnCCampos, 10), ;
                              loc_laCampos(loc_lnCCampos, 11), loc_laCampos(loc_lnCCampos, 12), ;
                              loc_laCampos(loc_lnCCampos, 13), loc_laCampos(loc_lnCCampos, 14), ;
                              loc_laCampos(loc_lnCCampos, 15), loc_laCampos(loc_lnCCampos, 16) )

                    ENDFOR

                    USE IN TmpArquivo

                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de Estrutura.")

            ENDIF

            CLOSE TABLES ALL

            IF par_lGeraIndices AND !FILE("ArqDBF.Dbf")
                MsgAviso("Antes de gerar os " + CHR(237) + "ndices, " + CHR(233) + ;
                    " necess" + CHR(225) + "rio que seja gerada a Estrutura de Arquivos...", "")
                this_cMensagem    = "Processamento Interrompido."
                this_lProcessando = .F.
                loc_lInterrompido = .T.
            ENDIF

            IF par_lGeraIndices AND !loc_lInterrompido

                SELECT 0
                USE ArqDBF ORDER ArqCamp

                loc_lnArq = ADIR(loc_laArq, "*.Dbf")
                =ASORT(loc_laArq)

                IF FILE("ArqInd.Dbf")
                    DELETE FILE ArqInd.Dbf
                    DELETE FILE ArqInd.Cdx
                ENDIF

                CREATE TABLE ArqInd FREE ;
                    ( Arquivos c(20), Tags c(15), Indices c(240), ;
                      Filtros c(240), Indexs l, c_12s c(20) )
                INDEX ON Arquivos + Tags TAG Arquivos
                INDEX ON Arquivos TAG Temp UNIQUE

                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Processando " + CHR(205) + "ndices de Arquivos.", loc_lnArq)
                loc_loBarra.Titulo.FontBold = .T.
                loc_loBarra.Show()

                FOR loc_lnGeraInd = 1 TO loc_lnArq

                    loc_lcArquivo = loc_laArq(loc_lnGeraInd, 1)

                    loc_loBarra.Update(.T.)
                    loc_loBarra.SubTitulo.Caption = ;
                        "Processando Arquivo : " + ALLTRIM(loc_lcArquivo)

                    IF INLIST(ALLTRIM(loc_lcArquivo), "ARQDBF.DBF", "ARQIND.DBF", "FOXUSER.DBF")
                        LOOP
                    ENDIF

                    SELECT 0
                    USE (loc_lcArquivo) ALIAS TmpArquivo AGAIN

                    loc_lnKey = 1
                    DO WHILE !EMPTY(TAG(loc_lnKey))
                        loc_lcChave  = KEY(loc_lnKey)
                        loc_lcFiltro = SYS(2021, loc_lnKey)
                        loc_lcTag    = TAG(loc_lnKey)
                        INSERT INTO ArqInd ( Arquivos, Tags, Indices, Filtros ) ;
                            VALUES ( loc_lcArquivo, loc_lcTag, loc_lcChave, loc_lcFiltro )
                        SELECT TmpArquivo
                        loc_lnKey = loc_lnKey + 1
                    ENDDO

                    USE

                ENDFOR

                loc_loBarra.Complete("Finalizando Processo de " + CHR(205) + "ndice.")

            ENDIF

            IF !loc_lInterrompido
                CLOSE TABLES ALL
                this_cMensagem    = "Processamento Finalizado."
                this_lProcessando = .F.
                loc_lSucesso      = .T.
                SET DEFAULT TO (loc_lcDirAtual)
                THIS.CarregarLogoTipo()
            ELSE
                SET DEFAULT TO (loc_lcDirAtual)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, ;
                "Erro na Gera" + CHR(231) + CHR(227) + "o de Estrutura")
            this_cMensagem    = "Erro no processamento."
            this_lProcessando = .F.
            loc_lSucesso      = .F.

            TRY
                CLOSE TABLES ALL
                SET DEFAULT TO (loc_lcDirAtual)
            CATCH
            ENDTRY
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarLogoTipo - Garante cursor csLogoTipo disponivel (usado pelo sistema)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLogoTipo()
    *--------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            IF !USED("csLogoTipo")
                SQLEXEC(gnConnHandle, "SELECT Logos FROM SigCdPam", "csLogoTipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar logo")
        ENDTRY
    ENDPROC

ENDDEFINE

