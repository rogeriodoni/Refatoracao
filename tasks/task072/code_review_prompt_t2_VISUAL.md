# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'lblEmpresa' (parent: SIGRECTL): Top original=94 vs migrado 'lbl_4c_LblEmpresa' Top=9 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECTL.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (956 linhas total):

*-- Linhas 7 a 15:
7: * Filtros (Page1):
8: *   - M" + CHR(234) + "s  (1-12)
9: *   - Ano  (2000-2099)
10: *   - Imprimir Tempo de Utiliza" + CHR(231) + CHR(227) + "o (checkbox)
11: *
12: * Bot" + CHR(245) + "es:
13: *   - Visualizar: REPORT FORM SigReCtl PREVIEW NOCONSOLE
14: *   - Imprimir:   REPORT FORM SigReCtl TO PRINTER PROMPT NOCONSOLE
15: *   - Excel:      COPY TO SigReCtl TYPE XLS

*-- Linhas 79 a 87:
79:         loc_lContinuar = .T.
80: 
81:         TRY
82:             THIS.Caption = "Relat" + CHR(243) + "rio Mensal de Acessos"
83: 
84:             IF TYPE("gc_4c_CaminhoIcones") = "U"
85:                 gc_4c_CaminhoIcones = ""
86:             ENDIF
87:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 105 a 114:
105:                 THIS.ConfigurarPageFrame()
106: 
107:                 *-- Atualizar titulos no cabecalho apos criacao
108:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
109:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
110: 
111:                 *-- Adicionar campos de filtro na Page1
112:                 THIS.ConfigurarPaginaLista()
113: 
114:                 *-- Vincular eventos dos botoes do relatorio

*-- Linhas 141 a 219:
141:     PROTECTED PROCEDURE ConfigurarCabecalho()
142:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
143:         WITH THIS.cnt_4c_Cabecalho
144:             .Top         = 0
145:             .Left        = 0
146:             .Width       = THIS.Width
147:             .Height      = 80
148:             .BackStyle   = 1
149:             .BackColor   = RGB(100, 100, 100)
150:             .BorderWidth = 0
151:             .Visible     = .T.
152: 
153:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
154:             .AddObject("lbl_4c_Sombra", "Label")
155:             WITH .lbl_4c_Sombra
156:                 .Top       = 22
157:                 .Left      = 22
158:                 .Width     = THIS.Width
159:                 .Height    = 30
160:                 .Caption   = "Relat" + CHR(243) + "rio Mensal de Acessos"
161:                 .FontName  = "Tahoma"
162:                 .FontSize  = 14
163:                 .FontBold  = .T.
164:                 .ForeColor = RGB(0, 0, 0)
165:                 .BackStyle = 0
166:                 .Visible   = .T.
167:             ENDWITH
168: 
169:             *-- Titulo em branco (sobre a sombra)
170:             .AddObject("lbl_4c_Titulo", "Label")
171:             WITH .lbl_4c_Titulo
172:                 .Top       = 20
173:                 .Left      = 20
174:                 .Width     = THIS.Width
175:                 .Height    = 30
176:                 .Caption   = "Relat" + CHR(243) + "rio Mensal de Acessos"
177:                 .FontName  = "Tahoma"
178:                 .FontSize  = 14
179:                 .FontBold  = .T.
180:                 .ForeColor = RGB(255, 255, 255)
181:                 .BackStyle = 0
182:                 .Visible   = .T.
183:             ENDWITH
184:         ENDWITH
185:     ENDPROC
186: 
187:     *--------------------------------------------------------------------------
188:     * ConfigurarBotoes - CommandGroup canonico do frmrelatorio
189:     *   Original: btnReport.Top=-2, Left=494, Height=85, Width=310
190:     *   Novo padrao: cmg_4c_Botoes.Top=0, Left=529, Width=273, Height=80
191:     *   Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
192:     *--------------------------------------------------------------------------
193:     PROTECTED PROCEDURE ConfigurarBotoes()
194:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
195:         WITH THIS.cmg_4c_Botoes
196:             .Top           = 0
197:             .Left          = 529
198:             .Width         = 273
199:             .Height        = 80
200:             .ButtonCount   = 4
201:             .BackStyle     = 0
202:             .BorderStyle   = 0
203:             .BorderColor   = RGB(136, 189, 188)
204:             .SpecialEffect = 1
205:             .Themes        = .F.
206:             .Visible       = .T.
207: 
208:             *-- Visualizar (preview em tela)
209:             WITH .Buttons(1)
210:                 .Top             = 5
211:                 .Left            = 5
212:                 .Width           = 65
213:                 .Height          = 70
214:                 .Caption         = "Visualizar"
215:                 .FontBold        = .T.
216:                 .FontItalic      = .T.
217:                 .BackColor       = RGB(255, 255, 255)
218:                 .ForeColor       = RGB(90, 90, 90)
219:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 227 a 239:
227: 
228:             *-- Imprimir (impressora com dialogo)
229:             WITH .Buttons(2)
230:                 .Top             = 5
231:                 .Left            = 71
232:                 .Width           = 65
233:                 .Height          = 70
234:                 .Caption         = "Imprimir"
235:                 .FontName        = "Tahoma"
236:                 .FontBold        = .T.
237:                 .FontItalic      = .T.
238:                 .FontSize        = 8
239:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 249 a 261:
249: 
250:             *-- Excel (exportar dados do cursor para XLS)
251:             WITH .Buttons(3)
252:                 .Top             = 5
253:                 .Left            = 137
254:                 .Width           = 65
255:                 .Height          = 70
256:                 .Caption         = "Excel"
257:                 .FontName        = "Tahoma"
258:                 .FontBold        = .T.
259:                 .FontItalic      = .T.
260:                 .FontSize        = 8
261:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 271 a 283:
271: 
272:             *-- Encerrar (fechar form)
273:             WITH .Buttons(4)
274:                 .Top             = 5
275:                 .Left            = 203
276:                 .Width           = 65
277:                 .Height          = 70
278:                 .Caption         = "Encerrar"
279:                 .Cancel          = .T.
280:                 .FontName        = "Tahoma"
281:                 .FontBold        = .T.
282:                 .FontItalic      = .T.
283:                 .FontSize        = 8

*-- Linhas 310 a 325:
310:         loc_oPgf.PageCount = 1
311: 
312:         *-- Posicionamento: abaixo do cabecalho (80px) com 5px de gap
313:         loc_oPgf.Top    = 85
314:         loc_oPgf.Left   = -1
315:         loc_oPgf.Width  = THIS.Width + 2
316:         loc_oPgf.Height = THIS.Height - 85
317:         loc_oPgf.Tabs   = .F.
318: 
319:         *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
320:         loc_oPgf.Page1.Caption   = "Filtros"
321:         loc_oPgf.Page1.FontName  = "Tahoma"
322:         loc_oPgf.Page1.FontSize  = 8
323:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
324:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
325:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 377 a 389:
377:         loc_oPg = THIS.pgf_4c_Paginas.Page1
378: 
379:         *-- Label "Mes :"
380:         loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
381:         WITH loc_oPg.lbl_4c_LblEmpresa
382:             .Caption   = "M" + CHR(234) + "s :"
383:             .Top       = 9
384:             .Left      = 96
385:             .Width     = 28
386:             .Height    = 15
387:             .AutoSize  = .T.
388:             .FontName  = "Tahoma"
389:             .FontSize  = 8

*-- Linhas 396 a 405:
396:         loc_oPg.AddObject("txt_4c_Mes", "TextBox")
397:         WITH loc_oPg.txt_4c_Mes
398:             .Value         = 0
399:             .Top           = 5
400:             .Left          = 126
401:             .Width         = 24
402:             .Height        = 23
403:             .FontName      = "Tahoma"
404:             .FontSize      = 8
405:             .FontBold      = .F.

*-- Linhas 420 a 432:
420:         ENDWITH
421: 
422:         *-- Label "Ano :"
423:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
424:         WITH loc_oPg.lbl_4c_Label1
425:             .Caption   = "Ano :"
426:             .Top       = 8
427:             .Left      = 168
428:             .Width     = 28
429:             .Height    = 15
430:             .AutoSize  = .T.
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8

*-- Linhas 439 a 448:
439:         loc_oPg.AddObject("txt_4c_Ano", "TextBox")
440:         WITH loc_oPg.txt_4c_Ano
441:             .Value         = 0
442:             .Top           = 4
443:             .Left          = 198
444:             .Width         = 38
445:             .Height        = 23
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8
448:             .FontBold      = .F.

*-- Linhas 462 a 475:
462:             .Visible       = .T.
463:         ENDWITH
464: 
465:         *-- CheckBox Imprimir Tempo de Utilizacao
466:         loc_oPg.AddObject("chk_4c_ImpTempo", "CheckBox")
467:         WITH loc_oPg.chk_4c_ImpTempo
468:             .Caption   = "Imprimir Tempo de Utiliza" + CHR(231) + CHR(227) + "o"
469:             .Top       = 29
470:             .Left      = 96
471:             .Value     = 1
472:             .AutoSize  = .T.
473:             .Alignment = 0
474:             .FontName  = "Tahoma"
475:             .FontSize  = 8

*-- Linhas 862 a 886:
862:     *--------------------------------------------------------------------------
863:     * BOParaForm - Transfere propriedades do BO de volta para os controles.
864:     *   Operacao inversa de FormParaRelatorio: le this_nMes, this_nAno e
865:     *   this_lImpTempo do SIGRECTLBO e preenche os TextBoxes/CheckBox.
866:     *   Util para restaurar filtros apos uma operacao de busca ou quando
867:     *   o BO for alimentado externamente (ex: modo automatico).
868:     *--------------------------------------------------------------------------
869:     PROTECTED PROCEDURE BOParaForm()
870:         LOCAL loc_oPg
871:         TRY
872:             IF VARTYPE(THIS.this_oRelatorio) != "O"
873:                 RETURN
874:             ENDIF
875:             loc_oPg = THIS.pgf_4c_Paginas.Page1
876:             WITH THIS.this_oRelatorio
877:                 IF VARTYPE(loc_oPg.txt_4c_Mes) = "O"
878:                     loc_oPg.txt_4c_Mes.Value = .this_nMes
879:                 ENDIF
880:                 IF VARTYPE(loc_oPg.txt_4c_Ano) = "O"
881:                     loc_oPg.txt_4c_Ano.Value = .this_nAno
882:                 ENDIF
883:                 IF VARTYPE(loc_oPg.chk_4c_ImpTempo) = "O"
884:                     loc_oPg.chk_4c_ImpTempo.Value = IIF(.this_lImpTempo = 1, 1, 0)
885:                 ENDIF
886:             ENDWITH


### BO (C:\4c\projeto\app\classes\SIGRECTLBO.prg):
*==============================================================================
* SIGRECTLBO.PRG
* Business Object para Relatorio Mensal de Acessos (SIGRECTL)
* Herda de RelatorioBase
*
* Tabelas: SigSyCtl, SigCdUsu, SigCdCrg, SigCdEmp, SigCdPam
* Cursor resultado: crDados
*==============================================================================

*-- Converte segundos para HH:MM (equivalente a fMtoH do legado com parametro em minutos)
*-- VFP subtrai dois DATETIME em segundos, entao recebe segundos diretamente
FUNCTION fMtoH_Seg(par_nSegundos)
    LOCAL loc_nSeg, loc_nHoras, loc_nMinutos
    loc_nSeg     = MAX(0, par_nSegundos)
    loc_nHoras   = INT(loc_nSeg / 3600)
    loc_nMinutos = MOD(INT(loc_nSeg / 60), 60)
    RETURN LTRIM(STR(loc_nHoras, 4)) + ":" + RIGHT("0" + LTRIM(STR(loc_nMinutos, 2)), 2)
ENDFUNC

DEFINE CLASS SIGRECTLBO AS RelatorioBase

    *-- Filtros do relatorio
    this_nMes           = 0     && Mes (1-12)
    this_nAno           = 0     && Ano (2000-2099)
    this_lImpTempo      = 0     && Imprimir Tempo de Utilizacao (0=Nao / 1=Sim)

    *-- Cursor resultado para o REPORT FORM
    this_cCursorDados   = "crDados"

    *-- Configuracao do relatorio
    this_cFRXPath       = ""
    this_cMensagemErro  = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com mes/ano correntes e caminho do FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_nMes      = MONTH(DATE())
            THIS.this_nAno      = YEAR(DATE())
            THIS.this_lImpTempo = 0

            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath = gc_4c_CaminhoReports + "SigReCtl.frx"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores crCabecalho e crDados para o REPORT FORM
    *
    * Logica original (processamento):
    *   1. Calcula periodo (primeiro e ultimo dia do mes/ano informados)
    *   2. Busca registros de acesso em SigSyCtl + SigCdUsu + SigCdCrg
    *   3. Clamp das datas Lic_Data/Lic_Vals ao periodo do mes
    *   4. Agrega por usuario calculando soma dos intervalos (segundos)
    *   5. Monta crDados com: cabecalho UTILIZACAO, linhas de usuario, total
    *   6. Busca usuarios ativos (SigCdUsu) e acrescenta ao crDados
    *   7. Busca empresas ativas (SigCdEmp) e acrescenta ao crDados
    *   8. Busca licencas (SigCdPam) e acrescenta ao crDados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        LOCAL loc_nMes, loc_nAno, loc_lTpo
        LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim
        LOCAL loc_cSQL, loc_nResult, loc_cMes, loc_cAno, loc_cSub, loc_cLic
        LOCAL loc_nTotalSeg, loc_cTempoTotal, loc_cQtde

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.

                *-- Extrair filtros do BO
                loc_nMes = THIS.this_nMes
                loc_nAno = THIS.this_nAno
                loc_lTpo = (THIS.this_lImpTempo = 1)

                *-- Calcular primeiro e ultimo dia do mes
                loc_cMes = ALLTRIM(STR(loc_nMes, 2))
                loc_cAno = ALLTRIM(STR(loc_nAno, 4))
                loc_dIni = DATE(loc_nAno, loc_nMes, 1)
                IF loc_nMes >= 12
                    loc_dFim = DATE(loc_nAno + 1, 1, 1) - 1
                ELSE
                    loc_dFim = DATE(loc_nAno, loc_nMes + 1, 1) - 1
                ENDIF
                loc_tIni = CTOT(DTOC(loc_dIni) + " 00:00:00")
                loc_tFim = CTOT(DTOC(loc_dFim) + " 23:59:59")

                *-- Subtitulo do relatorio
                loc_cSub = "M" + CHR(234) + "s : " + loc_cMes + " / Ano : " + loc_cAno

                *-- Cursor de cabecalho (criado pelo BO, lido pelo FRX)
                IF USED("crCabecalho")
                    USE IN crCabecalho
                ENDIF
                IF USED("crDados1")
                    USE IN crDados1
                ENDIF
                IF USED("crDados2")
                    USE IN crDados2
                ENDIF
                IF USED("crDados")
                    USE IN crDados
                ENDIF
                IF USED("crDados4")
                    USE IN crDados4
                ENDIF
                IF USED("crDados5")
                    USE IN crDados5
                ENDIF

                CREATE CURSOR crCabecalho (Subtitulos C(250), Empresa C(250))
                INSERT INTO crCabecalho (Subtitulos) VALUES (loc_cSub)

                *--------------------------------------------------------------
                * Query 1: Registros de login do mes/ano (SigSyCtl + usuarios)
                *--------------------------------------------------------------
                loc_cSQL = "Select Left(a.Lic_Usua, 10) as Usuario, b.NComps as Nomes, " + ;
                           "b.ccargs as Cargo, isnull(c.dcargs,space(20)) as descricao, " + ;
                           "a.Lic_Data, a.Lic_Vals " + ;
                           "From SigSyCtl a " + ;
                           "Left Join SigCdUsu b On Left(a.Lic_Usua, 10) = b.Usuarios " + ;
                           "Left Join SigCdCrg c on b.ccargs = c.ccargs " + ;
                           "Where (Month(a.Lic_Data) = " + TRANSFORM(loc_nMes) + ;
                           " And Year(a.Lic_Data) = " + TRANSFORM(loc_nAno) + ") Or " + ;
                           "(Month(a.Lic_Vals) = " + TRANSFORM(loc_nMes) + ;
                           " And Year(a.Lic_Vals) = " + TRANSFORM(loc_nAno) + ") And " + ;
                           "Not b.Usuarios = '4CONTROL' " + ;
                           "Order By 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados1)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                *-- Clamp de datas ao periodo do mes
                UPDATE crDados1 SET Lic_Data = loc_tIni WHERE Lic_Data < loc_tIni
                UPDATE crDados1 SET Lic_Vals = loc_tFim WHERE Lic_Vals > loc_tFim

                *-- Agregar por usuario: SUM de intervalos em segundos
                SELECT SUM(Lic_Vals - Lic_Data) as Minutos, ;
                       Usuario, Nomes, Cargo, Descricao ;
                  FROM crDados1 ;
                 GROUP BY Usuario, Nomes, Cargo, Descricao ;
                  INTO CURSOR crDados2 READWRITE

                *-- Pre-computar total de segundos para a linha de TOTAL
                IF USED("cursor_4c_SumTmp")
                    USE IN cursor_4c_SumTmp
                ENDIF
                loc_nTotalSeg  = 0
                loc_cTempoTotal = PADL("", 10)
                loc_cQtde = "QUANTIDADE : " + ALLTRIM(STR(RECCOUNT("crDados2"), 10))

                SELECT SUM(Minutos) as TotalSeg FROM crDados2 ;
                  INTO CURSOR cursor_4c_SumTmp READWRITE
                IF USED("cursor_4c_SumTmp") AND RECCOUNT("cursor_4c_SumTmp") > 0
                    GO TOP IN cursor_4c_SumTmp
                    loc_nTotalSeg = NVL(cursor_4c_SumTmp.TotalSeg, 0)
                    USE IN cursor_4c_SumTmp
                ENDIF
                loc_cTempoTotal = PADL(IIF(loc_lTpo, fMtoH_Seg(loc_nTotalSeg), ""), 10)

                *-- Cursor final com cabecalho, dados e linha de total
                SELECT "*" as Negrito, SPACE(10) as Usuario, ;
                       PADR("UTILIZA" + CHR(199) + CHR(195) + "O DOS USU" + CHR(193) + "RIOS", 60) as Nomes, ;
                       SPACE(10) as Tempo, SPACE(10) as Cargo, SPACE(20) as Descricao ;
                  FROM crDados2 ;
                 WHERE RECNO() = 1 ;
                 UNION ALL ;
                SELECT " " as Negrito, Usuario, PADR(Nomes, 60) as Nomes, ;
                       PADL(IIF(loc_lTpo, fMtoH_Seg(Minutos), ""), 10) as Tempo, ;
                       Cargo, Descricao ;
                  FROM crDados2 ;
                 UNION ALL ;
                SELECT "*" as Negrito, REPLICATE(CHR(254), 10) as Usuario, ;
                       PADR(loc_cQtde, 60) as Nomes, ;
                       loc_cTempoTotal as Tempo, ;
                       SPACE(10) as Cargo, SPACE(20) as Descricao ;
                  FROM crDados2 ;
                 GROUP BY 1, 2 ;
                  INTO CURSOR crDados READWRITE ;
                 ORDER BY 2, 3

                UPDATE crDados SET Usuario = "TOTAL" ;
                  WHERE Usuario = REPLICATE(CHR(254), 10)

                *--------------------------------------------------------------
                * Query 2: Usuarios ativos (SigCdUsu)
                *--------------------------------------------------------------
                loc_cSQL = "Select a.Usuarios as Usuario, a.NComps as Nomes, " + ;
                           "a.ccargs as Cargo, isnull(c.dcargs,space(20)) as descricao " + ;
                           "From SigCdUsu a " + ;
                           "Left Join SigCdCrg c on a.ccargs = c.ccargs " + ;
                           "Where Not a.CAtivos = 'N' And " + ;
                           "Not a.Usuarios = '4CONTROL' " + ;
                           "Order By 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados4")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados4)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                *-- Insere secao de usuarios ativos no cursor final
                INSERT INTO crDados (Usuario) VALUES ("")
                INSERT INTO crDados (Negrito, Nomes) ;
                       VALUES ("*", "USU" + CHR(193) + "RIOS ATIVOS")

                SELECT crDados4
                SCAN
                    INSERT INTO crDados (Usuario, Nomes, Cargo, Descricao) ;
                           VALUES (crDados4.Usuario, crDados4.Nomes, ;
                                   crDados4.Cargo, crDados4.Descricao)
                ENDSCAN
                INSERT INTO crDados (Negrito, Usuario, Nomes) ;
                       VALUES ("*", "TOTAL", ;
                               "USUARIOS ATIVOS : " + ALLTRIM(STR(RECCOUNT("crDados4"), 10)))

                *--------------------------------------------------------------
                * Query 3: Empresas ativas (SigCdEmp)
                *--------------------------------------------------------------
                loc_cSQL = "Select CEmps, Cgcs, Razas From SigCdEmp " + ;
                           "Where Ativas = 1 Order By CEmps"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados5")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crDados5)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                *-- Insere secao de empresas ativas no cursor final
                INSERT INTO crDados (Usuario) VALUES ("")
                INSERT INTO crDados (Negrito, Nomes) ;
                       VALUES ("*", "EMPRESAS ATIVAS")

                SELECT crDados5
                SCAN
                    INSERT INTO crDados (Usuario, Nomes) ;
                           VALUES (crDados5.CEmps, ;
                                   IIF(EMPTY(ALLTRIM(crDados5.Cgcs)), "", ;
                                       ALLTRIM(crDados5.Cgcs) + " / ") + ;
                                   crDados5.Razas)
                ENDSCAN
                INSERT INTO crDados (Negrito, Usuario, Nomes) ;
                       VALUES ("*", crDados5.CEmps, ;
                               "EMPRESAS ATIVAS : " + ALLTRIM(STR(RECCOUNT("crDados5"), 10)))

                *--------------------------------------------------------------
                * Query 4: Numero de licencas (SigCdPam)
                *--------------------------------------------------------------
                IF USED("crNumLics")
                    USE IN crNumLics
                ENDIF

                loc_cSQL = "Select CNumLics, DirLivrosV From SigCdPam"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNumLics")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (crNumLics)"
                    MsgErro(THIS.this_cMensagemErro, "PrepararDados")
                    EXIT
                ENDIF

                GO TOP IN crNumLics
                loc_cLic = ALLTRIM(TRANSFORM(crNumLics.CNumLics, ""))
                UPDATE crCabecalho SET Empresa = crNumLics.DirLivrosV
                USE IN crNumLics

                *-- Insere secao de licencas no cursor final
                INSERT INTO crDados (Usuario) VALUES ("")
                INSERT INTO crDados (Negrito, Usuario, Nomes) ;
                       VALUES ("*", "TOTAL", ;
                               "LICEN" + CHR(199) + "AS ATIVAS : " + loc_cLic)

                SELECT crDados
                GO TOP IN crDados

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorio
    *
    * RelatorioBase nao mantem registro corrente carregado de cursor.
    * Os filtros (this_nMes, this_nAno, this_lImpTempo) sao alimentados
    * diretamente pelo Form via FormParaRelatorio(). PrepararDados() monta
    * o cursor crDados dinamicamente a partir desses filtros.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE("&par_cAliasCursor..nMes") = "N"
                    THIS.this_nMes = NVL(EVALUATE(par_cAliasCursor + ".nMes"), MONTH(DATE()))
                ENDIF
                IF TYPE("&par_cAliasCursor..nAno") = "N"
                    THIS.this_nAno = NVL(EVALUATE(par_cAliasCursor + ".nAno"), YEAR(DATE()))
                ENDIF
                IF TYPE("&par_cAliasCursor..lImpTempo") = "L"
                    THIS.this_lImpTempo = IIF(EVALUATE(par_cAliasCursor + ".lImpTempo"), 1, 0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                          IIF(EMPTY(par_cAliasCursor), "<vazio>", par_cAliasCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorio (mantido por compatibilidade de API)
    *
    * Relatorios nao gravam registros em banco. Para gerar saida do relatorio,
    * usar Imprimir() (impressora) ou Visualizar() (preview). Este metodo
    * existe para compatibilidade com chamadas genericas da camada Form.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o INSERIR n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rio. " + ;
                                  "Use Imprimir() ou Visualizar()."
        THIS.RegistrarAuditoria("INSERIR_RELATORIO")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorio (mantido por compatibilidade de API)
    *
    * Relatorios nao atualizam registros em banco. Os filtros do BO sao
    * volateis (resetam a cada execucao). Este metodo existe para
    * compatibilidade com chamadas genericas da camada Form.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o ATUALIZAR n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rio. " + ;
                                  "Use Imprimir() ou Visualizar()."
        THIS.RegistrarAuditoria("ATUALIZAR_RELATORIO")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Relatorios nao registram auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crCabecalho")
            USE IN crCabecalho
        ENDIF
        IF USED("crDados")
            USE IN crDados
        ENDIF
        IF USED("crDados1")
            USE IN crDados1
        ENDIF
        IF USED("crDados2")
            USE IN crDados2
        ENDIF
        IF USED("crDados4")
            USE IN crDados4
        ENDIF
        IF USED("crDados5")
            USE IN crDados5
        ENDIF
        IF USED("cursor_4c_SumTmp")
            USE IN cursor_4c_SumTmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

