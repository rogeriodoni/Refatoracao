Corrija as 5 diferenca(s) visual(is) no Form migrado.

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
            <p>Formulario: FormSigPrPpc | Data: 18/07/2026 07:04:04</p>
        </div>        <div class="resumo">
            <div class="card total">
                <h3>Total de Problemas</h3>
                <div class="numero">65</div>
            </div>
            <div class="card erro">
                <h3>Erros Criticos</h3>
                <div class="numero">4</div>
            </div>
            <div class="card aviso">
                <h3>Avisos</h3>
                <div class="numero">56</div>
            </div>
            <div class="card diferenca">
                <h3>Diferencas Visuais</h3>
                <div class="numero">5</div>
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
        <td><code>127</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>139</td>
      </tr>
      <tr>
        <td>2</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Left</strong></td>
        <td><code>95</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>140</td>
      </tr>
      <tr>
        <td>3</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Width</strong></td>
        <td><code>520</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>141</td>
      </tr>
      <tr>
        <td>4</td>
        <td><span class="badge erro">ERRO</span></td>
        <td><code>Dataenvironment</code></td>
        <td><strong>Height</strong></td>
        <td><code>200</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>142</td>
      </tr>
      <tr>
        <td>5</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGPRPPC.cntSombra</code></td>
        <td><strong>Width</strong></td>
        <td><code>800</code></td>
        <td><code>660</code></td>
        <td>173</td>
      </tr>
      <tr>
        <td>6</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGPRPPC.cntSombra.lblSombra</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Cadastro de Testes</code></td>
        <td><code>Produtos Por Conta</code></td>
        <td>190</td>
      </tr>
      <tr>
        <td>7</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGPRPPC.cntSombra.lblSombra</code></td>
        <td><strong>Width</strong></td>
        <td><code>769</code></td>
        <td><code>640</code></td>
        <td>194</td>
      </tr>
      <tr>
        <td>8</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGPRPPC.cntSombra.lblTitulo</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Cadastro de Testes</code></td>
        <td><code>Produtos Por Conta</code></td>
        <td>209</td>
      </tr>
      <tr>
        <td>9</td>
        <td><span class="badge diferenca">DIFERENCA</span></td>
        <td><code>SIGPRPPC.cntSombra.lblTitulo</code></td>
        <td><strong>Width</strong></td>
        <td><code>769</code></td>
        <td><code>640</code></td>
        <td>213</td>
      </tr>
      <tr>
        <td>10</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.lbl_cliente</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Conta :</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>223</td>
      </tr>
      <tr>
        <td>11</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.lbl_cliente</code></td>
        <td><strong>Left</strong></td>
        <td><code>138</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>224</td>
      </tr>
      <tr>
        <td>12</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.lbl_cliente</code></td>
        <td><strong>Top</strong></td>
        <td><code>150</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>225</td>
      </tr>
      <tr>
        <td>13</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>233</td>
      </tr>
      <tr>
        <td>14</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente</code></td>
        <td><strong>Left</strong></td>
        <td><code>180</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>234</td>
      </tr>
      <tr>
        <td>15</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente</code></td>
        <td><strong>Top</strong></td>
        <td><code>145</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>236</td>
      </tr>
      <tr>
        <td>16</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente</code></td>
        <td><strong>Width</strong></td>
        <td><code>80</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>237</td>
      </tr>
      <tr>
        <td>17</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>0,0,0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>238</td>
      </tr>
      <tr>
        <td>18</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente_desc</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>245</td>
      </tr>
      <tr>
        <td>19</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente_desc</code></td>
        <td><strong>Left</strong></td>
        <td><code>261</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>246</td>
      </tr>
      <tr>
        <td>20</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente_desc</code></td>
        <td><strong>Top</strong></td>
        <td><code>145</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>248</td>
      </tr>
      <tr>
        <td>21</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente_desc</code></td>
        <td><strong>Width</strong></td>
        <td><code>290</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>249</td>
      </tr>
      <tr>
        <td>22</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_cliente_desc</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>0,0,0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>250</td>
      </tr>
      <tr>
        <td>23</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.Top</strong></td>
        <td><code>5</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>271</td>
      </tr>
      <tr>
        <td>24</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.Left</strong></td>
        <td><code>5</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>272</td>
      </tr>
      <tr>
        <td>25</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.Height</strong></td>
        <td><code>75</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>273</td>
      </tr>
      <tr>
        <td>26</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.Width</strong></td>
        <td><code>75</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>274</td>
      </tr>
      <tr>
        <td>27</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.FontBold</strong></td>
        <td><code>.T.</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>275</td>
      </tr>
      <tr>
        <td>28</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.FontItalic</strong></td>
        <td><code>.T.</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>276</td>
      </tr>
      <tr>
        <td>29</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.FontName</strong></td>
        <td><code>Comic Sans MS</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>277</td>
      </tr>
      <tr>
        <td>30</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>278</td>
      </tr>
      <tr>
        <td>31</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.Picture</strong></td>
        <td><code>..\framework\imagens\geral_procura_60.jpg</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>279</td>
      </tr>
      <tr>
        <td>32</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.Caption</strong></td>
        <td><code>\&lt;Consultar</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>280</td>
      </tr>
      <tr>
        <td>33</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>281</td>
      </tr>
      <tr>
        <td>34</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.BackColor</strong></td>
        <td><code>255,255,255</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>282</td>
      </tr>
      <tr>
        <td>35</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.DisabledBackColor</strong></td>
        <td><code>255,255,255</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>283</td>
      </tr>
      <tr>
        <td>36</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command1.Themes</strong></td>
        <td><code>.F.</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>284</td>
      </tr>
      <tr>
        <td>37</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.Top</strong></td>
        <td><code>5</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>286</td>
      </tr>
      <tr>
        <td>38</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.Left</strong></td>
        <td><code>81</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>287</td>
      </tr>
      <tr>
        <td>39</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.Height</strong></td>
        <td><code>75</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>288</td>
      </tr>
      <tr>
        <td>40</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.Width</strong></td>
        <td><code>75</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>289</td>
      </tr>
      <tr>
        <td>41</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.FontBold</strong></td>
        <td><code>.T.</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>290</td>
      </tr>
      <tr>
        <td>42</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.FontItalic</strong></td>
        <td><code>.T.</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>291</td>
      </tr>
      <tr>
        <td>43</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.FontName</strong></td>
        <td><code>Comic Sans MS</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>292</td>
      </tr>
      <tr>
        <td>44</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.FontSize</strong></td>
        <td><code>8</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>293</td>
      </tr>
      <tr>
        <td>45</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.Picture</strong></td>
        <td><code>..\framework\imagens\cadastro_sair_60.jpg</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>294</td>
      </tr>
      <tr>
        <td>46</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.Caption</strong></td>
        <td><code>Encerrar</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>296</td>
      </tr>
      <tr>
        <td>47</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.ForeColor</strong></td>
        <td><code>90,90,90</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>298</td>
      </tr>
      <tr>
        <td>48</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.BackColor</strong></td>
        <td><code>255,255,255</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>299</td>
      </tr>
      <tr>
        <td>49</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.grp_operacao</code></td>
        <td><strong>Command2.Themes</strong></td>
        <td><code>.F.</code></td>
        <td><code>(propriedade n�o existe)</code></td>
        <td>300</td>
      </tr>
      <tr>
        <td>50</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_inicial</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>339</td>
      </tr>
      <tr>
        <td>51</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_inicial</code></td>
        <td><strong>Left</strong></td>
        <td><code>180</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>340</td>
      </tr>
      <tr>
        <td>52</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_inicial</code></td>
        <td><strong>Top</strong></td>
        <td><code>195</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>342</td>
      </tr>
      <tr>
        <td>53</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_inicial</code></td>
        <td><strong>Width</strong></td>
        <td><code>80</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>343</td>
      </tr>
      <tr>
        <td>54</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_inicial</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>0,0,0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>344</td>
      </tr>
      <tr>
        <td>55</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_final</code></td>
        <td><strong>FontName</strong></td>
        <td><code>Tahoma</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>351</td>
      </tr>
      <tr>
        <td>56</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_final</code></td>
        <td><strong>Left</strong></td>
        <td><code>273</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>352</td>
      </tr>
      <tr>
        <td>57</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_final</code></td>
        <td><strong>Top</strong></td>
        <td><code>195</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>354</td>
      </tr>
      <tr>
        <td>58</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_final</code></td>
        <td><strong>Width</strong></td>
        <td><code>80</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>355</td>
      </tr>
      <tr>
        <td>59</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.get_dt_final</code></td>
        <td><strong>ForeColor</strong></td>
        <td><code>0,0,0</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>356</td>
      </tr>
      <tr>
        <td>60</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.lbl_periodo_a</code></td>
        <td><strong>Caption</strong></td>
        <td><code>�</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>398</td>
      </tr>
      <tr>
        <td>61</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.lbl_periodo_a</code></td>
        <td><strong>Left</strong></td>
        <td><code>263</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>399</td>
      </tr>
      <tr>
        <td>62</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.lbl_periodo_a</code></td>
        <td><strong>Top</strong></td>
        <td><code>200</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>400</td>
      </tr>
      <tr>
        <td>63</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.Say4</code></td>
        <td><strong>Caption</strong></td>
        <td><code>Grupo :</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>408</td>
      </tr>
      <tr>
        <td>64</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.Say4</code></td>
        <td><strong>Left</strong></td>
        <td><code>138</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>409</td>
      </tr>
      <tr>
        <td>65</td>
        <td><span class="badge aviso">AVISO</span></td>
        <td><code>SIGPRPPC.Say4</code></td>
        <td><strong>Top</strong></td>
        <td><code>123</code></td>
        <td><code>(objeto n�o encontrado)</code></td>
        <td>410</td>
      </tr>
    </tbody>
  </table>

INSTRUCAO CRITICA:
1. Leia cada DIFERENCA no relatorio acima
2. Encontre o controle correspondente no .prg
3. Ajuste APENAS a propriedade diferente para o valor ESPERADO
4. NAO altere nenhuma outra propriedade, metodo ou logica
5. As diferencas sao normalmente: Width, Height, Top, Left, FontSize, Caption

Arquivo a corrigir: C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.prg
