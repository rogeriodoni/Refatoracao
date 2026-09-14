Corrija as 4 diferenca(s) visual(is) no Form migrado.

RELATORIO DE DIFERENCAS (extraido do HTML de validacao):
diferenca { border-left-color: #e67e22; }
        .card.diferenca .numero { color: #e67e22; }
        .card.total { border-left-color: #3498db; }
        .card.total .numero { color: #3498db; }
        .conteudo { padding: 30px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #667eea; color: white; padding: 12px; text-align: left; font-weight: 600; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f8f9fa; }
        .badge { display: inline-block; padding: 4px 12px; border-radius: 12px; font-size: 11px; font-weight: 600; text-transform: uppercase; }
        .badge.erro { background: #ffe6e6; color: #e74c3c; }
        .badge.aviso { background: #fff4e6; color: #f39c12; }
        .badge.diferenca { background: #ffe8dc; color: #e67e22; }
        .sucesso { padding: 30px; text-align: center; color: #27ae60; }
        .sucesso h2 { font-size: 32px; margin-bottom: 10px; }
        .rodape { padding: 20px 30px; background: #fafafa; color: #666; font-size: 12px; text-align: center; border-top: 1px solid #eee; }
        code { background: #f5f5f5; padding: 2px 6px; border-radius: 3px; font-family: 'Courier New', monospace; font-size: 13px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>&#128269; UI Fidelity Report</h1>
            <p>Formulario: FormSigReGla | Data: 05/06/2026 17:53:52</p>
        </div>        <div class="resumo">
            <div class="card total">
                <h3>Total de Problemas</h3>
                <div class="numero">8</div>
            </div>
            <div class="card erro">
                <h3>Erros Criticos</h3>
                <div class="numero">4</div>
            </div>
            <div class="card aviso">
                <h3>Avisos</h3>
                <div class="numero">0</div>
            </div>
            <div class="card diferenca">
                <h3>Diferencas Visuais</h3>
                <div class="numero">4</div>
            </div>
        </div><div class="conteudo">
  <h2>Detalhes das Diferencas</h2>
  <table>
    <thead>
      <tr>
        <th>#</th>
        <th>Tipo</th>
        <th>Objeto</th>
        <th>Propriedade</th>
        <th>Valor Original</th>
        <th>Valor Migrado</th>
        <th>Linha</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Top</strong></td>
        <td><code>0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>29</td>
      </tr>
      <tr>
        <td>2</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Left</strong></td>
        <td><code>0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>30</td>
      </tr>
      <tr>
        <td>3</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Width</strong></td>
        <td><code>0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>31</td>
      </tr>
      <tr>
        <td>4</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Height</strong></td>
        <td><code>0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>32</td>
      </tr>
      <tr>
        <td>5</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>Form1</code></td>
        <td><strong>Top</strong></td>
        <td><code>0</code></td>
        <td><code>91</code></td>
        <td>40</td>
      </tr>
      <tr>
        <td>6</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>Form1</code></td>
        <td><strong>Left</strong></td>
        <td><code>0</code></td>
        <td><code>457</code></td>
        <td>41</td>
      </tr>
      <tr>
        <td>7</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>Form1</code></td>
        <td><strong>Height</strong></td>
        <td><code>250</code></td>
        <td><code>600</code></td>
        <td>42</td>
      </tr>
      <tr>
        <td>8</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>Form1</code></td>
        <td><strong>Width</strong></td>
        <td><code>375</code></td>
        <td><code>1000</code></td>
        <td>43</td>
      </tr>
    </tbody>
  </table>

INSTRUCAO CRITICA:
1. Leia cada DIFERENCA no relatorio acima
2. Encontre o controle correspondente no .prg
3. Ajuste APENAS a propriedade diferente para o valor ESPERADO
4. NAO altere nenhuma outra propriedade, metodo ou logica
5. As diferencas sao normalmente: Width, Height, Top, Left, FontSize, Caption

Arquivo a corrigir: C:\4c\projeto\app\forms\operacionais\FormSigReGla.prg
