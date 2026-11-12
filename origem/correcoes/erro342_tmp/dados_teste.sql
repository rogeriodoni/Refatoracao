/*==============================================================================
  Erro342 - Posicao de Estoque Retroativo (FormSIGREEQR)
  Dados minimos para o modo "Estoque Atual" produzir linhas.

  Diagnostico (medido em 2026-11-11 contra 192.168.200.10 / DB_MBAHIA):
    SigMvEst emps='001'                            267 linhas
      + sqtds <> 0                                 240
      + INNER JOIN SigCdPro                        237
      + INNER JOIN SigCdLin (c.Linhas = d.Linhas)    0   <<< aqui zera

  SigCdLin esta VAZIA e os 260 produtos de SigCdPro tem Linhas em branco.
  O legado usa o MESMO inner join ("From SigMvEst a, SigCdPro c, SigCdLin d
  ... And c.Linhas = d.Linhas"), entao o relatorio legado tambem sairia vazio:
  o que falta eh o registro MESTRE da linha, nao codigo.

  tpcustos/tpvendas = '1' -> valor direto. ('2' multiplicaria pelo peso -
  ver SIGREEQR.processamento: "If m.tpcustos = '2' / m.vlCusto = m.pesoms * ...")
==============================================================================*/
USE DB_MBAHIA;
GO

IF NOT EXISTS (SELECT 1 FROM SigCdLin WHERE linhas = '')
BEGIN
    INSERT INTO SigCdLin
        (codcols, descs, linhas, pedidos, tpcustos, tpvendas, teors,
         breservas, qtpcs, tppesos, chkpesags, ids, bonus, gernetiqs,
         vlrfixos, figjpgs)
    VALUES
        ('', 'LINHA PADRAO', '', '', '1', '1', 0,
         0, 0, '', 0, 0, 0, 0,
         0, NULL);
    PRINT 'SigCdLin: registro da linha em branco criado.';
END
ELSE
    PRINT 'SigCdLin: linha em branco ja existe - nada feito.';
GO

/*-- conferencia: quantas linhas o modo "Estoque Atual" passa a enxergar --*/
SELECT COUNT(*) AS linhas_estoque_atual
  FROM SigMvEst a
 INNER JOIN SigCdPro c ON a.cpros = c.cpros
 INNER JOIN SigCdLin d ON c.Linhas = d.Linhas
 WHERE a.emps = '001' AND a.sqtds <> 0;
GO

/*==============================================================================
  DESFAZER
    DELETE FROM SigCdLin WHERE linhas = '' AND descs = 'LINHA PADRAO';
==============================================================================*/
