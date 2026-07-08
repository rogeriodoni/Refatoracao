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
            <p>Formulario: FormSigReEch | Data: 04/06/2026 13:39:25</p>
        </div>        <div class="resumo">
            <div class="card total">
                <h3>Total de Problemas</h3>
                <div class="numero">81</div>
            </div>
            <div class="card erro">
                <h3>Erros Criticos</h3>
                <div class="numero">4</div>
            </div>
            <div class="card aviso">
                <h3>Avisos</h3>
                <div class="numero">73</div>
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
        <td><code>220</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>189</td>
      </tr>
      <tr>
        <td>2</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Left</strong></td>
        <td><code>1</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>190</td>
      </tr>
      <tr>
        <td>3</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Width</strong></td>
        <td><code>520</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>191</td>
      </tr>
      <tr>
        <td>4</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Height</strong></td>
        <td><code>200</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>192</td>
      </tr>
      <tr>
        <td>5</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGREECH.cntSombra.lblSombra</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Cadastro de Testes</code></td>
        <td><code>Emiss�o de Cheque</code></td>
        <td>242</td>
      </tr>
      <tr>
        <td>6</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGREECH.cntSombra.lblSombra</code></td>
        <td><strong>Width</strong></td>
        <td><code>769</code></td>
        <td><code>800</code></td>
        <td>246</td>
      </tr>
      <tr>
        <td>7</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGREECH.cntSombra.lblTitulo</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Cadastro de Testes</code></td>
        <td><code>Emiss�o de Cheque</code></td>
        <td>261</td>
      </tr>
      <tr>
        <td>8</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGREECH.cntSombra.lblTitulo</code></td>
        <td><strong>Width</strong></td>
        <td><code>769</code></td>
        <td><code>800</code></td>
        <td>265</td>
      </tr>
      <tr>
        <td>9</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say2</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>370</td>
      </tr>
      <tr>
        <td>10</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say2</code></td>
        <td><strong>FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>371</td>
      </tr>
      <tr>
        <td>11</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say2</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Bco</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>372</td>
      </tr>
      <tr>
        <td>12</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say2</code></td>
        <td><strong>Left</strong></td>
        <td><code>12</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>373</td>
      </tr>
      <tr>
        <td>13</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say2</code></td>
        <td><strong>Top</strong></td>
        <td><code>3</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>374</td>
      </tr>
      <tr>
        <td>14</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say2</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>377</td>
      </tr>
      <tr>
        <td>15</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say3</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>384</td>
      </tr>
      <tr>
        <td>16</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say3</code></td>
        <td><strong>FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>385</td>
      </tr>
      <tr>
        <td>17</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say3</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Ag�ncia</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>386</td>
      </tr>
      <tr>
        <td>18</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say3</code></td>
        <td><strong>Left</strong></td>
        <td><code>57</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>387</td>
      </tr>
      <tr>
        <td>19</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say3</code></td>
        <td><strong>Top</strong></td>
        <td><code>3</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>388</td>
      </tr>
      <tr>
        <td>20</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say3</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>391</td>
      </tr>
      <tr>
        <td>21</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say4</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>398</td>
      </tr>
      <tr>
        <td>22</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say4</code></td>
        <td><strong>FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>399</td>
      </tr>
      <tr>
        <td>23</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say4</code></td>
        <td><strong>Caption</strong></td>
        <td><code>N�mero</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>400</td>
      </tr>
      <tr>
        <td>24</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say4</code></td>
        <td><strong>Left</strong></td>
        <td><code>196</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>401</td>
      </tr>
      <tr>
        <td>25</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say4</code></td>
        <td><strong>Top</strong></td>
        <td><code>3</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>402</td>
      </tr>
      <tr>
        <td>26</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say4</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>405</td>
      </tr>
      <tr>
        <td>27</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say5</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>412</td>
      </tr>
      <tr>
        <td>28</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say5</code></td>
        <td><strong>FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>413</td>
      </tr>
      <tr>
        <td>29</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say5</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Conta</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>414</td>
      </tr>
      <tr>
        <td>30</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say5</code></td>
        <td><strong>Left</strong></td>
        <td><code>107</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>415</td>
      </tr>
      <tr>
        <td>31</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say5</code></td>
        <td><strong>Top</strong></td>
        <td><code>3</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>416</td>
      </tr>
      <tr>
        <td>32</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say5</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>419</td>
      </tr>
      <tr>
        <td>33</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say1</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>440</td>
      </tr>
      <tr>
        <td>34</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say1</code></td>
        <td><strong>FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>441</td>
      </tr>
      <tr>
        <td>35</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say1</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Valor</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>442</td>
      </tr>
      <tr>
        <td>36</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say1</code></td>
        <td><strong>Left</strong></td>
        <td><code>259</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>443</td>
      </tr>
      <tr>
        <td>37</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say1</code></td>
        <td><strong>Top</strong></td>
        <td><code>3</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>444</td>
      </tr>
      <tr>
        <td>38</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say1</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>447</td>
      </tr>
      <tr>
        <td>39</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say6</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>468</td>
      </tr>
      <tr>
        <td>40</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say6</code></td>
        <td><strong>FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>469</td>
      </tr>
      <tr>
        <td>41</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say6</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Vencimento</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>470</td>
      </tr>
      <tr>
        <td>42</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say6</code></td>
        <td><strong>Left</strong></td>
        <td><code>390</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>471</td>
      </tr>
      <tr>
        <td>43</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say6</code></td>
        <td><strong>Top</strong></td>
        <td><code>3</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>472</td>
      </tr>
      <tr>
        <td>44</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Cheque.Say6</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>475</td>
      </tr>
      <tr>
        <td>45</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Height</strong></td>
        <td><code>73</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>542</td>
      </tr>
      <tr>
        <td>46</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Left</strong></td>
        <td><code>543</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>543</td>
      </tr>
      <tr>
        <td>47</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>SpecialEffect</strong></td>
        <td><code>1</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>544</td>
      </tr>
      <tr>
        <td>48</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Top</strong></td>
        <td><code>192</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>545</td>
      </tr>
      <tr>
        <td>49</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Width</strong></td>
        <td><code>79</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>546</td>
      </tr>
      <tr>
        <td>50</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>550</td>
      </tr>
      <tr>
        <td>51</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>551</td>
      </tr>
      <tr>
        <td>52</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.Caption</strong></td>
        <td><code>Cheque</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>553</td>
      </tr>
      <tr>
        <td>53</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.Height</strong></td>
        <td><code>15</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>555</td>
      </tr>
      <tr>
        <td>54</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.Left</strong></td>
        <td><code>7</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>556</td>
      </tr>
      <tr>
        <td>55</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.Top</strong></td>
        <td><code>7</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>557</td>
      </tr>
      <tr>
        <td>56</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.Width</strong></td>
        <td><code>55</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>558</td>
      </tr>
      <tr>
        <td>57</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option1.ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>560</td>
      </tr>
      <tr>
        <td>58</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>562</td>
      </tr>
      <tr>
        <td>59</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>563</td>
      </tr>
      <tr>
        <td>60</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.Caption</strong></td>
        <td><code>Verso</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>565</td>
      </tr>
      <tr>
        <td>61</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.Height</strong></td>
        <td><code>15</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>566</td>
      </tr>
      <tr>
        <td>62</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.Left</strong></td>
        <td><code>7</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>567</td>
      </tr>
      <tr>
        <td>63</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.Top</strong></td>
        <td><code>28</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>568</td>
      </tr>
      <tr>
        <td>64</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.Width</strong></td>
        <td><code>45</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>569</td>
      </tr>
      <tr>
        <td>65</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option2.ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>571</td>
      </tr>
      <tr>
        <td>66</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>573</td>
      </tr>
      <tr>
        <td>67</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>574</td>
      </tr>
      <tr>
        <td>68</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.Caption</strong></td>
        <td><code>C�pia</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>576</td>
      </tr>
      <tr>
        <td>69</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.Height</strong></td>
        <td><code>15</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>577</td>
      </tr>
      <tr>
        <td>70</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.Left</strong></td>
        <td><code>7</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>578</td>
      </tr>
      <tr>
        <td>71</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.Top</strong></td>
        <td><code>49</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>579</td>
      </tr>
      <tr>
        <td>72</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.Width</strong></td>
        <td><code>45</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>580</td>
      </tr>
      <tr>
        <td>73</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Opcao_Imprime</code></td>
        <td><strong>Option3.ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>582</td>
      </tr>
      <tr>
        <td>74</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.oModem</code></td>
        <td><strong>Top</strong></td>
        <td><code>12</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>589</td>
      </tr>
      <tr>
        <td>75</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.oModem</code></td>
        <td><strong>Left</strong></td>
        <td><code>504</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>590</td>
      </tr>
      <tr>
        <td>76</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.oModem</code></td>
        <td><strong>Height</strong></td>
        <td><code>100</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>591</td>
      </tr>
      <tr>
        <td>77</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.oModem</code></td>
        <td><strong>Width</strong></td>
        <td><code>100</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>592</td>
      </tr>
      <tr>
        <td>78</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Sair</code></td>
        <td><strong>Top</strong></td>
        <td><code>2</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>615</td>
      </tr>
      <tr>
        <td>79</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Sair</code></td>
        <td><strong>Left</strong></td>
        <td><code>723</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>616</td>
      </tr>
      <tr>
        <td>80</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Sair</code></td>
        <td><strong>Picture</strong></td>
        <td><code>..\framework\imagens\cadastro_sair_60.jpg</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>617</td>
      </tr>
      <tr>
        <td>81</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGREECH.Sair</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Encerrar</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>618</td>
      </tr>
    </tbody>
  </table>

INSTRUCAO CRITICA:
1. Leia cada DIFERENCA no relatorio acima
2. Encontre o controle correspondente no .prg
3. Ajuste APENAS a propriedade diferente para o valor ESPERADO
4. NAO altere nenhuma outra propriedade, metodo ou logica
5. As diferencas sao normalmente: Width, Height, Top, Left, FontSize, Caption

Arquivo a corrigir: C:\4c\projeto\app\forms\operacionais\FormSigReEch.prg
