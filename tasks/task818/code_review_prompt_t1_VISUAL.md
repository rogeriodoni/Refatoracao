# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (13)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Detalhe' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag.grd_4c_Tipos define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag.grd_4c_Tipos.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag.grd_4c_GrandeGrupo define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag.grd_4c_GrandeGrupo.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag.grd_4c_GrupoProduto define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag.grd_4c_GrupoProduto.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPag.grd_4c_Operacoes define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPag.grd_4c_Operacoes.RecordSource).
- [GRID-WITH] Bloco WITH par_oPag.grd_4c_Dados1 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: par_oPag.grd_4c_Dados1.RecordSource).
- [GRID-WITH] Bloco WITH par_oPag.grd_4c_Dados2 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: par_oPag.grd_4c_Dados2.RecordSource).
- [GRID-WITH] Bloco WITH par_oPag.grd_4c_Dados3 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: par_oPag.grd_4c_Dados3.RecordSource).
- [NAVEGACAO-PAGINA] Metodo 'BtnConsultarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'Check1' (parent: SIGOPVDI.pgfPrincipal.pgFiltros.grdEmps.Column1): Left original=2 vs migrado 'Check1' Left=35 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optValor1' (parent: SIGOPVDI.pgfPrincipal.pgDados.pgResults.pgRes01): Top original=292 vs migrado 'obj_4c_OptValor1' Top=5 (diff=287px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optValor1' (parent: SIGOPVDI.pgfPrincipal.pgDados.pgResults.pgRes01): Left original=76 vs migrado 'obj_4c_OptValor1' Left=5 (diff=71px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3850 linhas total):

*-- Linhas 12 a 28:
12: * e feita pelos botoes cmgFiltros.btnConsultar / pgDados.cmgRetornar, nao
13: * por clique nas abas.
14: *
15: * pgf_4c_Paginas.Top=-1 (NAO eh o deslocamento -29 do padrao CRUD - regra
16: * #11 e o PageFrame.Top=-29 nao se aplicam aqui: este form nao eh
17: * frmcadastro, e o legado so usa -1 para cobrir 1px de borda).
18: *
19: * FASE 3/8 - ESTRUTURA BASE: casca do form (propriedades visuais EXATAS do
20: * SCX - DataSession=2, Height=700, Width=1300, BorderStyle=2, ControlBox=.F.,
21: * Closable=.F., TitleBar=0) + pgf_4c_Paginas (2 paginas, geometria exata do
22: * dump) + o cabecalho cinza superior (cnt_4c_Sombra + lbl_4c_LblSombra +
23: * lbl_4c_LblTitulo), que no dump legado existe SO dentro de pgFiltros (Page1)
24: * - diferente do padrao CRUD que replica a faixa nas duas paginas (regra
25: * #11, decisao exclusiva de forms frmcadastro) - e o PageFrame interno
26: * pgf_4c_Resultados (3 paginas, so a casca, sem grades ainda).
27: *
28: * FASES CONCLUIDAS:

*-- Linhas 37 a 57:
37: *           lookups fwbuscaext (Moeda/SigCdMoe, Grupo de Venda/SigCdCol,
38: *           Subgrupo/SigCdPsg) via FormBuscaAuxiliar, instalados no
39: *           LostFocus de cada campo de codigo/descricao (regra #47).
40: *
41: * FASES SEGUINTES:
42: *   Fase 7: grades de resultado (pgRes01/02/03 -> grd_4c_Dados1/2/3) +
43: *           botoes de navegacao/exportacao + eventos
44: *   Fase 8: consolidacao (Processamento() do legado -> THIS.this_oBusinessObject.
45: *           Processar(), FormParaBO completo dos filtros)
46: *------------------------------------------------------------------------------
47: DEFINE CLASS FormSigOpVdi AS FormBase
48: 
49:     *-- Propriedades visuais (SIGOPVDI.SCX, SECAO 2 "PROPRIEDADES DE: SIGOPVDI")
50:     this_cMensagemErro = ""
51:     DataSession  = 2
52:     ShowWindow   = 1
53:     WindowType   = 1
54:     Height       = 700
55:     Width        = 1300
56:     BorderStyle  = 2
57:     AutoCenter   = .T.

*-- Linhas 130 a 139:
130:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
131: 
132:         WITH THIS.pgf_4c_Paginas
133:             .Top         = -1
134:             .Left        = 0
135:             .Width       = 1301
136:             .Height      = 705
137:             .PageCount   = 2
138:             .Tabs        = .F.
139:             .BorderWidth = 0

*-- Linhas 171 a 259:
171:         *-- cntSombra: Top=1 Left=0 Width=1308 Height=80 BackColor=100,100,100
172:         loc_oPag.AddObject("cnt_4c_Sombra", "Container")
173:         WITH loc_oPag.cnt_4c_Sombra
174:             .Top         = 1
175:             .Left        = 0
176:             .Width       = 1308
177:             .Height      = 80
178:             .BackColor   = RGB(100, 100, 100)
179:             .BackStyle   = 1
180:             .BorderWidth = 0
181: 
182:             *-- lblSombra: Top=25 Left=10 Width=769 Height=40 Tahoma 18 Bold
183:             *-- ForeColor=0,0,0 (fundo da sombra do titulo)
184:             .AddObject("lbl_4c_LblSombra", "Label")
185:             WITH .lbl_4c_LblSombra
186:                 .Top       = 25
187:                 .Left      = 10
188:                 .Width     = THIS.Width
189:                 .Height    = 40
190:                 .FontBold  = .T.
191:                 .FontName  = "Tahoma"
192:                 .FontSize  = 18
193:                 .AutoSize  = .F.
194:                 .BackStyle = 0
195:                 .WordWrap  = .T.
196:                 .Alignment = 0
197:                 .ForeColor = RGB(0, 0, 0)
198:                 *-- Caption vem de THIS.Caption, nao do texto estatico
199:                 *-- ("Cadastro de Testes") que sobrou no dump do SCX.
200:                 .Caption   = THIS.Caption
201:                 .Visible   = .T.
202:             ENDWITH
203: 
204:             *-- lblTitulo: Top=24 Left=10 Width=769 Height=46 Tahoma 18 Bold
205:             *-- ForeColor=255,255,255 (texto branco por cima da sombra)
206:             .AddObject("lbl_4c_LblTitulo", "Label")
207:             WITH .lbl_4c_LblTitulo
208:                 .Top       = 24
209:                 .Left      = 10
210:                 .Width     = THIS.Width
211:                 .Height    = 46
212:                 .FontBold  = .T.
213:                 .FontName  = "Tahoma"
214:                 .FontSize  = 18
215:                 .AutoSize  = .F.
216:                 .BackStyle = 0
217:                 .WordWrap  = .T.
218:                 .Alignment = 0
219:                 .ForeColor = RGB(255, 255, 255)
220:                 .Caption   = THIS.Caption
221:                 .Visible   = .T.
222:             ENDWITH
223: 
224:             .Visible = .T.
225:         ENDWITH
226: 
227:         THIS.ConfigurarGradesMarcacao(loc_oPag)
228:         THIS.ConfigurarCamposFiltro(loc_oPag)
229: 
230:         *-- txt_4c_CfgGrade (getCfgGrade no legado): Top=673, FORA da area
231:         *-- normalmente visitada do formulario - guarda em memoria a string
232:         *-- de largura/visibilidade das colunas de grd_4c_Dados1 (regra de
233:         *-- AcertaColunas, Fase 7). Nao tem uso direto pelo usuario comum.
234:         loc_oPag.AddObject("txt_4c_CfgGrade", "TextBox")
235:         WITH loc_oPag.txt_4c_CfgGrade
236:             .Top     = 673
237:             .Left    = 9
238:             .Width   = 1297
239:             .Height  = 23
240:             .Value   = ""
241:             *-- getCfgGrade.When do legado e "Return .f.": o campo nunca
242:             *-- recebe foco nem aceita digitacao - e area de armazenamento
243:             *-- de AcertaColunas, e texto digitado ali corromperia a
244:             *-- largura/visibilidade das 35 colunas de grd_4c_Dados1.
245:             *-- ReadOnly (convencao do projeto para When -> .f.) + TabStop
246:             *-- = .F. para o Tab nao parar nele.
247:             .ReadOnly = .T.
248:             .TabStop  = .F.
249:             .Visible = .T.
250:         ENDWITH
251: 
252:         *-- Page NAO tem a propriedade Visible (a Page e exibida pelo
253:         *-- ActivePage do PageFrame). Atribuir estoura "Property VISIBLE
254:         *-- is not found" dentro do InicializarForm e a tela nao abre.
255:     ENDPROC
256: 
257:     *==========================================================================
258:     * ConfigurarCamposFiltro - Campos de filtro da Pagina 1. Periodo
259:     * (getDcI/getDcF -> txt_4c_DataIni/txt_4c_DataFim) e Moeda de Conversao

*-- Linhas 284 a 365:
284:     *==========================================================================
285:     PROTECTED PROCEDURE ConfigurarCamposFiltro(par_oPag)
286: 
287:         *-- lbl_4c_Periodo (Say1): "Periodo :" - Left=457, campo em 506 (49px de vao)
288:         par_oPag.AddObject("lbl_4c_Periodo", "Label")
289:         WITH par_oPag.lbl_4c_Periodo
290:             .Top       = 111
291:             .Left      = 457
292:             .Width     = 45
293:             .Height    = 15
294:             .AutoSize  = .F.
295:             .BackStyle = 0
296:             .Alignment = 0
297:             .ForeColor = RGB(90, 90, 90)
298:             .Caption   = "Per" + CHR(237) + "odo :"
299:             .Visible   = .T.
300:         ENDWITH
301: 
302:         *-- txt_4c_DataIni (getDcI): data inicial do periodo
303:         par_oPag.AddObject("txt_4c_DataIni", "TextBox")
304:         WITH par_oPag.txt_4c_DataIni
305:             .Top     = 107
306:             .Left    = 506
307:             .Width   = 70
308:             .Height  = 23
309:             .Value   = {}
310:             .Visible = .T.
311:         ENDWITH
312: 
313:         *-- lbl_4c_At (Label2): "at?" - Left/Width/Height EXATOS do dump
314:         par_oPag.AddObject("lbl_4c_At", "Label")
315:         WITH par_oPag.lbl_4c_At
316:             .Top       = 111
317:             .Left      = 592
318:             .Width     = 18
319:             .Height    = 15
320:             .AutoSize  = .F.
321:             .BackStyle = 0
322:             .Alignment = 0
323:             .ForeColor = RGB(90, 90, 90)
324:             .Caption   = "at" + CHR(233)
325:             .Visible   = .T.
326:         ENDWITH
327: 
328:         *-- txt_4c_DataFim (getDcF): data final do periodo
329:         par_oPag.AddObject("txt_4c_DataFim", "TextBox")
330:         WITH par_oPag.txt_4c_DataFim
331:             .Top     = 107
332:             .Left    = 617
333:             .Width   = 70
334:             .Height  = 23
335:             .Value   = {}
336:             .Visible = .T.
337:         ENDWITH
338: 
339:         *-- lbl_4c_MoedaConversao (Say3): "Moeda Conversao :" - Left=406, campo em 506
340:         par_oPag.AddObject("lbl_4c_MoedaConversao", "Label")
341:         WITH par_oPag.lbl_4c_MoedaConversao
342:             .Top       = 137
343:             .Left      = 406
344:             .Width     = 96
345:             .Height    = 15
346:             .AutoSize  = .F.
347:             .BackStyle = 0
348:             .Alignment = 0
349:             .ForeColor = RGB(90, 90, 90)
350:             .Caption   = "Moeda Convers" + CHR(227) + "o :"
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- txt_4c_CodMoeda (getCMoes): codigo da moeda de conversao
355:         *-- (CMoes char(3)). Lookup fwbuscaext (SigCdMoe) instalado no
356:         *-- LostFocus (THIS.AbrirLookupMoeda, logo abaixo).
357:         par_oPag.AddObject("txt_4c_CodMoeda", "TextBox")
358:         WITH par_oPag.txt_4c_CodMoeda
359:             .Top       = 133
360:             .Left      = 506
361:             .Width     = 31
362:             .Height    = 23
363:             .MaxLength = 3
364:             .Format    = "!"
365:             .Value     = ""

*-- Linhas 371 a 451:
371:         *-- com busca por DMoes), por isso NAO e ReadOnly.
372:         par_oPag.AddObject("txt_4c_DescMoeda", "TextBox")
373:         WITH par_oPag.txt_4c_DescMoeda
374:             .Top       = 133
375:             .Left      = 540
376:             .Width     = 385
377:             .Height    = 23
378:             .MaxLength = 15
379:             .Format    = "!"
380:             .Value     = ""
381:             .Visible   = .T.
382:         ENDWITH
383: 
384:         *-- lbl_4c_GrupoVenda (Say14): "Grupo de Venda :" - Left=416, campo em 506
385:         par_oPag.AddObject("lbl_4c_GrupoVenda", "Label")
386:         WITH par_oPag.lbl_4c_GrupoVenda
387:             .Top       = 190
388:             .Left      = 416
389:             .Width     = 86
390:             .Height    = 15
391:             .AutoSize  = .F.
392:             .BackStyle = 0
393:             .Alignment = 0
394:             .ForeColor = RGB(90, 90, 90)
395:             .Caption   = "Grupo de Venda :"
396:             .Visible   = .T.
397:         ENDWITH
398: 
399:         *-- txt_4c_CdGrVda (getCdGrVda): codigo do Grupo de Venda (SigCdCol.Colecoes char(10))
400:         par_oPag.AddObject("txt_4c_CdGrVda", "TextBox")
401:         WITH par_oPag.txt_4c_CdGrVda
402:             .Top       = 186
403:             .Left      = 506
404:             .Width     = 82
405:             .Height    = 23
406:             .MaxLength = 10
407:             .Format    = "K"
408:             .Alignment = 0
409:             .Value     = ""
410:             .Visible   = .T.
411:         ENDWITH
412: 
413:         *-- txt_4c_DsGrVda (getDsGrVda): descricao do Grupo de Venda (SigCdCol.Descs char(40))
414:         par_oPag.AddObject("txt_4c_DsGrVda", "TextBox")
415:         WITH par_oPag.txt_4c_DsGrVda
416:             .Top       = 186
417:             .Left      = 591
418:             .Width     = 334
419:             .Height    = 23
420:             .MaxLength = 40
421:             .Format    = "K"
422:             .Alignment = 3
423:             .Value     = ""
424:             .Visible   = .T.
425:         ENDWITH
426: 
427:         *-- lbl_4c_Subgrupo (Say11): "Subgrupo :" - Left=447, campo em 506
428:         par_oPag.AddObject("lbl_4c_Subgrupo", "Label")
429:         WITH par_oPag.lbl_4c_Subgrupo
430:             .Top       = 163
431:             .Left      = 447
432:             .Width     = 55
433:             .Height    = 15
434:             .AutoSize  = .F.
435:             .BackStyle = 0
436:             .Alignment = 0
437:             .ForeColor = RGB(90, 90, 90)
438:             .Caption   = "Subgrupo :"
439:             .Visible   = .T.
440:         ENDWITH
441: 
442:         *-- txt_4c__cd_sgrupo (get_cd_sgrupo): codigo do Subgrupo (SigCdPsg.codigos char(6))
443:         par_oPag.AddObject("txt_4c__cd_sgrupo", "TextBox")
444:         WITH par_oPag.txt_4c__cd_sgrupo
445:             .Top       = 159
446:             .Left      = 506
447:             .Width     = 52
448:             .Height    = 23
449:             .MaxLength = 6
450:             .Format    = "K!"
451:             .Alignment = 0

*-- Linhas 457 a 466:
457:         *-- txt_4c__ds_sgrupo (get_ds_sgrupo): descricao do Subgrupo (SigCdPsg.descricaos char(20))
458:         par_oPag.AddObject("txt_4c__ds_sgrupo", "TextBox")
459:         WITH par_oPag.txt_4c__ds_sgrupo
460:             .Top       = 159
461:             .Left      = 561
462:             .Width     = 364
463:             .Height    = 23
464:             .MaxLength = 20
465:             .Format    = "K!"
466:             .Value     = ""

*-- Linhas 837 a 863:
837:     * cursores do BO (cursor_4c_Empresas/TiposOperacao/GrandeGrupo/
838:     * GrupoProduto/Operacoes).
839:     *==========================================================================
840:     * O CheckBox de LINHA de cada grade NAO nasce aqui: criar
841:     * Column1.AddObject("Check1","CheckBox") neste ponto estoura
842:     * "Error with CHECK1 - Value : Data type mismatch" e a tela nao abre,
843:     * porque o Grid sem RecordSource se auto-liga ao alias CORRENTE quando o
844:     * ColumnCount e definido. O CheckBox e instalado no funil CarregarDados,
845:     * depois do bind - ver o comentario la.
846:     *==========================================================================
847:     PROTECTED PROCEDURE ConfigurarGradesMarcacao(par_oPag)
848: 
849:         *-- grd_4c_Empresas (grdEmps no legado): marcacao (Imps) + Cod (cemps)
850:         *-- + Empresa (razas). O CheckBox desta grade NAO leva BINDEVENT - no
851:         *-- legado os 4 handlers de grdEmps.Column1.Check1 estao COMENTADOS
852:         *-- no SCX, ou seja o toggle individual da celula e NATIVO
853:         *-- (Column1.ReadOnly = .F.) e a marcacao em lote vem de
854:         *-- cmg_4c_Empresas e chk_4c_Ck_MarcaEmp.
855:         par_oPag.AddObject("grd_4c_Empresas", "Grid")
856:         WITH par_oPag.grd_4c_Empresas
857:             .Top               = 238
858:             .Left              = 71
859:             .Width             = 318
860:             .Height            = 410
861:             .ColumnCount       = 3
862:             .FontName          = "Tahoma"
863:             .FontSize          = 8

*-- Linhas 885 a 1044:
885:             .Resizable = .F.
886:             .ReadOnly  = .F.
887:         ENDWITH
888:         par_oPag.grd_4c_Empresas.Column1.Header1.Caption   = ""
889:         par_oPag.grd_4c_Empresas.Column1.Header1.ForeColor = RGB(90, 90, 90)
890:         *-- Column2/Column3: "For I=2 To .ColumnCount" do montagrades legado
891:         WITH par_oPag.grd_4c_Empresas.Column2
892:             .Width     = 33
893:             .FontName  = "Tahoma"
894:             .FontSize  = 8
895:             .Movable   = .F.
896:             .Resizable = .F.
897:             .ReadOnly  = .T.
898:         ENDWITH
899:         par_oPag.grd_4c_Empresas.Column2.Header1.Caption   = "Cod."
900:         par_oPag.grd_4c_Empresas.Column2.Header1.Alignment = 2
901:         par_oPag.grd_4c_Empresas.Column2.Header1.ForeColor = RGB(90, 90, 90)
902:         WITH par_oPag.grd_4c_Empresas.Column3
903:             .Width     = 247
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .Movable   = .F.
907:             .Resizable = .F.
908:             .ReadOnly  = .T.
909:         ENDWITH
910:         par_oPag.grd_4c_Empresas.Column3.Header1.Caption   = "Empresa"
911:         par_oPag.grd_4c_Empresas.Column3.Header1.Alignment = 2
912:         par_oPag.grd_4c_Empresas.Column3.Header1.ForeColor = RGB(90, 90, 90)
913: 
914:         *-- cmg_4c_Empresas (cmdEmps no legado): Marcar/Desmarcar Tudo de Empresas
915:         par_oPag.AddObject("cmg_4c_Empresas", "CommandGroup")
916:         WITH par_oPag.cmg_4c_Empresas
917:             .Top         = 382
918:             .Left        = 388
919:             .Width       = 50
920:             .Height      = 91
921:             .ButtonCount = 2
922:             .BackStyle   = 0
923:             .BorderStyle = 0
924:             .Value       = 0
925:             WITH .Buttons(1)
926:                 .Top         = 1
927:                 .Left        = 4
928:                 .Width       = 45
929:                 .Height      = 45
930:                 .FontName    = "Verdana"
931:                 .FontSize    = 8
932:                 .WordWrap    = .T.
933:                 .Caption     = ""
934:                 .ForeColor   = RGB(36, 84, 155)
935:                 .BackColor   = RGB(255, 255, 255)
936:                 .Themes      = .F.
937:                 .ToolTipText = "Marcar Todas as Empresas"
938:                 .Picture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
939:             ENDWITH
940:             WITH .Buttons(2)
941:                 .Top         = 46
942:                 .Left        = 4
943:                 .Width       = 45
944:                 .Height      = 45
945:                 .FontName    = "Verdana"
946:                 .FontSize    = 8
947:                 .WordWrap    = .T.
948:                 .Caption     = ""
949:                 .ForeColor   = RGB(36, 84, 155)
950:                 .BackColor   = RGB(255, 255, 255)
951:                 .Themes      = .F.
952:                 .ToolTipText = "Desmarcar Todas as Empresas"
953:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
954:             ENDWITH
955:             .Visible = .T.
956:         ENDWITH
957: 
958:         *-- chk_4c_Ck_MarcaEmp (ck_MarcaEmp no legado) - Top/Left EXATOS do
959:         *-- SCX (Left = -2, quase fora da pagina - transcrito fielmente,
960:         *-- regra #28/PILAR 1: nao inventar posicao nova)
961:         par_oPag.AddObject("chk_4c_Ck_MarcaEmp", "CheckBox")
962:         WITH par_oPag.chk_4c_Ck_MarcaEmp
963:             .Top       = 314
964:             .Left      = -2
965:             .Width     = 13
966:             .Height    = 16
967:             .Alignment = 0
968:             .Caption   = ""
969:             .Value     = 1
970:             .Visible   = .T.
971:         ENDWITH
972: 
973:         *-- grd_4c_Tipos (grdTipo no legado): marcacao (nMarcas) + Tipo de Operacao
974:         par_oPag.AddObject("grd_4c_Tipos", "Grid")
975:         WITH par_oPag.grd_4c_Tipos
976:             .Top            = 238
977:             .Left           = 469
978:             .Width          = 323
979:             .Height         = 196
980:             .ColumnCount    = 2
981:             .FontName       = "Tahoma"
982:             .FontSize       = 8
983:             .AllowRowSizing = .F.
984:             .DeleteMark     = .F.
985:             .GridLines      = 3
986:             .HeaderHeight   = 16
987:             .RowHeight      = 16
988:             .ScrollBars     = 2
989:             .TabStop        = .F.
990:             .ForeColor      = RGB(0, 0, 0)
991:             .BackColor      = RGB(255, 255, 244)
992:             .GridLineColor  = RGB(238, 238, 238)
993:             .Themes         = .F.
994:             .Visible        = .T.
995:             .RecordMark   = .F.
996:         ENDWITH
997:         WITH par_oPag.grd_4c_Tipos.Column1
998:             .Width     = 18
999:             .Alignment = 0
1000:             .FontName  = "Tahoma"
1001:             .FontSize  = 8
1002:             *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
1003:             *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
1004:             *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
1005:             .Movable   = .F.
1006:             .Resizable = .F.
1007:             .ReadOnly  = .T.
1008:             .ForeColor = RGB(0, 0, 0)
1009:             .BackColor = RGB(255, 255, 255)
1010:         ENDWITH
1011:         par_oPag.grd_4c_Tipos.Column1.Header1.Caption   = ""
1012:         par_oPag.grd_4c_Tipos.Column1.Header1.ForeColor = RGB(90, 90, 90)
1013:         WITH par_oPag.grd_4c_Tipos.Column2
1014:             .Width     = 282
1015:             .Movable   = .F.
1016:             .Resizable = .F.
1017:             .ReadOnly  = .T.
1018:             .FontName  = "Tahoma"
1019:             .FontSize  = 8
1020:             .ForeColor = RGB(0, 0, 0)
1021:             .BackColor = RGB(255, 255, 255)
1022:         ENDWITH
1023:         par_oPag.grd_4c_Tipos.Column2.Header1.Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
1024:         par_oPag.grd_4c_Tipos.Column2.Header1.Alignment = 2
1025:         par_oPag.grd_4c_Tipos.Column2.Header1.ForeColor = RGB(90, 90, 90)
1026: 
1027:         *-- cmd_4c_BtnMarca / cmd_4c_BtnDesmarca: marca/desmarca TODOS os
1028:         *-- Tipos de Operacao e TODAS as Operacoes (btnMarca/btnDesmarca no
1029:         *-- legado - coluna de botoes a direita de grd_4c_Tipos)
1030:         par_oPag.AddObject("cmd_4c_BtnMarca", "CommandButton")
1031:         WITH par_oPag.cmd_4c_BtnMarca
1032:             .Top         = 286
1033:             .Left        = 796
1034:             .Width       = 45
1035:             .Height      = 45
1036:             .FontName    = "Arial"
1037:             .FontSize    = 7
1038:             .Caption     = ""
1039:             .ForeColor   = RGB(255, 0, 0)
1040:             .BackColor   = RGB(255, 255, 255)
1041:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1042:             *-- com .Picture nao renderiza o icone com Themes = .F.
1043:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -
1044:             *-- canonico do projeto para botao solto; Buttons(N) de

*-- Linhas 1051 a 1067:
1051:             .Visible = .T.
1052:         ENDWITH
1053: 
1054:         par_oPag.AddObject("cmd_4c_BtnDesmarca", "CommandButton")
1055:         WITH par_oPag.cmd_4c_BtnDesmarca
1056:             .Top         = 331
1057:             .Left        = 796
1058:             .Width       = 45
1059:             .Height      = 45
1060:             .FontName    = "Arial"
1061:             .FontSize    = 7
1062:             .Caption     = ""
1063:             .ForeColor   = RGB(255, 0, 0)
1064:             .BackColor   = RGB(255, 255, 255)
1065:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1066:             *-- com .Picture nao renderiza o icone com Themes = .F.
1067:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -

*-- Linhas 1074 a 1094:
1074:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1075:             .Visible = .T.
1076:         ENDWITH
1077: 
1078:         *-- cmd_4c_Command1 / cmd_4c_Command2: marca/desmarca so as
1079:         *-- Operacoes do Tipo de Operacao CORRENTE em grd_4c_Tipos
1080:         *-- (Command1/Command2 no legado, mesma coluna, mais abaixo)
1081:         par_oPag.AddObject("cmd_4c_Command1", "CommandButton")
1082:         WITH par_oPag.cmd_4c_Command1
1083:             .Top         = 489
1084:             .Left        = 796
1085:             .Width       = 45
1086:             .Height      = 45
1087:             .FontName    = "Arial"
1088:             .FontSize    = 7
1089:             .Caption     = ""
1090:             .ForeColor   = RGB(255, 0, 0)
1091:             .BackColor   = RGB(255, 255, 255)
1092:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1093:             *-- com .Picture nao renderiza o icone com Themes = .F.
1094:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -

*-- Linhas 1102 a 1118:
1102:             .Visible = .T.
1103:         ENDWITH
1104: 
1105:         par_oPag.AddObject("cmd_4c_Command2", "CommandButton")
1106:         WITH par_oPag.cmd_4c_Command2
1107:             .Top         = 534
1108:             .Left        = 796
1109:             .Width       = 45
1110:             .Height      = 45
1111:             .FontName    = "Arial"
1112:             .FontSize    = 7
1113:             .Caption     = ""
1114:             .ForeColor   = RGB(255, 0, 0)
1115:             .BackColor   = RGB(255, 255, 255)
1116:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1117:             *-- com .Picture nao renderiza o icone com Themes = .F.
1118:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -

*-- Linhas 1124 a 1196:
1124:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1125:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1126:             .Visible = .T.
1127:         ENDWITH
1128: 
1129:         *-- grd_4c_GrandeGrupo (grdMercs no legado): marcacao (nMarcas) + Grande Grupo
1130:         par_oPag.AddObject("grd_4c_GrandeGrupo", "Grid")
1131:         WITH par_oPag.grd_4c_GrandeGrupo
1132:             .Top            = 238
1133:             .Left           = 880
1134:             .Width          = 323
1135:             .Height         = 196
1136:             .ColumnCount    = 2
1137:             .FontName       = "Tahoma"
1138:             .FontSize       = 8
1139:             .AllowRowSizing = .F.
1140:             .DeleteMark     = .F.
1141:             .GridLines      = 3
1142:             .HeaderHeight   = 16
1143:             .RowHeight      = 16
1144:             .ScrollBars     = 2
1145:             .TabStop        = .F.
1146:             .ForeColor      = RGB(0, 0, 0)
1147:             .GridLineColor  = RGB(238, 238, 238)
1148:             .Themes         = .F.
1149:             .Visible        = .T.
1150:             .RecordMark   = .F.
1151:         ENDWITH
1152:         WITH par_oPag.grd_4c_GrandeGrupo.Column1
1153:             .Width     = 18
1154:             .Alignment = 0
1155:             .FontName  = "Tahoma"
1156:             .FontSize  = 8
1157:             *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
1158:             *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
1159:             *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
1160:             .Movable   = .F.
1161:             .Resizable = .F.
1162:             .ReadOnly  = .T.
1163:             .ForeColor = RGB(0, 0, 0)
1164:         ENDWITH
1165:         par_oPag.grd_4c_GrandeGrupo.Column1.Header1.Caption   = ""
1166:         par_oPag.grd_4c_GrandeGrupo.Column1.Header1.ForeColor = RGB(90, 90, 90)
1167:         WITH par_oPag.grd_4c_GrandeGrupo.Column2
1168:             .Width     = 283
1169:             .Movable   = .F.
1170:             .Resizable = .F.
1171:             .ReadOnly  = .T.
1172:             .FontName  = "Tahoma"
1173:             .FontSize  = 8
1174:             .ForeColor = RGB(0, 0, 0)
1175:         ENDWITH
1176:         par_oPag.grd_4c_GrandeGrupo.Column2.Header1.Caption   = "Grande Grupo"
1177:         par_oPag.grd_4c_GrandeGrupo.Column2.Header1.Alignment = 2
1178:         par_oPag.grd_4c_GrandeGrupo.Column2.Header1.ForeColor = RGB(90, 90, 90)
1179: 
1180:         *-- cmd_4c_BtnMarGde / cmd_4c_BtnDesGde: marca/desmarca TODO o
1181:         *-- Grande Grupo (e em cascata o Grupo de Produto - BtnMarGdeClick/
1182:         *-- BtnDesGdeClick)
1183:         par_oPag.AddObject("cmd_4c_BtnMarGde", "CommandButton")
1184:         WITH par_oPag.cmd_4c_BtnMarGde
1185:             .Top         = 286
1186:             .Left        = 1207
1187:             .Width       = 45
1188:             .Height      = 45
1189:             .FontName    = "Arial"
1190:             .FontSize    = 7
1191:             .Caption     = ""
1192:             .ForeColor   = RGB(255, 0, 0)
1193:             .BackColor   = RGB(255, 255, 255)
1194:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1195:             *-- com .Picture nao renderiza o icone com Themes = .F.
1196:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -

*-- Linhas 1204 a 1220:
1204:             .Visible = .T.
1205:         ENDWITH
1206: 
1207:         par_oPag.AddObject("cmd_4c_BtnDesGde", "CommandButton")
1208:         WITH par_oPag.cmd_4c_BtnDesGde
1209:             .Top         = 331
1210:             .Left        = 1207
1211:             .Width       = 45
1212:             .Height      = 45
1213:             .FontName    = "Arial"
1214:             .FontSize    = 7
1215:             .Caption     = ""
1216:             .ForeColor   = RGB(255, 0, 0)
1217:             .BackColor   = RGB(255, 255, 255)
1218:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1219:             *-- com .Picture nao renderiza o icone com Themes = .F.
1220:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -

*-- Linhas 1226 a 1310:
1226:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1227:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1228:             .Visible = .T.
1229:         ENDWITH
1230: 
1231:         *-- grd_4c_GrupoProduto (grdCGrus no legado): marcacao (nMarcas) + Gde + Grupo de Produto
1232:         par_oPag.AddObject("grd_4c_GrupoProduto", "Grid")
1233:         WITH par_oPag.grd_4c_GrupoProduto
1234:             .Top            = 446
1235:             .Left           = 880
1236:             .Width          = 323
1237:             .Height         = 196
1238:             .ColumnCount    = 3
1239:             .FontName       = "Tahoma"
1240:             .FontSize       = 8
1241:             .AllowRowSizing = .F.
1242:             .DeleteMark     = .F.
1243:             .GridLines      = 3
1244:             .HeaderHeight   = 16
1245:             .RowHeight      = 16
1246:             .ScrollBars     = 2
1247:             .TabStop        = .F.
1248:             .ForeColor      = RGB(0, 0, 0)
1249:             .GridLineColor  = RGB(238, 238, 238)
1250:             .Themes         = .F.
1251:             .Visible        = .T.
1252:             .RecordMark   = .F.
1253:         ENDWITH
1254:         WITH par_oPag.grd_4c_GrupoProduto.Column1
1255:             .Width     = 18
1256:             .Alignment = 0
1257:             .FontName  = "Tahoma"
1258:             .FontSize  = 8
1259:             *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
1260:             *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
1261:             *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
1262:             .Movable   = .F.
1263:             .Resizable = .F.
1264:             .ReadOnly  = .T.
1265:             .ForeColor = RGB(0, 0, 0)
1266:         ENDWITH
1267:         par_oPag.grd_4c_GrupoProduto.Column1.Header1.Caption   = ""
1268:         par_oPag.grd_4c_GrupoProduto.Column1.Header1.ForeColor = RGB(90, 90, 90)
1269:         WITH par_oPag.grd_4c_GrupoProduto.Column2
1270:             .Width     = 30
1271:             .Movable   = .F.
1272:             .Resizable = .F.
1273:             .ReadOnly  = .T.
1274:             .FontName  = "Tahoma"
1275:             .FontSize  = 8
1276:             .ForeColor = RGB(0, 0, 0)
1277:         ENDWITH
1278:         par_oPag.grd_4c_GrupoProduto.Column2.Header1.Caption   = "Gde"
1279:         par_oPag.grd_4c_GrupoProduto.Column2.Header1.Alignment = 2
1280:         par_oPag.grd_4c_GrupoProduto.Column2.Header1.ForeColor = RGB(90, 90, 90)
1281:         WITH par_oPag.grd_4c_GrupoProduto.Column3
1282:             .Width     = 252
1283:             .FontName  = "Tahoma"
1284:             .FontSize  = 8
1285:             .ForeColor = RGB(0, 0, 0)
1286:             .Movable   = .F.
1287:             .Resizable = .F.
1288:             .ReadOnly  = .T.
1289:         ENDWITH
1290:         par_oPag.grd_4c_GrupoProduto.Column3.Header1.Caption   = "Grupo de Produto"
1291:         par_oPag.grd_4c_GrupoProduto.Column3.Header1.Alignment = 2
1292:         par_oPag.grd_4c_GrupoProduto.Column3.Header1.ForeColor = RGB(90, 90, 90)
1293: 
1294:         *-- cmd_4c_BtnMarGrp / cmd_4c_BtnDesGrp: marca/desmarca o Grupo de
1295:         *-- Produto (btnMarGrp so marca onde o Grande Grupo pai ja esta
1296:         *-- marcado - igual ao legado)
1297:         par_oPag.AddObject("cmd_4c_BtnMarGrp", "CommandButton")
1298:         WITH par_oPag.cmd_4c_BtnMarGrp
1299:             .Top         = 489
1300:             .Left        = 1207
1301:             .Width       = 45
1302:             .Height      = 45
1303:             .FontName    = "Arial"
1304:             .FontSize    = 7
1305:             .Caption     = ""
1306:             .ForeColor   = RGB(255, 0, 0)
1307:             .BackColor   = RGB(255, 255, 255)
1308:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1309:             *-- com .Picture nao renderiza o icone com Themes = .F.
1310:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -

*-- Linhas 1318 a 1334:
1318:             .Visible = .T.
1319:         ENDWITH
1320: 
1321:         par_oPag.AddObject("cmd_4c_BtnDesGrp", "CommandButton")
1322:         WITH par_oPag.cmd_4c_BtnDesGrp
1323:             .Top         = 534
1324:             .Left        = 1207
1325:             .Width       = 45
1326:             .Height      = 45
1327:             .FontName    = "Arial"
1328:             .FontSize    = 7
1329:             .Caption     = ""
1330:             .ForeColor   = RGB(255, 0, 0)
1331:             .BackColor   = RGB(255, 255, 255)
1332:             *-- Themes = .T. + DisabledPicture: CommandButton STANDALONE
1333:             *-- com .Picture nao renderiza o icone com Themes = .F.
1334:             *-- Divergencia DELIBERADA do SCX legado (que grava .F.) -

*-- Linhas 1340 a 1439:
1340:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1341:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1342:             .Visible = .T.
1343:         ENDWITH
1344: 
1345:         *-- grd_4c_Operacoes (GrdOpera no legado): marcacao (nMarcas) + Operacoes (Dopes)
1346:         par_oPag.AddObject("grd_4c_Operacoes", "Grid")
1347:         WITH par_oPag.grd_4c_Operacoes
1348:             .Top            = 446
1349:             .Left           = 470
1350:             .Width          = 323
1351:             .Height         = 196
1352:             .ColumnCount    = 2
1353:             .FontName       = "Tahoma"
1354:             .FontSize       = 8
1355:             .AllowRowSizing = .F.
1356:             .DeleteMark     = .F.
1357:             .GridLines      = 3
1358:             .HeaderHeight   = 16
1359:             .RowHeight      = 16
1360:             .ScrollBars     = 2
1361:             .TabStop        = .F.
1362:             .ForeColor      = RGB(0, 0, 0)
1363:             .BackColor      = RGB(255, 255, 244)
1364:             .GridLineColor  = RGB(238, 238, 238)
1365:             .Themes         = .F.
1366:             .Visible        = .T.
1367:             .RecordMark   = .F.
1368:         ENDWITH
1369:         WITH par_oPag.grd_4c_Operacoes.Column1
1370:             .Width     = 18
1371:             .Alignment = 0
1372:             .FontName  = "Tahoma"
1373:             .FontSize  = 8
1374:             *-- "For I = 1 To .ColumnCount" do montagrades legado inclui a
1375:             *-- Column1: ela fica TRAVADA e o toggle do CheckBox acontece
1376:             *-- so pelos handlers KeyPress/MouseUp com NODEFAULT.
1377:             .Movable   = .F.
1378:             .Resizable = .F.
1379:             .ReadOnly  = .T.
1380:             .ForeColor = RGB(0, 0, 0)
1381:             .BackColor = RGB(255, 255, 255)
1382:         ENDWITH
1383:         par_oPag.grd_4c_Operacoes.Column1.Header1.Caption   = ""
1384:         par_oPag.grd_4c_Operacoes.Column1.Header1.ForeColor = RGB(90, 90, 90)
1385:         WITH par_oPag.grd_4c_Operacoes.Column2
1386:             .Width     = 282
1387:             .Movable   = .F.
1388:             .Resizable = .F.
1389:             .ReadOnly  = .T.
1390:             .FontName  = "Tahoma"
1391:             .FontSize  = 8
1392:             .ForeColor = RGB(0, 0, 0)
1393:             .BackColor = RGB(255, 255, 255)
1394:         ENDWITH
1395:         par_oPag.grd_4c_Operacoes.Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
1396:         par_oPag.grd_4c_Operacoes.Column2.Header1.Alignment = 2
1397:         par_oPag.grd_4c_Operacoes.Column2.Header1.ForeColor = RGB(90, 90, 90)
1398: 
1399:         *-- cmg_4c_Filtros (cmgFiltros no legado): Consultar / Sair
1400:         par_oPag.AddObject("cmg_4c_Filtros", "CommandGroup")
1401:         WITH par_oPag.cmg_4c_Filtros
1402:             .Top         = -1
1403:             .Left        = 1135
1404:             .Width       = 173
1405:             .Height      = 110
1406:             .ButtonCount = 2
1407:             .Value       = 0
1408:             WITH .Buttons(1)
1409:                 .Top         = 5
1410:                 .Left        = 11
1411:                 .Width       = 75
1412:                 .Height      = 75
1413:                 .FontBold    = .T.
1414:                 .FontItalic  = .T.
1415:                 .FontName    = "Comic Sans MS"
1416:                 .FontSize    = 8
1417:                 .Caption     = "\<Consultar"
1418:                 .ToolTipText = "Consultar Usando os Filtros Informados"
1419:                 .ForeColor   = RGB(90, 90, 90)
1420:                 .BackColor   = RGB(255, 255, 255)
1421:                 .Themes      = .F.
1422:                 .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1423:             ENDWITH
1424:             WITH .Buttons(2)
1425:                 .Top         = 5
1426:                 .Left        = 87
1427:                 .Width       = 75
1428:                 .Height      = 75
1429:                 .FontBold    = .T.
1430:                 .FontItalic  = .T.
1431:                 .FontName    = "Comic Sans MS"
1432:                 .FontSize    = 8
1433:                 .Cancel      = .T.
1434:                 .Caption     = "\<Sair"
1435:                 .ToolTipText = "[ESC] Sair"
1436:                 .ForeColor   = RGB(90, 90, 90)
1437:                 .BackColor   = RGB(255, 255, 255)
1438:                 .Themes      = .F.
1439:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 1449 a 1489:
1449:     *
1450:     * A ORDEM abaixo e OBRIGATORIA e foi medida no VFP9:
1451:     *   ColumnCount -> RecordSource -> ControlSource de TODAS as colunas ->
1452:     *   AddObject do CheckBox (+ .Value = 0) -> Sparse + CurrentControl ->
1453:     *   Grid.ReadOnly -> Column.ReadOnly -> Width -> Header1.Caption
1454:     *
1455:     * Por que o CheckBox NAO pode nascer em ConfigurarGradesMarcacao: Grid
1456:     * sem RecordSource atribuida se liga sozinho ao alias CORRENTE no momento
1457:     * em que o ColumnCount e definido. Com isso a Column1 herda o
1458:     * ControlSource de uma coluna qualquer desse alias; se ela for CHARACTER,
1459:     * o Column1.AddObject("Check1","CheckBox") estoura no PROPRIO AddObject
1460:     * com "Error with CHECK1 - Value : Data type mismatch", o erro cai no TRY
1461:     * do InicializarForm, CREATEOBJECT devolve .F. e a TELA NAO ABRE - sem
1462:     * erro visivel e compilando limpo (medido no probe desta fase).
1463:     *
1464:     * E por que o funil, e nao o ConfigurarGrid: fechar/recriar o alias que e
1465:     * RecordSource do Grid DESTROI o objeto posto por Column.AddObject (a
1466:     * Column volta a desenhar o Text1 e o usuario ve 0/1 cru, sem como
1467:     * marcar). Por isso a instalacao do CheckBox e IDEMPOTENTE
1468:     * (GarantirCheckBoxColuna) e os BINDEVENT vao JUNTO com ela - objeto
1469:     * recriado e outro objeto, e as ligacoes do anterior morreram com ele.
1470:     *
1471:     * Fecha cada grade com GO TOP + Refresh: popular o cursor NAO repinta a
1472:     * grade sozinho.
1473:     *
1474:     * As grades de RESULTADO (pgRes01/02/03 -> grd_4c_Dados1/2/3), que no
1475:     * legado sao ligadas pelo MESMO montagrades, entram na Fase 7 - e o bind
1476:     * delas vem para este mesmo funil.
1477:     *==========================================================================
1478:     *-- PUBLIC (nao PROTECTED): e o funil de repintura, chamado de fora pelo
1479:     *-- harness de teste e pelos caminhos de recarga.
1480:     PROCEDURE CarregarDados()
1481:         LOCAL loc_oPag
1482:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1483: 
1484:         *-- Empresas: a UNICA das 5 cuja Column1 e editavel nativamente
1485:         *-- (montagrades legado: grdEmps.Column1.ReadOnly = .F.)
1486:         IF USED("cursor_4c_Empresas")
1487:             WITH loc_oPag.grd_4c_Empresas
1488:                 .ColumnCount             = 3
1489:                 .RecordSource            = "cursor_4c_Empresas"

*-- Linhas 1495 a 1690:
1495:             *-- grdEmps.Column1.Check1 estao COMENTADOS, ou seja o toggle
1496:             *-- individual e nativo (Column1.ReadOnly = .F.) e a marcacao em
1497:             *-- lote vem de cmg_4c_Empresas / chk_4c_Ck_MarcaEmp.
1498:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Empresas.Column1, "", .F., .F.)
1499:             WITH loc_oPag.grd_4c_Empresas
1500:                 .Column1.Sparse           = .F.
1501:                 .AddObject("Check1", "CheckBox")
1502:                 .Check1.Caption = ""
1503:                 .Check1.Alignment = 0
1504:                 .Check1.ReadOnly  = .F.
1505:                 .Check1.Visible   = .T.
1506:                 .Check1.Top       = 9
1507:                 .Check1.Left      = 2
1508:                 .Check1.Height    = 17
1509:                 .Check1.Width     = 22
1510:                 .Column1.CurrentControl   = "Check1"
1511:                 .ReadOnly                 = .F.
1512:                 .Column1.ReadOnly         = .F.
1513:                 .Column2.ReadOnly         = .T.
1514:                 .Column3.ReadOnly         = .T.
1515:                 .Column1.Width            = 15
1516:                 .Column2.Width            = 33
1517:                 .Column3.Width            = 247
1518:                 .Column2.Header1.Caption  = "Cod."
1519:                 .Column3.Header1.Caption  = "Empresa"
1520:             ENDWITH
1521:             GO TOP IN cursor_4c_Empresas
1522:             loc_oPag.grd_4c_Empresas.Refresh()
1523:         ENDIF
1524: 
1525:         *-- Tipos de Operacao
1526:         IF USED("cursor_4c_TiposOperacao")
1527:             WITH loc_oPag.grd_4c_Tipos
1528:                 .ColumnCount             = 2
1529:                 .RecordSource            = "cursor_4c_TiposOperacao"
1530:                 .Column1.ControlSource   = "cursor_4c_TiposOperacao.nMarcas"
1531:                 .Column2.ControlSource   = "cursor_4c_TiposOperacao.CDescricaos"
1532:             ENDWITH
1533:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Tipos.Column1, "ChkTipo", .T., .T.)
1534:             WITH loc_oPag.grd_4c_Tipos
1535:                 .Column1.Sparse           = .F.
1536:                 .AddObject("Check1", "CheckBox")
1537:                 .Check1.Caption = ""
1538:                 .Check1.Alignment = 0
1539:                 .Check1.ReadOnly  = .F.
1540:                 .Check1.Visible   = .T.
1541:                 .Check1.Top       = 9
1542:                 .Check1.Left      = 2
1543:                 .Check1.Height    = 17
1544:                 .Check1.Width     = 22
1545:                 .Column1.CurrentControl   = "Check1"
1546:                 .Column1.ReadOnly         = .T.
1547:                 .Column2.ReadOnly         = .T.
1548:                 .Column1.Width            = 18
1549:                 .Column2.Width            = 282
1550:                 .Column2.Header1.Caption  = "Tipo de Opera" + CHR(231) + CHR(227) + "o"
1551:             ENDWITH
1552:             GO TOP IN cursor_4c_TiposOperacao
1553:             loc_oPag.grd_4c_Tipos.Refresh()
1554:         ENDIF
1555: 
1556:         *-- Grande Grupo
1557:         IF USED("cursor_4c_GrandeGrupo")
1558:             WITH loc_oPag.grd_4c_GrandeGrupo
1559:                 .ColumnCount             = 2
1560:                 .RecordSource            = "cursor_4c_GrandeGrupo"
1561:                 .Column1.ControlSource   = "cursor_4c_GrandeGrupo.nMarcas"
1562:                 .Column2.ControlSource   = "cursor_4c_GrandeGrupo.CDescricaos"
1563:             ENDWITH
1564:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrandeGrupo.Column1, "ChkGrandeGrupo", .T., .F.)
1565:             WITH loc_oPag.grd_4c_GrandeGrupo
1566:                 .Column1.Sparse           = .F.
1567:                 .AddObject("Check1", "CheckBox")
1568:                 .Check1.Caption = ""
1569:                 .Check1.Alignment = 0
1570:                 .Check1.ReadOnly  = .F.
1571:                 .Check1.Visible   = .T.
1572:                 .Check1.Top       = 9
1573:                 .Check1.Left      = 2
1574:                 .Check1.Height    = 17
1575:                 .Check1.Width     = 22
1576:                 .Column1.CurrentControl   = "Check1"
1577:                 .Column1.ReadOnly         = .T.
1578:                 .Column2.ReadOnly         = .T.
1579:                 .Column1.Width            = 18
1580:                 .Column2.Width            = 283
1581:                 .Column2.Header1.Caption  = "Grande Grupo"
1582:             ENDWITH
1583:             GO TOP IN cursor_4c_GrandeGrupo
1584:             loc_oPag.grd_4c_GrandeGrupo.Refresh()
1585:         ENDIF
1586: 
1587:         *-- Grupo de Produto
1588:         IF USED("cursor_4c_GrupoProduto")
1589:             WITH loc_oPag.grd_4c_GrupoProduto
1590:                 .ColumnCount             = 3
1591:                 .RecordSource            = "cursor_4c_GrupoProduto"
1592:                 .Column1.ControlSource   = "cursor_4c_GrupoProduto.nMarcas"
1593:                 .Column2.ControlSource   = "cursor_4c_GrupoProduto.Mercs"
1594:                 .Column3.ControlSource   = "cursor_4c_GrupoProduto.CDescricaos"
1595:             ENDWITH
1596:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrupoProduto.Column1, "ChkGrupoProduto", .T., .F.)
1597:             WITH loc_oPag.grd_4c_GrupoProduto
1598:                 .Column1.Sparse           = .F.
1599:                 .AddObject("Check1", "CheckBox")
1600:                 .Check1.Caption = ""
1601:                 .Check1.Alignment = 0
1602:                 .Check1.ReadOnly  = .F.
1603:                 .Check1.Visible   = .T.
1604:                 .Check1.Top       = 9
1605:                 .Check1.Left      = 2
1606:                 .Check1.Height    = 17
1607:                 .Check1.Width     = 22
1608:                 .Column1.CurrentControl   = "Check1"
1609:                 .Column1.ReadOnly         = .T.
1610:                 .Column2.ReadOnly         = .T.
1611:                 .Column3.ReadOnly         = .T.
1612:                 .Column1.Width            = 18
1613:                 .Column2.Width            = 30
1614:                 .Column3.Width            = 252
1615:                 .Column2.Header1.Caption  = "Gde"
1616:                 .Column3.Header1.Caption  = "Grupo de Produto"
1617:             ENDWITH
1618:             GO TOP IN cursor_4c_GrupoProduto
1619:             loc_oPag.grd_4c_GrupoProduto.Refresh()
1620:         ENDIF
1621: 
1622:         *-- Operacoes
1623:         IF USED("cursor_4c_Operacoes")
1624:             WITH loc_oPag.grd_4c_Operacoes
1625:                 .ColumnCount             = 2
1626:                 .RecordSource            = "cursor_4c_Operacoes"
1627:                 .Column1.ControlSource   = "cursor_4c_Operacoes.nMarcas"
1628:                 .Column2.ControlSource   = "cursor_4c_Operacoes.Dopes"
1629:             ENDWITH
1630:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Operacoes.Column1, "ChkOperacao", .T., .T.)
1631:             WITH loc_oPag.grd_4c_Operacoes
1632:                 .Column1.Sparse           = .F.
1633:                 .AddObject("Check1", "CheckBox")
1634:                 .Check1.Caption = ""
1635:                 .Check1.Alignment = 0
1636:                 .Check1.ReadOnly  = .F.
1637:                 .Check1.Visible   = .T.
1638:                 .Check1.Top       = 9
1639:                 .Check1.Left      = 2
1640:                 .Check1.Height    = 17
1641:                 .Check1.Width     = 22
1642:                 .Column1.CurrentControl   = "Check1"
1643:                 .Column1.ReadOnly         = .T.
1644:                 .Column2.ReadOnly         = .T.
1645:                 .Column1.Width            = 18
1646:                 .Column2.Width            = 282
1647:                 .Column2.Header1.Caption  = "Opera" + CHR(231) + CHR(245) + "es"
1648:             ENDWITH
1649:             GO TOP IN cursor_4c_Operacoes
1650:             loc_oPag.grd_4c_Operacoes.Refresh()
1651:         ENDIF
1652:     ENDPROC
1653: 
1654:     *==========================================================================
1655:     * GarantirCheckBoxColuna - instalador IDEMPOTENTE do CheckBox de marcacao
1656:     * de uma Column de Grid. Chamado SO depois de RecordSource/ControlSource
1657:     * estarem ligados (ver comentario de CarregarDados).
1658:     *
1659:     *   par_oColuna    - a Column que recebe o controle
1660:     *   par_cPrefixo   - prefixo dos handlers de alternancia ("ChkTipo", ...);
1661:     *                    vazio = coluna com toggle NATIVO, sem BINDEVENT
1662:     *   par_lGeometria - transcreve Top/Left/Width/Height/Alignment do SCX
1663:     *   par_lBackColor - transcreve BackColor branco do SCX
1664:     *
1665:     * Sai sem fazer nada se o controle ainda existe: AddObject repetido com o
1666:     * mesmo nome estoura "Object CHECK1 is already defined". Os BINDEVENT vao
1667:     * JUNTO porque um objeto recriado e outro objeto - sem religar, os quatro
1668:     * handlers de alternancia ficam MUDOS (o CheckBox aparece e nao alterna).
1669:     *==========================================================================
1670:     PROTECTED PROCEDURE GarantirCheckBoxColuna(par_oColuna, par_cPrefixo, par_lGeometria, par_lBackColor)
1671:         IF PEMSTATUS(par_oColuna, "Check1", 5)
1672:             RETURN
1673:         ENDIF
1674: 
1675:         par_oColuna.AddObject("Check1", "CheckBox")
1676: 
1677:         WITH par_oColuna.Check1
1678:             .Caption   = ""
1679:             *-- .Value NUMERICO (nunca .F.): a Column esta ligada a coluna
1680:             *-- numerica de marcacao e CheckBox logico daria type mismatch.
1681:             .Value     = 0
1682:             .ForeColor = RGB(0, 0, 0)
1683:             IF par_lGeometria
1684:                 .Top       = 23
1685:                 .Left      = 35
1686:                 .Width     = 60
1687:                 .Height    = 17
1688:                 .Alignment = 0
1689:             ENDIF
1690:             IF par_lBackColor

*-- Linhas 1708 a 1734:
1708:     * ConfigurarBindEventsFiltros - BINDEVENTs dos botoes e grupos de
1709:     * marcar/desmarcar/consultar/sair da pagina de filtros.
1710:     *
1711:     * Os BINDEVENT dos CheckBox de LINHA das grades NAO moram aqui: eles vao
1712:     * dentro de GarantirCheckBoxColuna, junto com o AddObject que cria o
1713:     * controle. Motivo: o controle de Column pode ser destruido quando o
1714:     * alias do RecordSource e fechado/recriado, e o objeto reinstalado e
1715:     * OUTRO objeto - religar fora do instalador deixaria os handlers mudos.
1716:     *==========================================================================
1717:     PROTECTED PROCEDURE ConfigurarBindEventsFiltros()
1718:         LOCAL loc_oPag
1719:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1720: 
1721:         *-- Botoes em lote
1722:         BINDEVENT(loc_oPag.cmd_4c_BtnMarca,    "Click", THIS, "BtnMarcaClick")
1723:         BINDEVENT(loc_oPag.cmd_4c_BtnDesmarca, "Click", THIS, "BtnDesmarcaClick")
1724:         BINDEVENT(loc_oPag.cmd_4c_Command1,    "Click", THIS, "Command1Click")
1725:         BINDEVENT(loc_oPag.cmd_4c_Command2,    "Click", THIS, "Command2Click")
1726:         BINDEVENT(loc_oPag.cmd_4c_BtnMarGde,   "Click", THIS, "BtnMarGdeClick")
1727:         BINDEVENT(loc_oPag.cmd_4c_BtnDesGde,   "Click", THIS, "BtnDesGdeClick")
1728:         BINDEVENT(loc_oPag.cmd_4c_BtnMarGrp,   "Click", THIS, "BtnMarGrpClick")
1729:         BINDEVENT(loc_oPag.cmd_4c_BtnDesGrp,   "Click", THIS, "BtnDesGrpClick")
1730: 
1731:         *-- Empresas (marcar/desmarcar tudo)
1732:         BINDEVENT(loc_oPag.cmg_4c_Empresas,     "Click", THIS, "CmdEmpsClick")
1733:         BINDEVENT(loc_oPag.chk_4c_Ck_MarcaEmp, "Click", THIS, "CkMarcaEmpClick")
1734: 

*-- Linhas 1752 a 1772:
1752:         BINDEVENT(loc_oPag.txt_4c__cd_sgrupo, "LostFocus", THIS, "TxtCdSgrupoLostFocus")
1753:         BINDEVENT(loc_oPag.txt_4c__ds_sgrupo, "LostFocus", THIS, "TxtDsSgrupoLostFocus")
1754: 
1755:         *-- Tipo de Operacao corrente FILTRA a grade de Operacoes
1756:         *-- (grdTipo.AfterRowColChange no legado)
1757:         BINDEVENT(loc_oPag.grd_4c_Tipos, "AfterRowColChange", THIS, "GrdTiposAfterRowColChange")
1758:     ENDPROC
1759: 
1760:     *==========================================================================
1761:     * GrdTiposAfterRowColChange - grdTipo.AfterRowColChange no legado:
1762:     *
1763:     *   Select CrOpera
1764:     *   Set Key To crTpOpe.Codigos
1765:     *   Go Top
1766:     *   This.parent.GrdOpera.Refresh
1767:     *   Select crTpOpe
1768:     *
1769:     * Ao trocar de linha na grade de TIPOS, a grade de OPERACOES passa a
1770:     * mostrar SOMENTE as operacoes daquele tipo. O SET KEY depende da TAG
1771:     * IdxTipoOps (criada em BO.CarregarFiltrosIniciais, igual ao Init
1772:     * legado); o SET ORDER explicito abaixo NAO esta no legado - la o tag

*-- Linhas 1802 a 1892:
1802:             SELECT cursor_4c_Operacoes
1803:             SET ORDER TO TAG IdxTipoOps
1804:             SET KEY TO cursor_4c_TiposOperacao.Codigos
1805:             GO TOP
1806: 
1807:             loc_oPag.grd_4c_Operacoes.Refresh()
1808:         CATCH TO loc_oErro
1809:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1810:                 "Procedure: " + loc_oErro.Procedure, "Erro ao filtrar Opera" + CHR(231) + CHR(245) + "es")
1811:         ENDTRY
1812: 
1813:         SELECT cursor_4c_TiposOperacao
1814:     ENDPROC
1815: 
1816:     *==========================================================================
1817:     * GRADE TIPOS DE OPERACAO - checkbox Column1 (grdTipo.Column1.Check1 no
1818:     * legado). Ao marcar/desmarcar um Tipo, cascateia para as Operacoes
1819:     * (cursor_4c_Operacoes.nMarcas) daquele Tipo - igual ao legado.
1820:     *==========================================================================
1821:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1822:         LOCAL loc_oPag
1823:         IF INLIST(par_nKeyCode, 13, 32)
1824:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1825:             IF USED("cursor_4c_TiposOperacao")
1826:                 REPLACE cursor_4c_TiposOperacao.nMarcas WITH IIF(cursor_4c_TiposOperacao.nMarcas = 0, 1, 0)
1827:                 loc_oPag.grd_4c_Tipos.Refresh()
1828:                 IF USED("cursor_4c_Operacoes")
1829:                     UPDATE cursor_4c_Operacoes SET nMarcas = cursor_4c_TiposOperacao.nMarcas ;
1830:                         WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
1831:                     loc_oPag.grd_4c_Operacoes.Refresh()
1832:                 ENDIF
1833:             ENDIF
1834:             NODEFAULT
1835:         ENDIF
1836:     ENDPROC
1837: 
1838:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1839:         THIS.ChkTipoKeyPress(13, 0)
1840:         NODEFAULT
1841:     ENDPROC
1842: 
1843:     PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1844:         NODEFAULT
1845:     ENDPROC
1846: 
1847:     PROCEDURE ChkTipoClick()
1848:         NODEFAULT
1849:     ENDPROC
1850: 
1851:     *==========================================================================
1852:     * GRADE GRANDE GRUPO - checkbox Column1 (grdMercs.Column1.Check1 no
1853:     * legado). Ao marcar/desmarcar um Grande Grupo, cascateia para o Grupo
1854:     * de Produto filho (cursor_4c_GrupoProduto.nMarcas) - igual ao legado.
1855:     *==========================================================================
1856:     PROCEDURE ChkGrandeGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1857:         LOCAL loc_oPag
1858:         IF INLIST(par_nKeyCode, 13, 32)
1859:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1860:             IF USED("cursor_4c_GrandeGrupo")
1861:                 REPLACE cursor_4c_GrandeGrupo.nMarcas WITH IIF(cursor_4c_GrandeGrupo.nMarcas = 0, 1, 0)
1862:                 loc_oPag.grd_4c_GrandeGrupo.Refresh()
1863:                 IF USED("cursor_4c_GrupoProduto")
1864:                     UPDATE cursor_4c_GrupoProduto SET nMarcas = cursor_4c_GrandeGrupo.nMarcas ;
1865:                         WHERE Mercs = cursor_4c_GrandeGrupo.Codigos
1866:                     loc_oPag.grd_4c_GrupoProduto.Refresh()
1867:                 ENDIF
1868:             ENDIF
1869:             NODEFAULT
1870:         ENDIF
1871:     ENDPROC
1872: 
1873:     PROCEDURE ChkGrandeGrupoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1874:         THIS.ChkGrandeGrupoKeyPress(13, 0)
1875:         NODEFAULT
1876:     ENDPROC
1877: 
1878:     PROCEDURE ChkGrandeGrupoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1879:         NODEFAULT
1880:     ENDPROC
1881: 
1882:     PROCEDURE ChkGrandeGrupoClick()
1883:         NODEFAULT
1884:     ENDPROC
1885: 
1886:     *==========================================================================
1887:     * GRADE GRUPO DE PRODUTO - checkbox Column1 (grdCGrus.Column1.Check1 no
1888:     * legado). Ao MARCAR um Grupo de Produto, exige que o Grande Grupo pai
1889:     * (cursor_4c_GrandeGrupo) ja esteja marcado - senao desfaz e avisa,
1890:     * igual ao legado.
1891:     *==========================================================================
1892:     PROCEDURE ChkGrupoProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 1907 a 2088:
1907:                             "Para Selecionar Esse Grupo, Ajuste o Grande Grupo!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1908:                     ENDIF
1909:                 ENDIF
1910: 
1911:                 SELECT cursor_4c_GrupoProduto
1912:                 loc_oPag.grd_4c_GrupoProduto.Refresh()
1913:             ENDIF
1914:             NODEFAULT
1915:         ENDIF
1916:     ENDPROC
1917: 
1918:     PROCEDURE ChkGrupoProdutoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1919:         THIS.ChkGrupoProdutoKeyPress(13, 0)
1920:         NODEFAULT
1921:     ENDPROC
1922: 
1923:     PROCEDURE ChkGrupoProdutoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1924:         NODEFAULT
1925:     ENDPROC
1926: 
1927:     PROCEDURE ChkGrupoProdutoClick()
1928:         NODEFAULT
1929:     ENDPROC
1930: 
1931:     *==========================================================================
1932:     * GRADE OPERACOES - checkbox Column1 (GrdOpera.Column1.Check1 no legado)
1933:     *==========================================================================
1934:     PROCEDURE ChkOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1935:         LOCAL loc_oPag
1936:         IF INLIST(par_nKeyCode, 13, 32)
1937:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1938:             IF USED("cursor_4c_Operacoes")
1939:                 REPLACE cursor_4c_Operacoes.nMarcas WITH IIF(cursor_4c_Operacoes.nMarcas = 0, 1, 0)
1940:                 loc_oPag.grd_4c_Operacoes.Refresh()
1941:             ENDIF
1942:             NODEFAULT
1943:         ENDIF
1944:     ENDPROC
1945: 
1946:     PROCEDURE ChkOperacaoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1947:         THIS.ChkOperacaoKeyPress(13, 0)
1948:         NODEFAULT
1949:     ENDPROC
1950: 
1951:     PROCEDURE ChkOperacaoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1952:         NODEFAULT
1953:     ENDPROC
1954: 
1955:     PROCEDURE ChkOperacaoClick()
1956:         NODEFAULT
1957:     ENDPROC
1958: 
1959:     *==========================================================================
1960:     * Command1Click / Command2Click - marcam/desmarcam so as Operacoes do
1961:     * Tipo de Operacao CORRENTE em grd_4c_Tipos (Command1/Command2 no legado)
1962:     *==========================================================================
1963:     PROCEDURE Command1Click()
1964:         LOCAL loc_oPag
1965:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1966:         IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
1967:             UPDATE cursor_4c_Operacoes SET nMarcas = 1 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
1968:             GO TOP IN cursor_4c_Operacoes
1969:             loc_oPag.grd_4c_Operacoes.Refresh()
1970:         ENDIF
1971:     ENDPROC
1972: 
1973:     PROCEDURE Command2Click()
1974:         LOCAL loc_oPag
1975:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1976:         IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
1977:             UPDATE cursor_4c_Operacoes SET nMarcas = 0 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
1978:             GO TOP IN cursor_4c_Operacoes
1979:             loc_oPag.grd_4c_Operacoes.Refresh()
1980:         ENDIF
1981:     ENDPROC
1982: 
1983:     *==========================================================================
1984:     * BtnMarcaClick / BtnDesmarcaClick - marcam/desmarcam TODOS os Tipos de
1985:     * Operacao e TODAS as Operacoes (btnMarca/btnDesmarca no legado)
1986:     *==========================================================================
1987:     PROCEDURE BtnMarcaClick()
1988:         LOCAL loc_oPag
1989:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1990:         IF USED("cursor_4c_TiposOperacao")
1991:             UPDATE cursor_4c_TiposOperacao SET nMarcas = 1
1992:             GO TOP IN cursor_4c_TiposOperacao
1993:             loc_oPag.grd_4c_Tipos.Refresh()
1994:         ENDIF
1995:         IF USED("cursor_4c_Operacoes")
1996:             UPDATE cursor_4c_Operacoes SET nMarcas = 1
1997:             GO TOP IN cursor_4c_Operacoes
1998:             loc_oPag.grd_4c_Operacoes.Refresh()
1999:         ENDIF
2000:     ENDPROC
2001: 
2002:     PROCEDURE BtnDesmarcaClick()
2003:         LOCAL loc_oPag
2004:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2005:         IF USED("cursor_4c_TiposOperacao")
2006:             UPDATE cursor_4c_TiposOperacao SET nMarcas = 0
2007:             GO TOP IN cursor_4c_TiposOperacao
2008:             loc_oPag.grd_4c_Tipos.Refresh()
2009:         ENDIF
2010:         IF USED("cursor_4c_Operacoes")
2011:             UPDATE cursor_4c_Operacoes SET nMarcas = 0
2012:             GO TOP IN cursor_4c_Operacoes
2013:             loc_oPag.grd_4c_Operacoes.Refresh()
2014:         ENDIF
2015:     ENDPROC
2016: 
2017:     *==========================================================================
2018:     * BtnMarGdeClick / BtnDesGdeClick - marcam/desmarcam TODO o Grande Grupo
2019:     * e TODO o Grupo de Produto (btnMarGde/btnDesGde no legado)
2020:     *==========================================================================
2021:     PROCEDURE BtnMarGdeClick()
2022:         LOCAL loc_oPag
2023:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2024:         IF USED("cursor_4c_GrandeGrupo")
2025:             UPDATE cursor_4c_GrandeGrupo SET nMarcas = 1
2026:             GO TOP IN cursor_4c_GrandeGrupo
2027:             loc_oPag.grd_4c_GrandeGrupo.Refresh()
2028:         ENDIF
2029:         IF USED("cursor_4c_GrupoProduto")
2030:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 1
2031:             GO TOP IN cursor_4c_GrupoProduto
2032:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2033:         ENDIF
2034:     ENDPROC
2035: 
2036:     PROCEDURE BtnDesGdeClick()
2037:         LOCAL loc_oPag
2038:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2039:         IF USED("cursor_4c_GrandeGrupo")
2040:             UPDATE cursor_4c_GrandeGrupo SET nMarcas = 0
2041:             GO TOP IN cursor_4c_GrandeGrupo
2042:             loc_oPag.grd_4c_GrandeGrupo.Refresh()
2043:         ENDIF
2044:         IF USED("cursor_4c_GrupoProduto")
2045:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
2046:             GO TOP IN cursor_4c_GrupoProduto
2047:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2048:         ENDIF
2049:     ENDPROC
2050: 
2051:     *==========================================================================
2052:     * BtnMarGrpClick / BtnDesGrpClick - marcam/desmarcam o Grupo de Produto
2053:     * (btnMarGrp/btnDesGrp no legado). Marcar so afeta linhas cujo Grande
2054:     * Grupo pai JA ESTA marcado (igual ao legado).
2055:     *==========================================================================
2056:     PROCEDURE BtnMarGrpClick()
2057:         LOCAL loc_oPag
2058:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2059:         IF USED("cursor_4c_GrupoProduto") AND USED("cursor_4c_GrandeGrupo")
2060:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 1 ;
2061:                 WHERE Mercs IN (SELECT Codigos FROM cursor_4c_GrandeGrupo WHERE nMarcas = 1)
2062:             GO TOP IN cursor_4c_GrupoProduto
2063:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2064:         ENDIF
2065:     ENDPROC
2066: 
2067:     PROCEDURE BtnDesGrpClick()
2068:         LOCAL loc_oPag
2069:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2070:         IF USED("cursor_4c_GrupoProduto")
2071:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
2072:             GO TOP IN cursor_4c_GrupoProduto
2073:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2074:         ENDIF
2075:     ENDPROC
2076: 
2077:     *==========================================================================
2078:     * CmdEmpsClick - cmg_4c_Empresas (cmdEmps no legado): Buttons(1) marca
2079:     * Imps = 1 em todas as Empresas, Buttons(2) desmarca (Imps = 0).
2080:     * O legado escreve "Set Imps = (This.Value = 1)" porque la a coluna eh
2081:     * bit/logica; aqui Imps eh NUMERICA (CheckBox.Value eh numerico), por
2082:     * isso o IIF explicito - atribuir o Logico direto estoura type mismatch.
2083:     *==========================================================================
2084:     PROCEDURE CmdEmpsClick()
2085:         LOCAL loc_oPag
2086:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2087:         IF USED("cursor_4c_Empresas")
2088:             UPDATE cursor_4c_Empresas SET Imps = IIF(loc_oPag.cmg_4c_Empresas.Value = 1, 1, 0)

*-- Linhas 2099 a 2107:
2099:         LOCAL loc_oPag
2100:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2101:         IF USED("cursor_4c_Empresas")
2102:             *-- Imps eh NUMERICA (CheckBox.Value eh numerico): 1/0, nao .T./.F.
2103:             IF loc_oPag.chk_4c_Ck_MarcaEmp.Value = 1
2104:                 REPLACE ALL Imps WITH 1 IN cursor_4c_Empresas
2105:             ELSE
2106:                 REPLACE ALL Imps WITH 0 IN cursor_4c_Empresas
2107:             ENDIF

*-- Linhas 2129 a 2149:
2129:     * Valida periodo/moeda/Tipo de Operacao marcado/Grande Grupo marcado
2130:     * (mesmas guardas do btnConsultar.Click legado) e dispara a consulta
2131:     * (Processamento() do legado -> THIS.this_oBusinessObject.Processar()).
2132:     *
2133:     * Apos o sucesso, reproduz o fim de Processamento(): optValor1.Value=3
2134:     * ("Sem Filtro"), THIS.Filtros(1,3) (ordem/refresh de grd_4c_Dados1),
2135:     * ActivePage=2 (Pagina de Dados), pgf_4c_Resultados.ActivePage=1
2136:     * (Detalhamento) e a atualizacao do painel lateral (equivalente ao
2137:     * grdDados1.AfterRowColChange() chamado a mao no fim do legado).
2138:     *==========================================================================
2139:     PROCEDURE BtnConsultarClick()
2140:         LOCAL loc_oPag, loc_dIni, loc_dFim, loc_lSucesso
2141: 
2142:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2143: 
2144:         loc_dIni = THIS.this_oBusinessObject.this_dDataIni
2145:         loc_dFim = THIS.this_oBusinessObject.this_dDataFim
2146: 
2147:         IF EMPTY(loc_dIni)
2148:             MsgAviso("A Data Inicial N" + CHR(227) + "o " + CHR(233) + " V" + CHR(225) + "lida!!!", "Dados Inv" + CHR(225) + "lidos!!!")
2149:             RETURN .F.

*-- Linhas 2202 a 2222:
2202:         RETURN loc_lSucesso
2203:     ENDPROC
2204: 
2205:     *==========================================================================
2206:     * BtnSairClick - Buttons(2) "Sair" (btnSair no legado, Cancel=.T. ->
2207:     * ESC). Persiste a configuracao de colunas de grd_4c_Dados1
2208:     * (AcertaColunas('GRAVAR')) antes de fechar, igual ao legado.
2209:     *==========================================================================
2210:     PROCEDURE BtnSairClick()
2211:         THIS.AcertaColunas("GRAVAR")
2212:         THIS.Release()
2213:     ENDPROC
2214: 
2215:     *==========================================================================
2216:     * ConfigurarPaginaDados - Page2 (pgDados no legado). PageFrame interno
2217:     * pgResults -> pgf_4c_Resultados (3 paginas: Detalhamento/Totais por
2218:     * Empresa/Totais por Vendedora) + os botoes de navegacao/exportacao
2219:     * (cmgRetornar/btnExportar/btnExcel), que no legado ficam direto em
2220:     * pgDados, FORA do PageFrame interno (por isso aparecem nas 3 abas).
2221:     *==========================================================================
2222:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 2230 a 2239:
2230:         *-- pgResults: Top=2 Left=-1 Width=1304 Height=600 PageCount=3
2231:         loc_oPag.AddObject("pgf_4c_Resultados", "PageFrame")
2232:         WITH loc_oPag.pgf_4c_Resultados
2233:             .Top       = 2
2234:             .Left      = -1
2235:             .Width     = 1304
2236:             .Height    = 600
2237:             .PageCount = 3
2238:             .Visible   = .T.
2239:         ENDWITH

*-- Linhas 2246 a 2312:
2246:         *-- (Filtros)
2247:         loc_oPag.AddObject("cmg_4c_Retornar", "CommandGroup")
2248:         WITH loc_oPag.cmg_4c_Retornar
2249:             .Top         = 62
2250:             .Left        = 1193
2251:             .Width       = 80
2252:             .Height      = 80
2253:             .ButtonCount = 1
2254:             .BackStyle   = 0
2255:             .BorderStyle = 0
2256:             .SpecialEffect = 1
2257:             WITH .Buttons(1)
2258:                 .Top         = 0
2259:                 .Left        = 0
2260:                 .Width       = 75
2261:                 .Height      = 75
2262:                 .FontBold    = .T.
2263:                 .FontItalic  = .T.
2264:                 .FontName    = "Comic Sans MS"
2265:                 .FontSize    = 8
2266:                 .Cancel      = .T.
2267:                 .Caption     = "Retornar"
2268:                 .ToolTipText = "Retornar aos Filtros"
2269:                 .ForeColor   = RGB(90, 90, 90)
2270:                 .BackColor   = RGB(255, 255, 255)
2271:                 .Themes      = .F.
2272:                 .Picture     = gc_4c_CaminhoIcones + "geral_seta_esq_60.jpg"
2273:             ENDWITH
2274:             .Visible = .T.
2275:         ENDWITH
2276: 
2277:         *-- btnExportar / btnExcel (fwbtng no legado): exportam o resultado
2278:         *-- da ABA CORRENTE de pgf_4c_Resultados para TXT/XLS
2279:         loc_oPag.AddObject("cmd_4c_Exportar", "CommandButton")
2280:         WITH loc_oPag.cmd_4c_Exportar
2281:             .Top         = 62
2282:             .Left        = 1116
2283:             .Width       = 75
2284:             .Height      = 75
2285:             .FontBold    = .T.
2286:             .FontItalic  = .T.
2287:             .FontName    = "Comic Sans MS"
2288:             .FontSize    = 8
2289:             .Caption     = "Exporta TXT"
2290:             .ToolTipText = "Gerar TXT Tabulado Para Importa" + CHR(231) + CHR(227) + "o em Excel"
2291:             .ForeColor   = RGB(90, 90, 90)
2292:             .BackColor   = RGB(255, 255, 255)
2293:             .Themes      = .F.
2294:             .Visible     = .T.
2295:         ENDWITH
2296: 
2297:         loc_oPag.AddObject("cmd_4c_Excel", "CommandButton")
2298:         WITH loc_oPag.cmd_4c_Excel
2299:             .Top         = 62
2300:             .Left        = 1040
2301:             .Width       = 75
2302:             .Height      = 75
2303:             .FontBold    = .T.
2304:             .FontItalic  = .T.
2305:             .FontName    = "Comic Sans MS"
2306:             .FontSize    = 8
2307:             .Caption     = "Exporta XLS"
2308:             .ToolTipText = "Gerar Planilha XLS"
2309:             .ForeColor   = RGB(90, 90, 90)
2310:             .BackColor   = RGB(255, 255, 255)
2311:             .Themes      = .F.
2312:             .Visible     = .T.

*-- Linhas 2319 a 2347:
2319:         *-- is not found" dentro do InicializarForm e a tela nao abre.
2320:     ENDPROC
2321: 
2322:     *==========================================================================
2323:     * ConfigurarAbaDetalhamento - pgRes01 (Detalhamento dos Produtos):
2324:     * grd_4c_Dados1 (35 colunas, ControlSource/Width/Alignment EXATOS do
2325:     * dump - SECAO 2, nao do runtime GradePadrao(), que esta desatualizado
2326:     * em relacao ao SCX - ver GradePadrao() mais abaixo) + o painel lateral
2327:     * (imagem, observacao, preco atual, desconto/acrescimo, busca por
2328:     * codigo, filtro positivas/negativas/sem-filtro) + os botoes de acao
2329:     * (Restaurar Grade, Cadastro do Produto, Movimento, Subniveis, Conta,
2330:     * Visualizar, Imprimir).
2331:     *
2332:     * Cursor_4c_Detalhe (crPgRes01) JA EXISTE neste ponto - criado pelo
2333:     * Init() do BO (CriarCursoresResultado), chamado ANTES de
2334:     * ConfigurarPageFrame em InicializarForm. Por isso o bind
2335:     * (RecordSource/ControlSource) pode ser feito aqui, direto, sem o funil
2336:     * deferido que as grades de filtro da Pagina 1 precisam (regra #41) -
2337:     * BtnConsultarClick so faz ZAP+INSERT no MESMO cursor (nunca fecha/
2338:     * reabre o alias), entao o RecordSource nunca se perde.
2339:     *==========================================================================
2340:     PROTECTED PROCEDURE ConfigurarAbaDetalhamento(par_oPag)
2341:         LOCAL loc_nCol
2342:         DIMENSION loc_aLargura(35)
2343:         DIMENSION loc_aCaption(35)
2344: 
2345:         loc_aCaption( 1) = "Emp"
2346:         loc_aLargura( 1) =  31
2347:         loc_aCaption( 2) = "Movimenta" + CHR(231) + CHR(227) + "o"

*-- Linhas 2415 a 2894:
2415: 
2416:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
2417:             par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
2418:         ENDIF
2419: 
2420:         par_oPag.AddObject("grd_4c_Dados1", "Grid")
2421:         WITH par_oPag.grd_4c_Dados1
2422:             .Top               = 320
2423:             .Left              = 4
2424:             .Width             = 1292
2425:             .Height            = 251
2426:             .ColumnCount       = 35
2427:             .FontName          = "Tahoma"
2428:             .FontSize          = 7
2429:             .AllowHeaderSizing = .F.
2430:             .AllowRowSizing    = .F.
2431:             .DeleteMark        = .F.
2432:             .RecordMark        = .F.
2433:             .HeaderHeight      = 21
2434:             .RowHeight         = 15
2435:             .ScrollBars        = 3
2436:             .GridLineColor     = RGB(238, 238, 238)
2437:             *-- RecordSource ANTES do ControlSource (regra #41) - o cursor
2438:             *-- ja existe (CriarCursoresResultado roda no Init do BO).
2439:             .RecordSource      = "cursor_4c_Detalhe"
2440:             .Column1.ControlSource  = "cursor_4c_Detalhe.Empresa"
2441:             .Column2.ControlSource  = "cursor_4c_Detalhe.Movimentacao"
2442:             .Column3.ControlSource  = "cursor_4c_Detalhe.Numero"
2443:             .Column4.ControlSource  = "IIF(EMPTY(cursor_4c_Detalhe.Data_Venda), SPACE(10), DTOC(cursor_4c_Detalhe.Data_Venda))"
2444:             .Column5.ControlSource  = "cursor_4c_Detalhe.Codigo_Vendedora"
2445:             .Column6.ControlSource  = "cursor_4c_Detalhe.Barras"
2446:             .Column7.ControlSource  = "cursor_4c_Detalhe.Codigo_Item"
2447:             .Column8.ControlSource  = "cursor_4c_Detalhe.Desc_Item"
2448:             .Column9.ControlSource  = "cursor_4c_Detalhe.Cor"
2449:             .Column10.ControlSource = "cursor_4c_Detalhe.Tamanho"
2450:             .Column11.ControlSource = "cursor_4c_Detalhe.Valor_Diferenca"
2451:             .Column12.ControlSource = "ALLTRIM(cursor_4c_Detalhe.Pct_Dif_Chr)"
2452:             .Column13.ControlSource = "cursor_4c_Detalhe.Venda_Cadastro"
2453:             .Column14.ControlSource = "cursor_4c_Detalhe.Val_Unitario"
2454:             .Column15.ControlSource = "cursor_4c_Detalhe.Quantidade"
2455:             .Column16.ControlSource = "cursor_4c_Detalhe.Total"
2456:             .Column17.ControlSource = "cursor_4c_Detalhe.Custo_Cadastro"
2457:             .Column18.ControlSource = "cursor_4c_Detalhe.Cod_Fornecedor"
2458:             .Column19.ControlSource = "cursor_4c_Detalhe.Nome_Fornecedor"
2459:             .Column20.ControlSource = "cursor_4c_Detalhe.Ref_Fornecedor"
2460:             .Column21.ControlSource = "cursor_4c_Detalhe.Gde_Grupo"
2461:             .Column22.ControlSource = "cursor_4c_Detalhe.Grupo"
2462:             .Column23.ControlSource = "cursor_4c_Detalhe.SubGrupo"
2463:             .Column24.ControlSource = "cursor_4c_Detalhe.Operacao"
2464:             .Column25.ControlSource = "cursor_4c_Detalhe.Cod_Cliente"
2465:             .Column26.ControlSource = "cursor_4c_Detalhe.Nome_Cliente"
2466:             .Column27.ControlSource = "cursor_4c_Detalhe.Parcelas"
2467:             .Column28.ControlSource = "cursor_4c_Detalhe.Cond_Pagto"
2468:             .Column29.ControlSource = "cursor_4c_Detalhe.Markup"
2469:             .Column30.ControlSource = "cursor_4c_Detalhe.Total_Geral"
2470:             .Column31.ControlSource = "cursor_4c_Detalhe.Local_Itn"
2471:             .Column32.ControlSource = "cursor_4c_Detalhe.Equivalente"
2472:             .Column33.ControlSource = "cursor_4c_Detalhe.Categoria"
2473:             .Column34.ControlSource = "cursor_4c_Detalhe.Nome_Vendedora"
2474:             .Column35.ControlSource = "cursor_4c_Detalhe.Desc_Categoria"
2475: 
2476:             .Column4.Alignment  = 2
2477:             .Column12.Alignment = 1
2478:             .Column24.Alignment = 2
2479:             .Column27.Alignment = 1
2480: 
2481:             *-- Codigo_Item (7) e Equivalente (32): estilo "link" do legado
2482:             *-- (FontBold+Underline+azul). O clique e de verdade: o DblClick
2483:             *-- do Text1 das duas colunas abre a Pesquisa Global de Produtos
2484:             *-- filtrada pelo codigo da celula (ver
2485:             *-- ConfigurarBindEventsResultados / AbrirPesquisaGlobalProduto),
2486:             *-- igual ao legado.
2487:             .Column7.FontBold       = .T.
2488:             .Column7.FontUnderline  = .T.
2489:             .Column7.ForeColor      = RGB(0, 0, 255)
2490:             .Column32.FontBold      = .T.
2491:             .Column32.FontUnderline = .T.
2492:             .Column32.ForeColor     = RGB(0, 0, 255)
2493: 
2494:             FOR loc_nCol = 1 TO 35
2495:                 THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados1, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), ;
2496:                     INLIST(loc_nCol, 11, 13, 14, 15, 16, 17, 29, 30))
2497:             ENDFOR
2498: 
2499:             *-- Linhas de TOTAL (Ordem <> 'A') em amarelo+negrito; Valor da
2500:             *-- Diferenca/% Dif. (11/12) ficam SEMPRE amarelos, mesmo nas
2501:             *-- linhas normais
2502:             .SetAll("DynamicBackColor", "IIF(cursor_4c_Detalhe.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
2503:             .SetAll("DynamicFontBold",  "cursor_4c_Detalhe.Ordem <> 'A'", "Column")
2504:             .Column11.DynamicBackColor = "RGB(255,255,240)"
2505:             .Column12.DynamicBackColor = "RGB(255,255,240)"
2506: 
2507:             .Visible = .T.
2508:         ENDWITH
2509: 
2510:         *-- Restaura largura/visibilidade salvas em txt_4c_CfgGrade (se
2511:         *-- houver) - equivalente a ThisForm.AcertaColunas([LER]) no fim de
2512:         *-- montagrades() legado
2513:         THIS.AcertaColunas("LER")
2514: 
2515:         *-- getObsItn (observacao do item - EditBox memo, so exibicao)
2516:         par_oPag.AddObject("obj_4c_ObsItem", "EditBox")
2517:         WITH par_oPag.obj_4c_ObsItem
2518:             .Top       = 20
2519:             .Left      = 5
2520:             .Width     = 312
2521:             .Height    = 172
2522:             .ReadOnly  = .T.
2523:             .FontName  = "Tahoma"
2524:             .FontSize  = 8
2525:             .Value     = ""
2526:             .Visible   = .T.
2527:         ENDWITH
2528: 
2529:         *-- Say3 "Observacao do Item"
2530:         par_oPag.AddObject("lbl_4c_ObsItem", "Label")
2531:         WITH par_oPag.lbl_4c_ObsItem
2532:             .Top       = 4
2533:             .Left      = 6
2534:             .Width     = 100
2535:             .Height    = 15
2536:             .AutoSize  = .F.
2537:             .BackStyle = 0
2538:             .Alignment = 0
2539:             .ForeColor = RGB(90, 90, 90)
2540:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do " + CHR(205) + "tem"
2541:             .Visible   = .T.
2542:         ENDWITH
2543: 
2544:         *-- Say1 "Preco Atual do Item" + getVdaCadastro (so exibicao)
2545:         par_oPag.AddObject("lbl_4c_PrecoAtual", "Label")
2546:         WITH par_oPag.lbl_4c_PrecoAtual
2547:             .Top       = 200
2548:             .Left      = 5
2549:             .Width     = 97
2550:             .Height    = 15
2551:             .AutoSize  = .F.
2552:             .BackStyle = 0
2553:             .Alignment = 0
2554:             .ForeColor = RGB(90, 90, 90)
2555:             .Caption   = "Pre" + CHR(231) + "o Atual do Item"
2556:             .Visible   = .T.
2557:         ENDWITH
2558: 
2559:         par_oPag.AddObject("txt_4c_VdaCadastro", "TextBox")
2560:         WITH par_oPag.txt_4c_VdaCadastro
2561:             .Top       = 216
2562:             .Left      = 5
2563:             .Width     = 128
2564:             .Height    = 23
2565:             .ReadOnly  = .T.
2566:             .Value     = 0
2567:             .Visible   = .T.
2568:         ENDWITH
2569: 
2570:         *-- Say4 "Desconto/Acrescimo" + getDesc_Acres (so exibicao)
2571:         par_oPag.AddObject("lbl_4c_DescAcres", "Label")
2572:         WITH par_oPag.lbl_4c_DescAcres
2573:             .Top       = 245
2574:             .Left      = 5
2575:             .Width     = 99
2576:             .Height    = 15
2577:             .AutoSize  = .F.
2578:             .BackStyle = 0
2579:             .Alignment = 0
2580:             .ForeColor = RGB(90, 90, 90)
2581:             .Caption   = "Desconto/Acr" + CHR(233) + "scimo"
2582:             .Visible   = .T.
2583:         ENDWITH
2584: 
2585:         par_oPag.AddObject("txt_4c_DescAcres", "TextBox")
2586:         WITH par_oPag.txt_4c_DescAcres
2587:             .Top       = 261
2588:             .Left      = 5
2589:             .Width     = 128
2590:             .Height    = 23
2591:             .ReadOnly  = .T.
2592:             .Value     = 0
2593:             .Visible   = .T.
2594:         ENDWITH
2595: 
2596:         *-- Say2 "Buscar Codigo" + getBusca (busca Numero da venda na grade)
2597:         par_oPag.AddObject("lbl_4c_Busca", "Label")
2598:         WITH par_oPag.lbl_4c_Busca
2599:             .Top       = 245
2600:             .Left      = 164
2601:             .Width     = 70
2602:             .Height    = 15
2603:             .AutoSize  = .F.
2604:             .BackStyle = 0
2605:             .Alignment = 0
2606:             .ForeColor = RGB(90, 90, 90)
2607:             .Caption   = "Buscar C" + CHR(243) + "digo"
2608:             .Visible   = .T.
2609:         ENDWITH
2610: 
2611:         par_oPag.AddObject("txt_4c_Busca", "TextBox")
2612:         WITH par_oPag.txt_4c_Busca
2613:             .Top       = 261
2614:             .Left      = 164
2615:             .Width     = 82
2616:             .Height    = 23
2617:             .Value     = ""
2618:             .Visible   = .T.
2619:         ENDWITH
2620: 
2621:         *-- lblDespDRE "Diferencas :" + optValor1 (Positivas/Negativas/Sem Filtro)
2622:         par_oPag.AddObject("lbl_4c_Diferencas", "Label")
2623:         WITH par_oPag.lbl_4c_Diferencas
2624:             .Top       = 297
2625:             .Left      = 17
2626:             .Width     = 60
2627:             .Height    = 15
2628:             .AutoSize  = .F.
2629:             .BackStyle = 0
2630:             .Alignment = 0
2631:             .ForeColor = RGB(90, 90, 90)
2632:             .Caption   = "Diferen" + CHR(231) + "as :"
2633:             .Visible   = .T.
2634:         ENDWITH
2635: 
2636:         par_oPag.AddObject("obj_4c_OptValor1", "OptionGroup")
2637:         WITH par_oPag.obj_4c_OptValor1
2638:             .Top         = 292
2639:             .Left        = 76
2640:             .Width        = 226
2641:             .Height      = 25
2642:             .ButtonCount = 3
2643:             .Value       = 3
2644:             WITH .Buttons(1)
2645:                 .Top       = 5
2646:                 .Left      = 5
2647:                 .Width     = 65
2648:                 .Height    = 15
2649:                 .FontName  = "Tahoma"
2650:                 .FontSize  = 8
2651:                 .BackStyle = 0
2652:                 .Caption   = "Positivas"
2653:                 .ForeColor = RGB(90, 90, 90)
2654:             ENDWITH
2655:             WITH .Buttons(2)
2656:                 .Top       = 5
2657:                 .Left      = 77
2658:                 .Width     = 65
2659:                 .Height    = 15
2660:                 .FontName  = "Tahoma"
2661:                 .FontSize  = 8
2662:                 .BackStyle = 0
2663:                 .Caption   = "Negativas"
2664:                 .ForeColor = RGB(90, 90, 90)
2665:             ENDWITH
2666:             WITH .Buttons(3)
2667:                 .Top       = 5
2668:                 .Left      = 156
2669:                 .Width     = 65
2670:                 .Height    = 15
2671:                 .FontName  = "Tahoma"
2672:                 .FontSize  = 8
2673:                 .BackStyle = 0
2674:                 .Caption   = "Sem Filtro"
2675:                 .ForeColor = RGB(90, 90, 90)
2676:             ENDWITH
2677:             .Visible = .T.
2678:         ENDWITH
2679: 
2680:         *-- ImgFigJpg - imagem do produto da linha corrente (DblClick = zoom)
2681:         par_oPag.AddObject("img_4c_Figura", "Image")
2682:         WITH par_oPag.img_4c_Figura
2683:             .Top         = 2
2684:             .Left        = 327
2685:             .Width       = 621
2686:             .Height      = 318
2687:             .Stretch     = 1
2688:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
2689:             .Visible     = .F.
2690:         ENDWITH
2691: 
2692:         *-- btnRestaurar - restaura largura/visibilidade padrao da grade
2693:         par_oPag.AddObject("cmd_4c_Restaurar", "CommandButton")
2694:         WITH par_oPag.cmd_4c_Restaurar
2695:             .Top         = 113
2696:             .Left        = 1040
2697:             .Width       = 75
2698:             .Height      = 75
2699:             .FontBold    = .T.
2700:             .FontItalic  = .T.
2701:             .FontName    = "Comic Sans MS"
2702:             .FontSize    = 8
2703:             .WordWrap    = .T.
2704:             .Caption     = "Restaurar Grade"
2705:             .ToolTipText = "Restaura as Colunas da Grade Para o Padr" + CHR(227) + "o Original"
2706:             .ForeColor   = RGB(90, 90, 90)
2707:             .BackColor   = RGB(255, 255, 255)
2708:             .Themes      = .F.
2709:             .Picture     = gc_4c_CaminhoIcones + "geral_pn_btn_60.jpg"
2710:             .Visible     = .T.
2711:         ENDWITH
2712: 
2713:         *-- btnProduto - abre o cadastro do produto
2714:         par_oPag.AddObject("cmd_4c_Produto", "CommandButton")
2715:         WITH par_oPag.cmd_4c_Produto
2716:             .Top         = 113
2717:             .Left        = 1116
2718:             .Width       = 75
2719:             .Height      = 75
2720:             .FontBold    = .T.
2721:             .FontItalic  = .T.
2722:             .FontName    = "Comic Sans MS"
2723:             .FontSize    = 8
2724:             .Caption     = "Cadastro"
2725:             .ToolTipText = "Cadastro do Produto"
2726:             .ForeColor   = RGB(90, 90, 90)
2727:             .BackColor   = RGB(255, 255, 255)
2728:             .Themes      = .F.
2729:             .Picture     = gc_4c_CaminhoIcones + "geral_palete_60.jpg"
2730:             .Visible     = .T.
2731:         ENDWITH
2732: 
2733:         *-- cmdOperacao/btnOperacao - abre a tela de movimentacao da venda
2734:         par_oPag.AddObject("cmg_4c_Operacao", "CommandGroup")
2735:         WITH par_oPag.cmg_4c_Operacao
2736:             .Top         = 113
2737:             .Left        = 1193
2738:             .Width       = 80
2739:             .Height      = 100
2740:             .ButtonCount = 1
2741:             .BackStyle   = 0
2742:             .BorderStyle = 0
2743:             .Themes      = .F.
2744:             WITH .Buttons(1)
2745:                 .Top         = 0
2746:                 .Left        = 0
2747:                 .Width       = 75
2748:                 .Height      = 75
2749:                 .FontBold    = .T.
2750:                 .FontItalic  = .T.
2751:                 .FontName    = "Comic Sans MS"
2752:                 .FontSize    = 8
2753:                 .Caption     = "Movimento"
2754:                 .ToolTipText = "Movimenta" + CHR(231) + CHR(227) + "o"
2755:                 .ForeColor   = RGB(90, 90, 90)
2756:                 .BackColor   = RGB(255, 255, 255)
2757:                 .Themes      = .F.
2758:                 .Picture     = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
2759:             ENDWITH
2760:             .Visible = .T.
2761:         ENDWITH
2762: 
2763:         *-- SubNiveis - abre a tela de subniveis da venda
2764:         par_oPag.AddObject("cmd_4c_SubNiveis", "CommandButton")
2765:         WITH par_oPag.cmd_4c_SubNiveis
2766:             .Top         = 190
2767:             .Left        = 1192
2768:             .Width       = 75
2769:             .Height      = 75
2770:             .FontBold    = .T.
2771:             .FontItalic  = .T.
2772:             .FontName    = "Comic Sans MS"
2773:             .FontSize    = 8
2774:             .WordWrap    = .T.
2775:             .Caption     = "\<Subn" + CHR(237) + "veis"
2776:             .ToolTipText = "Subn" + CHR(237) + "veis"
2777:             .PicturePosition = 13
2778:             .ForeColor   = RGB(90, 90, 90)
2779:             .BackColor   = RGB(255, 255, 255)
2780:             .Themes      = .F.
2781:             .Picture     = gc_4c_CaminhoIcones + "geral_subnivel_60.jpg"
2782:             .Visible     = .T.
2783:         ENDWITH
2784: 
2785:         *-- CmdConta - abre o cadastro da conta/cliente
2786:         par_oPag.AddObject("cmd_4c_Conta", "CommandButton")
2787:         WITH par_oPag.cmd_4c_Conta
2788:             .Top         = 190
2789:             .Left        = 1116
2790:             .Width       = 75
2791:             .Height      = 75
2792:             .FontBold    = .T.
2793:             .FontItalic  = .T.
2794:             .FontName    = "Comic Sans MS"
2795:             .FontSize    = 8
2796:             .Caption     = "Conta"
2797:             .ToolTipText = "Cadastro do Produto"
2798:             .ForeColor   = RGB(90, 90, 90)
2799:             .BackColor   = RGB(255, 255, 255)
2800:             .Themes      = .F.
2801:             .Picture     = gc_4c_CaminhoIcones + "geral_contatos_60.jpg"
2802:             .Visible     = .T.
2803:         ENDWITH
2804: 
2805:         *-- btnVisualizar / BtnImprimir - preview/impressao do relatorio de
2806:         *-- embalagem (SigOpPck). O form legado monta a consulta a partir do
2807:         *-- cursor_4c_Detalhe JA filtrado em tela; o form novo FormSigOpPck
2808:         *-- (ja migrado, OPERACIONAL) tem filtros proprios independentes -
2809:         *-- nao ha API publica para injetar o recorte atual nele. Por isso
2810:         *-- estes botoes abrem o FormSigOpPck para o usuario refazer o
2811:         *-- filtro la, em vez de reproduzir o INDEX ON/REPORT FORM direto
2812:         *-- sobre cursor_4c_Detalhe (seria preciso duplicar o FRX e a
2813:         *-- logica de filtro, que ja pertencem aquele form).
2814:         par_oPag.AddObject("cmd_4c_Visualizar", "CommandButton")
2815:         WITH par_oPag.cmd_4c_Visualizar
2816:             .Top         = 190
2817:             .Left        = 1040
2818:             .Width       = 75
2819:             .Height      = 75
2820:             .FontBold    = .T.
2821:             .FontItalic  = .T.
2822:             .FontName    = "Comic Sans MS"
2823:             .FontSize    = 8
2824:             .Caption     = "Visualizar"
2825:             .ToolTipText = "Visualizar Etiquetas de Embalagem"
2826:             .PicturePosition = 13
2827:             .ForeColor   = RGB(90, 90, 90)
2828:             .BackColor   = RGB(255, 255, 255)
2829:             .Themes      = .F.
2830:             .Picture     = gc_4c_CaminhoIcones + "geral_video_60.jpg"
2831:             .Visible     = .T.
2832:         ENDWITH
2833: 
2834:         par_oPag.AddObject("cmd_4c_Imprimir", "CommandButton")
2835:         WITH par_oPag.cmd_4c_Imprimir
2836:             .Top         = 190
2837:             .Left        = 964
2838:             .Width       = 75
2839:             .Height      = 75
2840:             .FontBold    = .T.
2841:             .FontItalic  = .T.
2842:             .FontName    = "Comic Sans MS"
2843:             .FontSize    = 8
2844:             .Caption     = "Imprimir"
2845:             .ToolTipText = "Imprimir Etiquetas de Embalagem"
2846:             .PicturePosition = 13
2847:             .ForeColor   = RGB(90, 90, 90)
2848:             .BackColor   = RGB(255, 255, 255)
2849:             .Themes      = .F.
2850:             .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
2851:             .Visible     = .T.
2852:         ENDWITH
2853:     ENDPROC
2854: 
2855:     *==========================================================================
2856:     * ConfigurarColunaResultado - Aplica no indice loc_nCol da grade de
2857:     * resultado a largura/caption padrao + a mascara numerica (999,999,999.99)
2858:     * nas colunas que o legado marca como numericas. Compartilhado por
2859:     * grd_4c_Dados1/2/3 (par_oGrid identifica a grade).
2860:     *==========================================================================
2861:     PROTECTED PROCEDURE ConfigurarColunaResultado(par_oGrid, par_nIndice, par_cCaption, par_nLargura, par_lNumerica)
2862:         LOCAL loc_cCol, loc_oColuna
2863:         loc_cCol    = TRANSFORM(par_nIndice)
2864:         loc_oColuna = EVALUATE("par_oGrid.Column" + loc_cCol)
2865: 
2866:         loc_oColuna.ReadOnly          = .T.
2867:         loc_oColuna.Width             = par_nLargura
2868:         loc_oColuna.Header1.Caption   = par_cCaption
2869:         loc_oColuna.Header1.FontBold  = .T.
2870:         loc_oColuna.Header1.Alignment = 2
2871:         loc_oColuna.Header1.ForeColor = RGB(90, 90, 90)
2872: 
2873:         IF PCOUNT() >= 5 AND par_lNumerica
2874:             loc_oColuna.InputMask = "999,999,999.99"
2875:         ENDIF
2876:     ENDPROC
2877: 
2878:     *==========================================================================
2879:     * ConfigurarAbaTotalEmpresa - pgRes02 (Totais por Empresa): grd_4c_Dados2
2880:     * (10 colunas, cursor_4c_TotalEmpresa). O legado NAO define Width por
2881:     * coluna aqui (soh ControlSource/ReadOnly/InputMask em montagrades) -
2882:     * os valores abaixo vem do design-time do SCX (SECAO 2).
2883:     *==========================================================================
2884:     PROTECTED PROCEDURE ConfigurarAbaTotalEmpresa(par_oPag)
2885:         LOCAL loc_nCol
2886:         DIMENSION loc_aLargura(10)
2887:         DIMENSION loc_aCaption(10)
2888: 
2889:         loc_aCaption( 1) = "Emp"
2890:         loc_aLargura( 1) =  31
2891:         loc_aCaption( 2) = "Descritivo"
2892:         loc_aLargura( 2) = 150
2893:         loc_aCaption( 3) = "Valor da Diferen" + CHR(231) + "a"
2894:         loc_aLargura( 3) = 100

*-- Linhas 2909 a 2930:
2909: 
2910:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
2911:             par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
2912:         ENDIF
2913: 
2914:         par_oPag.AddObject("grd_4c_Dados2", "Grid")
2915:         WITH par_oPag.grd_4c_Dados2
2916:             .Top               = 137
2917:             .Left              = 4
2918:             .Width             = 1292
2919:             .Height            = 431
2920:             .ColumnCount       = 10
2921:             .FontName          = "Tahoma"
2922:             .FontSize          = 7
2923:             .AllowHeaderSizing = .F.
2924:             .AllowRowSizing    = .F.
2925:             .DeleteMark        = .F.
2926:             .RecordMark        = .F.
2927:             .HeaderHeight      = 21
2928:             .RowHeight         = 15
2929:             .ScrollBars        = 3
2930:             .GridLineColor     = RGB(238, 238, 238)

*-- Linhas 2939 a 2973:
2939:             .Column8.ControlSource  = "cursor_4c_TotalEmpresa.Custo_Cadastro"
2940:             .Column9.ControlSource  = "cursor_4c_TotalEmpresa.Tkt_Medio"
2941:             .Column10.ControlSource = "cursor_4c_TotalEmpresa.Markup"
2942: 
2943:             FOR loc_nCol = 1 TO 10
2944:                 THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados2, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
2945:             ENDFOR
2946: 
2947:             .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalEmpresa.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
2948:             .SetAll("DynamicFontBold",  "cursor_4c_TotalEmpresa.Ordem <> 'A'", "Column")
2949:             .Column3.DynamicBackColor = "RGB(255,255,240)"
2950:             .Column4.DynamicBackColor = "RGB(255,255,240)"
2951: 
2952:             .Visible = .T.
2953:         ENDWITH
2954:     ENDPROC
2955: 
2956:     *==========================================================================
2957:     * ConfigurarAbaTotalVendedora - pgRes03 (Totais por Vendedora):
2958:     * grd_4c_Dados3 (10 colunas, cursor_4c_TotalVendedora)
2959:     *==========================================================================
2960:     PROTECTED PROCEDURE ConfigurarAbaTotalVendedora(par_oPag)
2961:         LOCAL loc_nCol
2962:         DIMENSION loc_aLargura(10)
2963:         DIMENSION loc_aCaption(10)
2964: 
2965:         loc_aCaption( 1) = "Emp"
2966:         loc_aLargura( 1) =  31
2967:         loc_aCaption( 2) = "Vendedora"
2968:         loc_aLargura( 2) = 100
2969:         loc_aCaption( 3) = "Valor da Diferen" + CHR(231) + "a"
2970:         loc_aLargura( 3) = 100
2971:         loc_aCaption( 4) = "% Dif."
2972:         loc_aLargura( 4) =  45
2973:         loc_aCaption( 5) = "Valor do Cadastro"

*-- Linhas 2985 a 3006:
2985: 
2986:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
2987:             par_oPag.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
2988:         ENDIF
2989: 
2990:         par_oPag.AddObject("grd_4c_Dados3", "Grid")
2991:         WITH par_oPag.grd_4c_Dados3
2992:             .Top               = 137
2993:             .Left              = 4
2994:             .Width             = 1292
2995:             .Height            = 431
2996:             .ColumnCount       = 10
2997:             .FontName          = "Tahoma"
2998:             .FontSize          = 7
2999:             .AllowHeaderSizing = .F.
3000:             .AllowRowSizing    = .F.
3001:             .DeleteMark        = .F.
3002:             .RecordMark        = .F.
3003:             .HeaderHeight      = 21
3004:             .RowHeight         = 15
3005:             .ScrollBars        = 3
3006:             .GridLineColor     = RGB(238, 238, 238)

*-- Linhas 3015 a 3106:
3015:             .Column8.ControlSource  = "cursor_4c_TotalVendedora.Custo_Cadastro"
3016:             .Column9.ControlSource  = "cursor_4c_TotalVendedora.Tkt_Medio"
3017:             .Column10.ControlSource = "cursor_4c_TotalVendedora.Markup"
3018: 
3019:             FOR loc_nCol = 1 TO 10
3020:                 THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados3, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
3021:             ENDFOR
3022: 
3023:             .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalVendedora.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
3024:             .SetAll("DynamicFontBold",  "cursor_4c_TotalVendedora.Ordem <> 'A'", "Column")
3025:             .Column3.DynamicBackColor = "RGB(255,255,240)"
3026:             .Column4.DynamicBackColor = "RGB(255,255,240)"
3027: 
3028:             .Visible = .T.
3029:         ENDWITH
3030:     ENDPROC
3031: 
3032:     *==========================================================================
3033:     * ConfigurarBindEventsResultados - BINDEVENTs da Pagina de Dados
3034:     * (grades de resultado + painel lateral + botoes de acao/navegacao/
3035:     * exportacao).
3036:     *==========================================================================
3037:     PROTECTED PROCEDURE ConfigurarBindEventsResultados()
3038:         LOCAL loc_oPagDados, loc_oPagRes01, loc_oPagRes02, loc_oPagRes03, loc_nCol
3039:         loc_oPagDados = THIS.pgf_4c_Paginas.Page2
3040:         loc_oPagRes01 = loc_oPagDados.pgf_4c_Resultados.Page1
3041:         loc_oPagRes02 = loc_oPagDados.pgf_4c_Resultados.Page2
3042:         loc_oPagRes03 = loc_oPagDados.pgf_4c_Resultados.Page3
3043: 
3044:         BINDEVENT(loc_oPagRes01.grd_4c_Dados1, "AfterRowColChange", THIS, "Grd1AfterRowColChange")
3045:         BINDEVENT(loc_oPagRes01.img_4c_Figura, "DblClick", THIS, "ImgFiguraDblClick")
3046: 
3047:         *-- grdDados2.AfterRowColChange / grdDados3.AfterRowColChange no
3048:         *-- legado: os dois repintam o painel lateral da pgRes01 (imagem +
3049:         *-- Observacao do Item) a partir de crPgRes01 - exatamente o que
3050:         *-- AtualizarPainelDetalheRegistro faz sobre cursor_4c_Detalhe.
3051:         BINDEVENT(loc_oPagRes02.grd_4c_Dados2, "AfterRowColChange", THIS, "Grd2AfterRowColChange")
3052:         BINDEVENT(loc_oPagRes03.grd_4c_Dados3, "AfterRowColChange", THIS, "Grd3AfterRowColChange")
3053: 
3054:         *-- grdDados1.Column<N>.Resize no legado (Columns 1 a 30 e 32 - as
3055:         *-- colunas 31, 33, 34 e 35 NAO tem o evento no SCX, e esta lista
3056:         *-- reproduz isso): arrastar a borda ate largura zero pergunta se o
3057:         *-- usuario quer OCULTAR a coluna.
3058:         FOR loc_nCol = 1 TO 32
3059:             IF loc_nCol <= 30 OR loc_nCol = 32
3060:                 BINDEVENT(EVALUATE("loc_oPagRes01.grd_4c_Dados1.Column" + TRANSFORM(loc_nCol)), ;
3061:                     "Resize", THIS, "Grd1ColunaResize")
3062:             ENDIF
3063:         ENDFOR
3064: 
3065:         *-- grdDados1.Column7.Text1.DblClick / Column32.Text1.DblClick no
3066:         *-- legado: abre a Pesquisa Global de Produtos filtrada pelo codigo
3067:         *-- da celula (Produto na 7, Equivalente na 32).
3068:         BINDEVENT(loc_oPagRes01.grd_4c_Dados1.Column7.Text1,  "DblClick", THIS, "Grd1Coluna7DblClick")
3069:         BINDEVENT(loc_oPagRes01.grd_4c_Dados1.Column32.Text1, "DblClick", THIS, "Grd1Coluna32DblClick")
3070: 
3071:         BINDEVENT(loc_oPagRes01.txt_4c_Busca, "GotFocus",  THIS, "TxtBuscaGotFocus")
3072:         BINDEVENT(loc_oPagRes01.txt_4c_Busca, "LostFocus", THIS, "TxtBuscaLostFocus")
3073: 
3074:         BINDEVENT(loc_oPagRes01.obj_4c_OptValor1, "InteractiveChange", THIS, "OptValor1InteractiveChange")
3075: 
3076:         BINDEVENT(loc_oPagRes01.cmd_4c_Restaurar,  "Click", THIS, "BtnRestaurarClick")
3077:         BINDEVENT(loc_oPagRes01.cmd_4c_Produto,    "Click", THIS, "BtnProdutoClick")
3078:         BINDEVENT(loc_oPagRes01.cmg_4c_Operacao,   "Click", THIS, "CmgOperacaoClick")
3079:         BINDEVENT(loc_oPagRes01.cmd_4c_SubNiveis,  "Click", THIS, "BtnSubNiveisClick")
3080:         BINDEVENT(loc_oPagRes01.cmd_4c_Conta,      "Click", THIS, "BtnContaClick")
3081:         BINDEVENT(loc_oPagRes01.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
3082:         BINDEVENT(loc_oPagRes01.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
3083: 
3084:         BINDEVENT(loc_oPagDados.cmg_4c_Retornar, "Click", THIS, "BtnRetornarClick")
3085:         BINDEVENT(loc_oPagDados.cmd_4c_Exportar, "Click", THIS, "BtnExportarClick")
3086:         BINDEVENT(loc_oPagDados.cmd_4c_Excel,    "Click", THIS, "BtnExcelClick")
3087:     ENDPROC
3088: 
3089:     *==========================================================================
3090:     * Grd1AfterRowColChange / AtualizarPainelDetalheRegistro - troca de
3091:     * linha/coluna em grd_4c_Dados1 (grdDados1.AfterRowColChange no legado):
3092:     * atualiza a imagem do produto + o painel lateral (Observacao,
3093:     * Desconto/Acrescimo, Preco Atual) a partir da linha corrente. Toda a
3094:     * leitura do cursor passa por BO.CarregarDoCursor (regra: CarregarDoCursor
3095:     * eh a FONTE UNICA) - os botoes de acao abaixo (Movimento/Subniveis/
3096:     * Conta/Produto) leem as properties this_cReg*/this_nReg* resultantes,
3097:     * nunca o cursor direto.
3098:     *==========================================================================
3099:     PROCEDURE Grd1AfterRowColChange(par_nColIndex)
3100:         THIS.AtualizarPainelDetalheRegistro()
3101:     ENDPROC
3102: 
3103:     *==========================================================================
3104:     * Grd2AfterRowColChange / Grd3AfterRowColChange - grdDados2 e grdDados3
3105:     * no legado tem o MESMO corpo de grdDados1.AfterRowColChange: as duas
3106:     * grades de TOTAIS repintam o painel lateral da aba de Detalhamento

*-- Linhas 3136 a 3156:
3136:     * MsgConfirma devolve LOGICO (regra #7) - nunca comparar com 6.
3137:     *==========================================================================
3138:     PROCEDURE Grd1ColunaResize()
3139:         LOCAL loc_oGrid, loc_nCol, loc_oColuna, loc_cHeader
3140: 
3141:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1
3142: 
3143:         FOR loc_nCol = 1 TO 32
3144:             IF loc_nCol <= 30 OR loc_nCol = 32
3145:                 loc_oColuna = EVALUATE("loc_oGrid.Column" + TRANSFORM(loc_nCol))
3146: 
3147:                 IF loc_oColuna.Visible AND loc_oColuna.Width = 0
3148:                     loc_cHeader = ALLTRIM(loc_oColuna.Header1.Caption)
3149:                     IF MsgConfirma("Deseja Ocultar a Coluna " + CHR(34) + loc_cHeader + CHR(34) + ;
3150:                             " da Grade?", "Ocultar Colunas")
3151:                         loc_oColuna.Visible = .F.
3152:                     ENDIF
3153:                 ENDIF
3154:             ENDIF
3155:         ENDFOR
3156:     ENDPROC

*-- Linhas 3228 a 3248:
3228:     ENDPROC
3229: 
3230:     PROCEDURE AtualizarPainelDetalheRegistro()
3231:         LOCAL loc_oPagRes01, loc_cArquivoImagem
3232: 
3233:         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Detalhe")
3234: 
3235:         loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
3236: 
3237:         loc_cArquivoImagem = THIS.this_oBusinessObject.ExtrairImagemRegistro()
3238:         IF !EMPTY(loc_cArquivoImagem)
3239:             loc_oPagRes01.img_4c_Figura.Picture = loc_cArquivoImagem
3240:             loc_oPagRes01.img_4c_Figura.Visible = .T.
3241:         ELSE
3242:             loc_oPagRes01.img_4c_Figura.Picture = ""
3243:             loc_oPagRes01.img_4c_Figura.Visible = .F.
3244:         ENDIF
3245: 
3246:         loc_oPagRes01.obj_4c_ObsItem.Value     = THIS.this_oBusinessObject.this_cRegObsItem
3247:         loc_oPagRes01.txt_4c_DescAcres.Value    = THIS.this_oBusinessObject.this_nRegDescAcres
3248:         loc_oPagRes01.txt_4c_VdaCadastro.Value  = THIS.this_oBusinessObject.this_nRegVendaCadastroR

*-- Linhas 3268 a 3360:
3268:         ENDIF
3269:     ENDPROC
3270: 
3271:     *==========================================================================
3272:     * TxtBuscaGotFocus / TxtBuscaLostFocus - getBusca no legado (busca o
3273:     * Numero da venda digitado dentro de grd_4c_Dados1). O legado usa
3274:     * GotFocus para guardar o valor anterior (This.Tag) e Valid para
3275:     * comparar e fazer o LOCATE - como Valid de TextBox nao eh confiavel no
3276:     * projeto, as duas acoes ficam no LostFocus (ao sair do campo).
3277:     *==========================================================================
3278:     PROCEDURE TxtBuscaGotFocus()
3279:         LOCAL loc_oPagRes01
3280:         loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
3281:         loc_oPagRes01.txt_4c_Busca.Tag = PADR(ALLTRIM(NVL(loc_oPagRes01.txt_4c_Busca.Value, "")), 10)
3282:     ENDPROC
3283: 
3284:     PROCEDURE TxtBuscaLostFocus()
3285:         LOCAL loc_oPagRes01, loc_cValor
3286: 
3287:         loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
3288:         loc_cValor    = ALLTRIM(NVL(loc_oPagRes01.txt_4c_Busca.Value, ""))
3289: 
3290:         IF !EMPTY(loc_cValor)
3291:             IF PADR(loc_oPagRes01.txt_4c_Busca.Tag, 10) != PADR(loc_cValor, 10) AND USED("cursor_4c_Detalhe")
3292:                 SELECT cursor_4c_Detalhe
3293:                 GO TOP
3294:                 LOCATE FOR Numero = VAL(loc_cValor)
3295:             ENDIF
3296:             loc_oPagRes01.grd_4c_Dados1.Refresh()
3297:         ENDIF
3298:     ENDPROC
3299: 
3300:     *==========================================================================
3301:     * OptValor1InteractiveChange - optValor1 (Positivas/Negativas/Sem
3302:     * Filtro) no legado chama Filtros(1, This.Value) a cada troca.
3303:     *==========================================================================
3304:     PROCEDURE OptValor1InteractiveChange()
3305:         LOCAL loc_nValor
3306:         loc_nValor = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.obj_4c_OptValor1.Value
3307:         THIS.this_oBusinessObject.this_nTipoValor = loc_nValor
3308:         THIS.Filtros(1, loc_nValor)
3309:     ENDPROC
3310: 
3311:     *==========================================================================
3312:     * Filtros - filtros(pPag,pOrd) no legado: troca a ordenacao de
3313:     * cursor_4c_Detalhe para a TAG Ordem<N> correspondente (Ordem1 =
3314:     * Positivas, Ordem2 = Negativas, Ordem3 = Sem Filtro - criadas em
3315:     * BO.CriarCursoresResultado) e repinta grd_4c_Dados1.
3316:     *==========================================================================
3317:     PROCEDURE Filtros(par_nPagina, par_nOrdem)
3318:         LOCAL loc_oPagRes01
3319: 
3320:         IF par_nPagina = 1
3321:             IF USED("cursor_4c_Detalhe")
3322:                 SELECT cursor_4c_Detalhe
3323:                 SET ORDER TO ("Ordem" + TRANSFORM(par_nOrdem))
3324:                 GO TOP
3325:             ENDIF
3326:             loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
3327:             loc_oPagRes01.grd_4c_Dados1.Refresh()
3328:         ENDIF
3329:     ENDPROC
3330: 
3331:     *==========================================================================
3332:     * BtnRestaurarClick - btnRestaurar.Click no legado: confirma, restaura
3333:     * a largura/visibilidade padrao (GradePadrao) e persiste
3334:     * (AcertaColunas('GRAVAR')).
3335:     *==========================================================================
3336:     PROCEDURE BtnRestaurarClick()
3337:         IF MsgConfirma("Deseja Restaurar as Colunas da Grade (Ocultas e Larguras)?", "Restaurar Grade")
3338:             THIS.GradePadrao()
3339:             THIS.AcertaColunas("GRAVAR")
3340:         ENDIF
3341:     ENDPROC
3342: 
3343:     *==========================================================================
3344:     * GradePadrao - gradepadrao() no legado: largura/visibilidade padrao de
3345:     * grd_4c_Dados1. O array hardcoded do legado (laGrd) so cobre as
3346:     * colunas 1 a 30 - as colunas 31 a 35 (Local/Equivalente/Categoria/
3347:     * Nome Vendedora/Desc. Categoria) foram acrescentadas ao SCX DEPOIS
3348:     * deste metodo ter sido escrito e o array NUNCA foi atualizado (regra
3349:     * #14 - SCX mais novo que o codigo que o acompanha). Para essas 5,
3350:     * mantemos a largura atual (a do design-time) em vez de reproduzir a
3351:     * leitura de um elemento do array nunca inicializado pelo legado.
3352:     *==========================================================================
3353:     PROCEDURE GradePadrao()
3354:         LOCAL loc_oGrid, loc_nCnt, loc_cCol
3355:         DIMENSION loc_aLargura(30)
3356:         loc_aLargura( 1) =  31
3357:         loc_aLargura( 2) = 150
3358:         loc_aLargura( 3) =  55
3359:         loc_aLargura( 4) =  71
3360:         loc_aLargura( 5) =  80

*-- Linhas 3382 a 3426:
3382:         loc_aLargura(27) =  50
3383:         loc_aLargura(28) = 200
3384:         loc_aLargura(29) = 100
3385:         loc_aLargura(30) = 110
3386: 
3387:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1
3388: 
3389:         FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
3390:             loc_cCol = TRANSFORM(loc_nCnt)
3391:             IF loc_nCnt <= 30
3392:                 STORE loc_aLargura(loc_nCnt) TO ("loc_oGrid.Column" + loc_cCol + ".Width")
3393:             ENDIF
3394:             STORE .T. TO ("loc_oGrid.Column" + loc_cCol + ".Visible")
3395:         ENDFOR
3396: 
3397:         loc_oGrid.Refresh()
3398:     ENDPROC
3399: 
3400:     *==========================================================================
3401:     * AcertaColunas - acertacolunas(pTip) no legado: persiste (GRAVAR) ou
3402:     * restaura (LER) a largura/visibilidade de cada coluna de
3403:     * grd_4c_Dados1 num bloco de 5 caracteres por coluna (3 = largura, 1 =
3404:     * visivel, 1 = reservado), guardado em txt_4c_CfgGrade.Value - string
3405:     * em memoria, nunca persistida em banco (igual ao legado: getCfgGrade
3406:     * eh so um TextBox do form).
3407:     *==========================================================================
3408:     PROCEDURE AcertaColunas(par_cTipo)
3409:         LOCAL loc_oGrid, loc_oTxtCfg, loc_cStr, loc_nCnt, loc_cCol, loc_cBlo, loc_nWid, loc_lVis, loc_nPos
3410: 
3411:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1
3412:         loc_oTxtCfg = THIS.pgf_4c_Paginas.Page1.txt_4c_CfgGrade
3413: 
3414:         IF UPPER(ALLTRIM(NVL(par_cTipo, ""))) == "LER"
3415:             loc_cStr = loc_oTxtCfg.Value
3416: 
3417:             IF EMPTY(loc_cStr)
3418:                 RETURN
3419:             ENDIF
3420: 
3421:             loc_nPos = 1
3422:             FOR loc_nCnt = 1 TO loc_oGrid.ColumnCount
3423:                 loc_cBlo = SUBSTR(loc_cStr, loc_nPos, 5)
3424:                 loc_nWid = INT(VAL(SUBSTR(loc_cBlo, 1, 3)))
3425:                 loc_lVis = !(SUBSTR(loc_cBlo, 4, 1) == "0")
3426:                 loc_cCol = TRANSFORM(loc_nCnt)

*-- Linhas 3491 a 3511:
3491:         loc_cMensagem   = ""
3492:         loc_cFormulario = THIS.this_oBusinessObject.ObterFormularioOperacaoRegistro(@loc_cMensagem)
3493: 
3494:         IF !EMPTY(loc_cMensagem)
3495:             MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
3496:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.grd_4c_Dados1.SetFocus()
3497:         ENDIF
3498: 
3499:         IF EMPTY(loc_cFormulario)
3500:             RETURN
3501:         ENDIF
3502: 
3503:         TRY
3504:             DO CASE
3505:                 CASE loc_cFormulario == "SigMvExp"
3506:                     GarantirClasse("FormSigMvExp")
3507:                     loc_oForm = CREATEOBJECT("FormSigMvExp", THIS.this_oBusinessObject.this_cRegMovimentacao, ;
3508:                         "C", THIS.this_oBusinessObject.this_nRegNumero, THIS.this_oBusinessObject.this_cRegEmpresa, .T.)
3509:                 CASE loc_cFormulario == "SigMvPdt"
3510:                     GarantirClasse("FormSigMvPdt")
3511:                     loc_oForm = CREATEOBJECT("FormSigMvPdt", THIS.this_oBusinessObject.this_cRegMovimentacao, ;

*-- Linhas 3583 a 3603:
3583:     * BtnVisualizarClick / BtnImprimirClick - btnVisualizar.Click /
3584:     * BtnImprimir.Click no legado: preview/impressao do relatorio de
3585:     * embalagem (Report Form SigOpPck sobre um recorte INDEXADO/FILTRADO
3586:     * de crPgRes01). O form novo equivalente (FormSigOpPck, OPERACIONAL, ja
3587:     * migrado) tem FILTROS PROPRIOS e independentes - nao ha API publica
3588:     * para injetar o recorte atual de cursor_4c_Detalhe nele (duplicar o
3589:     * FRX e a logica de filtro aqui recriaria, fora de contexto, o que
3590:     * aquele form ja faz). Por isso estes botoes abrem o FormSigOpPck para
3591:     * o usuario refazer o filtro la.
3592:     *==========================================================================
3593:     PROCEDURE BtnVisualizarClick()
3594:         THIS.AbrirFormSigOpPck()
3595:     ENDPROC
3596: 
3597:     PROCEDURE BtnImprimirClick()
3598:         THIS.AbrirFormSigOpPck()
3599:     ENDPROC
3600: 
3601:     PROTECTED PROCEDURE AbrirFormSigOpPck()
3602:         LOCAL loc_oForm, loc_oException
3603: 

*-- Linhas 3692 a 3763:
3692:                     "Margem" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + "% Diferen" + CHR(231) + "a" + CHR(9) + ;
3693:                     "Valor do Cadastro" + CHR(9) + "Total" + CHR(9) + "Parcelas" + CHR(9) + "Condi" + CHR(231) + CHR(245) + "es de Pagamento" + CHR(9) + ;
3694:                     "Cliente" + CHR(9) + "Nome do Cliente" + CHR(9) + "Fornecedor" + CHR(9) + "Nome do Fornecedor" + CHR(9) + ;
3695:                     "Subgrupo" + CHR(9) + "Refer" + CHR(234) + "ncia" + CHR(9) + "Gde Grupo" + CHR(9) + "Grupo" + CHR(9) + ;
3696:                     "Quantidade" + CHR(9) + "Movimenta" + CHR(231) + CHR(227) + "o" + CHR(9) + "Opera" + CHR(231) + CHR(227) + "o" + CHR(9)
3697:                 SELECT cursor_4c_Detalhe
3698:             CASE loc_nPagina = 2
3699:                 loc_cStr = "Empresa" + CHR(9) + "Descritivo" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
3700:                     "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
3701:                     "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
3702:                 SELECT cursor_4c_TotalEmpresa
3703:             CASE loc_nPagina = 3
3704:                 loc_cStr = "Empresa" + CHR(9) + "Vendedora" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
3705:                     "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
3706:                     "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
3707:                 SELECT cursor_4c_TotalVendedora
3708:         ENDCASE
3709: 
3710:         loc_cStr = loc_cStr + CHR(13)
3711:         STRTOFILE(loc_cStr, loc_cArquivo, 1)
3712: 
3713:         SCAN
3714:             loc_cStr = ""
3715:             DO CASE
3716:                 CASE loc_nPagina = 1
3717:                     loc_cStr = loc_cStr + ;
3718:                         THIS.FLimpa(cursor_4c_Detalhe.Empresa, "C") + ;
3719:                         THIS.FLimpa(STR(cursor_4c_Detalhe.Numero, 10), "C") + ;
3720:                         THIS.FLimpa(DTOC(cursor_4c_Detalhe.Data_Venda), "C") + ;
3721:                         THIS.FLimpa(cursor_4c_Detalhe.Codigo_Vendedora, "C") + ;
3722:                         THIS.FLimpa(STR(cursor_4c_Detalhe.Barras, 14), "C") + ;
3723:                         THIS.FLimpa(cursor_4c_Detalhe.Codigo_Item, "C") + ;
3724:                         THIS.FLimpa(cursor_4c_Detalhe.Equivalente, "C") + ;
3725:                         THIS.FLimpa(cursor_4c_Detalhe.Desc_Item, "C") + ;
3726:                         THIS.FLimpa(cursor_4c_Detalhe.Cor, "C") + ;
3727:                         THIS.FLimpa(cursor_4c_Detalhe.Tamanho, "C") + ;
3728:                         THIS.FLimpa(cursor_4c_Detalhe.Custo_Cadastro, "N") + ;
3729:                         THIS.FLimpa(cursor_4c_Detalhe.Val_Unitario, "N") + ;
3730:                         THIS.FLimpa(cursor_4c_Detalhe.Markup, "N") + ;
3731:                         THIS.FLimpa(cursor_4c_Detalhe.Valor_Diferenca, "N") + ;
3732:                         THIS.FLimpa(cursor_4c_Detalhe.Perc_Diferenca, "N") + ;
3733:                         THIS.FLimpa(cursor_4c_Detalhe.Venda_Cadastro, "N") + ;
3734:                         THIS.FLimpa(cursor_4c_Detalhe.Total, "N") + ;
3735:                         THIS.FLimpa(cursor_4c_Detalhe.Parcelas, "N") + ;
3736:                         THIS.FLimpa(cursor_4c_Detalhe.Cond_Pagto, "C") + ;
3737:                         THIS.FLimpa(cursor_4c_Detalhe.Cod_Cliente, "C") + ;
3738:                         THIS.FLimpa(cursor_4c_Detalhe.Nome_Cliente, "C") + ;
3739:                         THIS.FLimpa(cursor_4c_Detalhe.Cod_Fornecedor, "C") + ;
3740:                         THIS.FLimpa(cursor_4c_Detalhe.Nome_Fornecedor, "C") + ;
3741:                         THIS.FLimpa(cursor_4c_Detalhe.SubGrupo, "C") + ;
3742:                         THIS.FLimpa(cursor_4c_Detalhe.Ref_Fornecedor, "C") + ;
3743:                         THIS.FLimpa(cursor_4c_Detalhe.Gde_Grupo, "C") + ;
3744:                         THIS.FLimpa(cursor_4c_Detalhe.Grupo, "C") + ;
3745:                         THIS.FLimpa(cursor_4c_Detalhe.Quantidade, "N") + ;
3746:                         THIS.FLimpa(cursor_4c_Detalhe.Movimentacao, "C") + ;
3747:                         THIS.FLimpa(cursor_4c_Detalhe.Operacao, "C") + ;
3748:                         THIS.FLimpa(cursor_4c_Detalhe.Local_Itn, "C")
3749:                 CASE loc_nPagina = 2
3750:                     loc_cStr = loc_cStr + ;
3751:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Empresa, "C") + ;
3752:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Movimentacao, "C") + ;
3753:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Valor_Diferenca, "N") + ;
3754:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Perc_Diferenca, "N") + ;
3755:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Venda_Cadastro, "N") + ;
3756:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Quantidade, "N") + ;
3757:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Total, "N") + ;
3758:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Custo_Cadastro, "N") + ;
3759:                         THIS.FLimpa(cursor_4c_TotalEmpresa.Tkt_Medio, "N")
3760:                 CASE loc_nPagina = 3
3761:                     loc_cStr = loc_cStr + ;
3762:                         THIS.FLimpa(cursor_4c_TotalVendedora.Empresa, "C") + ;
3763:                         THIS.FLimpa(cursor_4c_TotalVendedora.Codigo_Vendedora, "C") + ;

*-- Linhas 3810 a 3830:
3810:                        Tam_De, Tam_Para, Custo_Cadastro, ;
3811:                        Val_Unitario, Markup, Valor_Diferenca, Perc_Diferenca, ;
3812:                        Venda_Cadastro, Total, Parcelas, Cond_Pagto, Cod_Cliente, ;
3813:                        Nome_Cliente, Cod_Fornecedor, Nome_Fornecedor, SubGrupo, ;
3814:                        Ref_Fornecedor, Gde_Grupo, Grupo, Quantidade, Movimentacao ;
3815:                   FROM cursor_4c_Detalhe ;
3816:                  WHERE !INLIST(ALLTRIM(Movimentacao), "TOTAL DE ENTRADAS", "TOTAL DE SAIDAS") ;
3817:                  ORDER BY Empresa, Ordem, Data_Venda, Movimentacao, Numero, Item ;
3818:                   INTO CURSOR cursor_4c_Excel
3819:             CASE loc_nPagina = 2
3820:                 SELECT Empresa, Movimentacao, Valor_Diferenca, Perc_Diferenca, ;
3821:                        Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
3822:                   FROM cursor_4c_TotalEmpresa ;
3823:                  ORDER BY Empresa, Ordem, Movimentacao ;
3824:                   INTO CURSOR cursor_4c_Excel
3825:             CASE loc_nPagina = 3
3826:                 SELECT Empresa, Codigo_Vendedora, Valor_Diferenca, Perc_Diferenca, ;
3827:                        Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
3828:                   FROM cursor_4c_TotalVendedora ;
3829:                  ORDER BY Empresa, Ordem, Codigo_Vendedora ;
3830:                   INTO CURSOR cursor_4c_Excel

