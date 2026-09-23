# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 340: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 357: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormVca.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1034 linhas total):

*-- Linhas 45 a 53:
45:     * Init - define Caption com CHR() antes de delegar ao FormBase
46:     *--------------------------------------------------------------------------
47:     PROCEDURE Init()
48:         THIS.Caption = "Cadastro de Testes"
49: 
50:         *-- WindowType=1 (modal) causaria TIMEOUT no harness de validacao de UI
51:         *-- (top-level window bloqueante). Classe definida com WindowType=0;
52:         *-- producao eleva para modal aqui, fora dos modos de teste/validacao.
53:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;

*-- Linhas 78 a 87:
78: 
79:                 THIS.ConfigurarPageFrame()
80: 
81:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
83: 
84:                 THIS.TornarControlesVisiveis(THIS)
85: 
86:                 *-- SQL so roda fora do modo de validacao de UI (sem conexao)
87:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 119 a 170:
119:     PROTECTED PROCEDURE ConfigurarCabecalho()
120:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH THIS.cnt_4c_Cabecalho
122:             .Top         = 0
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BackStyle   = 1
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
133:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
134:             .Top           = 18
135:             .Left          = 10
136:             .Width         = 769
137:             .Height        = 40
138:             .AutoSize      = .F.
139:             .BackStyle     = 0
140:             .WordWrap      = .T.
141:             .Alignment     = 0
142:             .FontName      = "Tahoma"
143:             .FontSize      = 18
144:             .FontBold      = .T.
145:             .FontUnderline = .F.
146:             .ForeColor     = RGB(0, 0, 0)
147:             .Caption       = THIS.Caption
148:         ENDWITH
149: 
150:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Top         = 17
153:             .Left        = 10
154:             .Width       = 769
155:             .Height      = 46
156:             .AutoSize    = .F.
157:             .BackStyle   = 0
158:             .WordWrap    = .T.
159:             .Alignment   = 0
160:             .FontName    = "Tahoma"
161:             .FontSize    = 18
162:             .FontBold    = .T.
163:             .ForeColor   = RGB(255, 255, 255)
164:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
165:             .Caption     = THIS.Caption
166:         ENDWITH
167:     ENDPROC
168: 
169:     *--------------------------------------------------------------------------
170:     * ConfigurarGrid - cria a grade de vinculos (Grade do legado)

*-- Linhas 178 a 187:
178:         THIS.AddObject("grd_4c_Dados", "Grid")
179:         loc_oGrid = THIS.grd_4c_Dados
180:         WITH loc_oGrid
181:             .Top           = 95
182:             .Left          = 86
183:             .Width         = 585
184:             .Height        = 290
185:             .ColumnCount   = 5
186:             .FontName      = "Arial"
187:             .FontSize      = 8

*-- Linhas 204 a 212:
204:             .FontName  = "Arial"
205:             .FontSize  = 8
206:             .Alignment = 2
207:             .Caption   = "Conta"
208:         ENDWITH
209:         WITH loc_oGrid.Column1.Text1
210:             .FontName    = "Arial"
211:             .FontSize    = 8
212:             .BorderStyle = 0

*-- Linhas 224 a 232:
224:             .FontName  = "Arial"
225:             .FontSize  = 8
226:             .Alignment = 2
227:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
228:         ENDWITH
229:         WITH loc_oGrid.Column2.Text1
230:             .FontName    = "Arial"
231:             .FontSize    = 8
232:             .BorderStyle = 0

*-- Linhas 245 a 253:
245:             .FontName  = "Arial"
246:             .FontSize  = 8
247:             .Alignment = 2
248:             .Caption   = "Usu" + CHR(225) + "rio"
249:         ENDWITH
250:         WITH loc_oGrid.Column3.Text1
251:             .FontName    = "Arial"
252:             .FontSize    = 8
253:             .BorderStyle = 0

*-- Linhas 265 a 273:
265:             .FontName  = "Arial"
266:             .FontSize  = 8
267:             .Alignment = 2
268:             .Caption   = "Nome"
269:         ENDWITH
270:         WITH loc_oGrid.Column4.Text1
271:             .FontName    = "Arial"
272:             .FontSize    = 8
273:             .BorderStyle = 0

*-- Linhas 284 a 292:
284:             .FontName  = "Arial"
285:             .FontSize  = 8
286:             .Alignment = 2
287:             .Caption   = "Departamento"
288:         ENDWITH
289:         WITH loc_oGrid.Column5.Text1
290:             .FontName    = "Arial"
291:             .FontSize    = 8
292:             .BorderStyle = 0

*-- Linhas 312 a 407:
312:     *--------------------------------------------------------------------------
313:     * ConfigurarBotoes - cria os botoes de acao do form
314:     * Grupo_Botao (legado) -> cmg_4c_Botoes: Buttons(1)=Salvar, Buttons(2)=Encerrar
315:     * btnMarca (legado)    -> cmd_4c_Incluir (adiciona linha em branco na grade)
316:     * btnExcluir (legado)  -> cmd_4c_Excluir (exclui linha corrente da grade)
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE ConfigurarBotoes()
319:         LOCAL loc_oCmg
320: 
321:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
322:         loc_oCmg = THIS.cmg_4c_Botoes
323:         WITH loc_oCmg
324:             .Top          = -2
325:             .Left         = 645
326:             .Width        = 160
327:             .Height       = 85
328:             .ButtonCount  = 2
329:             .BackStyle    = 0
330:             .BorderStyle  = 0
331:         ENDWITH
332: 
333:         WITH loc_oCmg.Buttons(1)
334:             .Top         = 5
335:             .Left        = 5
336:             .Width       = 75
337:             .Height      = 75
338:             .Caption     = "\<Salvar"
339:             .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
340:             .FontName    = "Comic Sans MS"
341:             .FontBold    = .T.
342:             .FontItalic  = .T.
343:             .FontSize    = 8
344:             .WordWrap    = .T.
345:             .ForeColor   = RGB(90, 90, 90)
346:             .BackColor   = RGB(255, 255, 255)
347:             .Themes      = .F.
348:         ENDWITH
349: 
350:         WITH loc_oCmg.Buttons(2)
351:             .Top         = 5
352:             .Left        = 80
353:             .Width       = 75
354:             .Height      = 75
355:             .Caption     = "Encerrar"
356:             .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
357:             .FontName    = "Comic Sans MS"
358:             .FontBold    = .T.
359:             .FontItalic  = .T.
360:             .FontSize    = 8
361:             .WordWrap    = .T.
362:             .ForeColor   = RGB(90, 90, 90)
363:             .BackColor   = RGB(255, 255, 255)
364:             .Themes      = .F.
365:         ENDWITH
366: 
367:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnSalvarClick")
368:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnEncerrarClick")
369: 
370:         THIS.AddObject("cmd_4c_Incluir", "CommandButton")
371:         WITH THIS.cmd_4c_Incluir
372:             .Top         = 211
373:             .Left = 5
374:             .Width       = 40
375:             .Height      = 40
376:             .Caption     = ""
377:             .Picture     = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
378:             .ToolTipText = "Incluir"
379:             .FontName    = "Arial"
380:             .FontSize    = 7
381:             .ForeColor   = RGB(255, 0, 0)
382:             .BackColor   = RGB(255, 255, 255)
383:             .Themes           = .T.
384:         ENDWITH
385:         BINDEVENT(THIS.cmd_4c_Incluir, "Click", THIS, "CmdIncluirClick")
386: 
387:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
388:         WITH THIS.cmd_4c_Excluir
389:             .Top         = 252
390:             .Left = 230
391:             .Width       = 40
392:             .Height      = 40
393:             .Caption     = ""
394:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
395:             .ToolTipText = "Excluir"
396:             .FontName    = "Arial"
397:             .FontSize    = 7
398:             .ForeColor   = RGB(255, 0, 0)
399:             .BackColor   = RGB(255, 255, 255)
400:             .Themes           = .T.
401:         ENDWITH
402:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
403:     ENDPROC
404: 
405:     *--------------------------------------------------------------------------
406:     * CarregarLista - popula cursor_4c_Dados via BO e vincula a grade
407:     * Equivale ao MontaGrade() do legado, chamado apos o Init popular o cursor

*-- Linhas 428 a 440:
428:             .Column4.ControlSource = "cursor_4c_Dados.Usuario"
429:             .Column5.ControlSource = "cursor_4c_Dados.Deptos"
430: 
431:             .Column1.Header1.Caption = "Conta"
432:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
433:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
434:             .Column4.Header1.Caption = "Nome"
435:             .Column5.Header1.Caption = "Departamento"
436: 
437:             .Column1.Width = 70
438:             .Column2.Width = 170
439:             .Column3.Width = 70
440:             .Column4.Width = 170

*-- Linhas 854 a 870:
854: 
855:     *--------------------------------------------------------------------------
856:     * BtnIncluirClick - alias canonico do evento principal de inclusao
857:     * (delega para CmdIncluirClick, ligado ao cmd_4c_Incluir/btnMarca legado)
858:     *--------------------------------------------------------------------------
859:     PROCEDURE BtnIncluirClick()
860:         THIS.CmdIncluirClick()
861:     ENDPROC
862: 
863:     *--------------------------------------------------------------------------
864:     * BtnExcluirClick - alias canonico do evento principal de exclusao
865:     * (delega para CmdExcluirClick, ligado ao cmd_4c_Excluir/btnExcluir legado)
866:     *--------------------------------------------------------------------------
867:     PROCEDURE BtnExcluirClick()
868:         THIS.CmdExcluirClick()
869:     ENDPROC
870: 


### BO (C:\4c\projeto\app\classes\VcaBO.prg):
*==============================================================================
* VcaBO.prg - Business Object para Vinculo Cliente x Vendedor (SIGALTDT)
* Tabela Principal: SigCdVca (PK: pkchaves)
* Tabelas Relacionadas:
*   - SigCdCli (dados do cliente - rclis)
*   - SigCdUsu (dados do usuario/vendedor responsavel - ncomps, deptos)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS VcaBO AS BusinessBase

    *-- Propriedades: SigCdVca
    this_cIclis    = ""   && iclis char(10) NOT NULL - codigo do cliente (SigCdCli.Iclis)
    this_cResp     = ""   && resp char(20) NOT NULL - codigo do usuario responsavel (SigCdUsu.Usuarios)
    this_cPkChaves = ""   && pkchaves char(20) NOT NULL - PK (gerada com fUniqueIds())

    *-- Propriedades de exibicao (JOIN - nao persistidas em SigCdVca)
    this_cRclis    = ""   && SigCdCli.rclis char(50) - razao/nome do cliente
    this_cUsuario  = ""   && SigCdUsu.ncomps char(30) - nome do usuario responsavel (alias "usuario" na query legado)
    this_cDeptos   = ""   && SigCdUsu.deptos char(10) - departamento do usuario responsavel

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdVca"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * Cursor pode vir da query com JOIN (rclis/usuario/deptos presentes) ou de
    * um SELECT simples em SigCdVca (so iclis/resp/pkchaves) - por isso as
    * colunas de exibicao sao lidas com TYPE() antes de acessar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cIclis    = TratarNulo(iclis, "C")
            THIS.this_cResp     = TratarNulo(resp, "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")

            IF TYPE(par_cAliasCursor + ".rclis") != "U"
                THIS.this_cRclis = TratarNulo(rclis, "C")
            ELSE
                THIS.this_cRclis = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".usuario") != "U"
                THIS.this_cUsuario = TratarNulo(usuario, "C")
            ELSE
                THIS.this_cUsuario = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".deptos") != "U"
                THIS.this_cDeptos = TratarNulo(deptos, "C")
            ELSE
                THIS.this_cDeptos = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCdVca (iclis, resp, pkchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + "," + ;
                       EscaparSQL(THIS.this_cPkChaves) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdVca SET" + ;
                       " iclis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       " resp = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + ;
                       " WHERE RTRIM(pkchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados (READWRITE) com o JOIN do legado
    * (lcQryVca do SIGALTDT.Init): SigCdVca + SigCdCli (rclis) + SigCdUsu
    * (deptos/ncomps). A grade tem colunas editaveis (Iclis/Resp), por isso o
    * cursor precisa ser READWRITE - SQLEXEC() sozinho gera cursor read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Iclis C(10), Resp C(20), PkChaves C(20), ;
                                                    Rclis C(50), Deptos C(10), Usuario C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.iclis AS Iclis, a.resp AS Resp, a.pkchaves AS PkChaves," + ;
                           " c.rclis AS Rclis, b.deptos AS Deptos, b.ncomps AS Usuario" + ;
                           " FROM SigCdVca a" + ;
                           " INNER JOIN SigCdUsu b ON a.resp = b.usuarios" + ;
                           " INNER JOIN SigCdCli c ON a.iclis = c.iclis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SET NULL ON
                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                    SET NULL OFF
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    SELECT cursor_4c_Dados
                    INDEX ON Iclis   TAG Iclis   ADDITIVE
                    INDEX ON Resp    TAG Resp    ADDITIVE
                    INDEX ON Rclis   TAG Rclis   ADDITIVE
                    INDEX ON Deptos  TAG Deptos  ADDITIVE
                    INDEX ON Usuario TAG Usuario ADDITIVE
                    SET ORDER TO TAG Iclis
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar v" + CHR(237) + "nculos Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLista - Substitui TODO o conteudo de SigCdVca pelas linhas validas
    * do cursor da grade (mesma semantica do legado cmdok.Click: apaga tudo e
    * reinsere com pkchaves novo). Linhas com Iclis ou Resp vazios (linha em
    * branco ainda nao preenchida) sao descartadas, equivalente ao
    * "Delete From CrSigCdVca Where Empty(IClis) or Empty(Resp)" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLista(par_cCursorAlias)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan, loc_nResultado

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.

        TRY
            IF !USED(par_cCursorAlias)
                THIS.this_cMensagemErro = "Cursor de v" + CHR(237) + "nculos n" + CHR(227) + "o inicializado."
                MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
            ELSE
                SQLSETPROP(gnConnHandle, "Transactions", 2)
                loc_lTransacaoAberta = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, "DELETE FROM SigCdVca")
                IF loc_nResultado < 0
                    loc_lErroScan = .T.
                    THIS.this_cMensagemErro = "Falha ao limpar v" + CHR(237) + "nculos anteriores:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
                ELSE
                    SELECT (par_cCursorAlias)
                    GO TOP
                    SCAN FOR !EMPTY(Iclis) AND !EMPTY(Resp)
                        THIS.this_cIclis = Iclis
                        THIS.this_cResp  = Resp
                        IF NOT THIS.Inserir()
                            loc_lErroScan = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroScan
                    SQLTRANSACT(gnConnHandle, "ROLLBACK")
                ELSE
                    SQLTRANSACT(gnConnHandle, "COMMIT")
                    loc_lSucesso = .T.
                ENDIF
                SQLSETPROP(gnConnHandle, "Transactions", 1)
                loc_lTransacaoAberta = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

