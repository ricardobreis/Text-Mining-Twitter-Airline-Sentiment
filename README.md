# Text-Mining-Twitter-Airline-Sentiment

A base que estamos analisando possui 14.640 tweets de passageiros de companhias aéreas com 15 variáveis. Essa base foi extraída do kaggle (https://www.kaggle.com/crowdflower/twitter-airline-sentiment) e por já possuir uma análise feita selecionamos as 6 variáveis que achamos ser pertinentes para comparação entre os tweets e fazer nossa própria análise sobre os comentários e excluímos as variáveis da análise da base. As variáveis selecionadas para análise foram:

-	tweet_id – número de identificação do tweet postado
-	airline – nome da companhia aérea – 6 companhias aéreas
-	name – nome ou apelido do passageiro que postou o tweet
-	text – o texto que o passageiro posta
-	tweet_created – data e hora dos tweets que vão de 16/02/2015 há 24/02/2015
-	user_timezone – timezone do tweet em questão

Após a leitura da base, tratamos a variável text, transformando-a para caracteres e a variável tweet_created para data. Fizemos então contagens de tweets por companhia aérea, por timezone, por dia, que gerou os seguintes gráficos:

![Tweets por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/tweets%20por%20companhia.png)

![Tweets por Timezone](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/tweets%20por%20timezone.png)

![Tweets por Dia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/tweets%20por%20dia.png)

Para uma melhor visualização dos tweets postados por companhia aérea, fizemos um gráfico de tweets por empresa em função da data de postagem.

![Tweets por Dia por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/tweets%20por%20dia%20por%20companhia.png)

## Análise das Palavras e Sentimentos

Removendo as stop words para análise da base, vimos a necessidade de acrescentar outras stop words a lista como http, win, t.co, 2 entre outras, pois não adicionam significado à análise. Após fazer a tokenização e remover as stop words chegamos as seguintes palavras mais comentadas:

![Contagem de Palavras](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/contagem%20de%20palavras.png)

A palavra *flight* certamente é a mais utilizada pois os posts são comentários sobre os voos das empresas, já a palavra *JetBlue*, como podemos levantar, são relacionadas sempre a um voo da Delta, *cancelled* sobre cancelamentos de voos, *service* mencionando algum serviço, *time* falando sobre horário do voo, *customer* sobre os clientes, *hours* novamente relacionado a horário, *flights* sobre mais de um voo, *hold* no sentido de que houve uma espera, *plane* sobre a aeronave.

Fazendo a contagem de palavras por companhia aérea, percebemos que a palavra *JetBlue* aparece somente na Delta Airlines, relatando sobre voos que essas companhias fazem em parceria, as palavras *flight* e *flights* se referem ou a reclamações ou elogios sobre os voos, assim como *service*, *time*, *hours*, que podem ser tanto reclamações como elogios, no entanto *cancelled* na American indica um descontentamento muito grande em relação a cancelamentos, *delayed* na Delta também indicando um grande descontentamento, *cancelled* na Southwest, US Airways e Virgin America. A única que aparece tanto a palavra *delayed* como *cancelled* nas 10 maiores ocorrências é a United, mostrando o descontentamento em relação a esses dois itens. Outra palavra que chama atenção é *gate*, indicando uma mudança de portão constante em seus voos, já a palavra *bag*, geralmente esta relacionada a extravio de bagagem. Portanto comparando as empresas analisadas, a United apresenta um maior grau de descontentamento que as demais empresas.

![Contagem de Palavras por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/contagem%20de%20palavras%20por%20companhia.png)

No gráfico abaixo podemos observar a nuvem de palavras mencionadas acima de acordo com sua importância:

![Nuvem de Palavras](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/nuvem%20de%20palavras.png)

Analisando o gráfico de sentimentos negativos por dia, podemos perceber um aumento significativo de sentimentos negativos do dia 21 ao dia 23, indicando que houve muitos problemas durante esse período.

![Sentimentos Negativos por Dia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/sentimento%20negativo%20por%20dia.png)

Porém ao analisarmos o gráfico dos sentimentos positivos, podemos constatar que o aumento do sentimento positivo se comporta da mesma forma que os negativos, e pela figura acima, constatamos um aumento muito grande nos tweets nesse período, não indicando uma tendência positiva ou negativa, apenas um aumento no número de tweets.

![Sentimentos Positivos por Dia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/sentimento%20positivo%20por%20dia.png)

No gráficos de sentimentos positivos e negativos por empresa podemos novamente constatar o aumento de tweets em praticamente todas as empresas, exceto Southwest e Virgin America com volumes muito pequenos.

![Sentimentos Negativos por Dia por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/Sentimentos%20Negativos%20por%20Dia%20por%20Companhia.png)

![Sentimentos Positivos por Dia por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/Sentimentos%20Positivos%20por%20Dia%20por%20Companhia.png)

Fazendo-se a análise de sentimentos por empresa, chegamos ao gráfico abaixo, que indica o constatado anteriormente, ou seja, a United possui um grau de insatisfação maior proporcionalmente as demais empresas.

![Contagem de Sentimentos por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/sentimento%20por%20companhia.png)

No gráfico abaixo, podemos observar as palavras que são mais usadas positivamente e negativamente pelos passageiros, tais como *atrasado, perdido, pior, ruim, preso, perder, problema* aparecem como as principais negativas, e *amor, restituição, legal, de graça, útil, incrível, feliz, legal* e *leal* como palavras positivas.

![Contagem de Palavras por Sentimento](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/contagem%20de%20palavras%20por%20sentimento.png)

Na contagem de palavras positivas por companhia, podemos observar que a United ganha muitos pontos reembolsando os passageiros, porém isso significa que teve muitos voos cancelados, enquanto que nas concorrentes o número de elogios por reembolso não é tão grande, porém a palavra *love* aparece com bastante frequência, assim como *free*, *awesome* e *nice*.

![Contagem de Palavras de Sentimento Positivo por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/contagem%20de%20palavras%20de%20sentimento%20positivo%20por%20companhia.png)

Como podemos observar, na contagem de palavras negativas por companhia, as palavras *delay* e *delayed* tem uma incidência grande, indicando descontentamento com atrasos por parte dos passageiros, já a palavra *worst* indica uma insatisfação maior que o aceitável juntamente com a palavra *lost* indicando perda de bagagem. Na concorrência os atrasos também são o maior ponto de descontentamento, porém possui um grau de incidência menor que na United. Na American, Southwest e US Airways aparece a palavra *rude*, indicando que os funcionários são rudes com os passageiros.

![Contagem de Palavras de Sentimento Negativos por Companhia](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/contagem%20de%20palavras%20de%20sentimento%20negativo%20por%20companhia.png)

Nas nuvens de palavras abaixo fica mais fácil observar os pontos levantados acima, onde as palavras com maior incidência aparecem maiores indicando uma maior importância das mesmas.

### United

Positivas                  |  Negativas
:-------------------------:|:-------------------------:
![Nuvem Positiva](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/UNITED%20-%20nuvem%20positiva.png) | ![Nuvem Negativa](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/UNITED%20-%20nuvem%20negativa.png)

### Delta

Positivas                  |  Negativas
:-------------------------:|:-------------------------:
![Nuvem Positiva](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/DELTA%20-%20nuvem%20positiva.png) | ![Nuvem Negativa](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/DELTA%20-%20nuvem%20negativa.png)

### US Airways

Positivas                  |  Negativas
:-------------------------:|:-------------------------:
![Nuvem Positiva](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/US%20AIRWAYS%20-%20nuvem%20positiva.png) | ![Nuvem Negativa](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/US%20AIRWAYS%20-%20nuvem%20negativa.png)

### American

Positivas                  |  Negativas
:-------------------------:|:-------------------------:
![Nuvem Positiva](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/AMERICAN%20-%20nuvem%20positiva.png) | ![Nuvem Negativa](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/AMERICAN%20-%20nuvem%20negativa.png)

### Southwest

Positivas                  |  Negativas
:-------------------------:|:-------------------------:
![Nuvem Positiva](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/SOUTHWEST%20-%20nuvem%20positiva.png) | ![Nuvem Negativa](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/SOUTHWEST%20-%20nuvem%20negativa.png)

### Virgin American

Positivas                  |  Negativas
:-------------------------:|:-------------------------:
![Nuvem Positiva](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/VIRGIN%20-%20nuvem%20positiva.png) | ![Nuvem Negativa](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/VIRGIN%20-%20nuvem%20negativa.png)

## Análise de Rede

Para fazer a análise de rede construimos um DTM (Document Term Matrix) onde os nós representam tweets e companhias aéreas, para observarmos a relação entre ambos. Filtramos por time zone, onde a primeira rede criada foi de Sydney e para essa timezone a companhia Delta obteve o maior números de tweets como podemos observar no gráfico abaixo, gerando um degree de 78 para a Delta, 11 para a Virgin America, 8 United, 6 US Airways e 4 degrees para a American.

![Sydney](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/SYDNEY%20-%20tweets%20por%20companhia.png)

Adotamos o mesmo procedimento para as timezones Alaska e Amsterdam, chegando nos seguintes resultados:

![Alaska](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/ALASKA%20-%20tweets%20por%20companhia.png)

A rede do Alaska tem uma distribuição entre os nós mais homogênea não havendo concentração em apenas uma companhia.

![Amsterdam](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/AMSTERDAM%20-%20tweets%20por%20companhia.png)

Na timezone Amsterdam podemos ver novamente uma concentração na companhia United dessa vez, com o total de 46 degrees.

Montando a rede filtrando por palavras negativas, chegamos aos seguintes resultados:

![Rede de Palavras Negativas](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/Palavras%20Negativas%20por%20companhia.png)

E a rede por palavras positivas apresenta a seguinte configuração:

![Rede de Palavras Positivas](https://github.com/ricardobreis/Text-Mining-Twitter-Airline-Sentiment/blob/master/img/Palavras%20Positivas%20por%20companhia.png)

## Conclusão

Pelo estudo acima das postagem dos passageiros através dos tweets podemos chegar a conclusão que o número de passageiros descontentes com o serviço prestado pela United é maior que a de seus concorrentes, e através do estudo de análise de sentimentos podemos detectar onde estão as principais reclamações, as que ocorrem com maior frequência e indicar onde a empresa deve aplicar seus recursos afim de melhorar sua imagem com os consumidores.

Vimos que a política de reembolso da United esta agregando bastante valor aos seus passageiros, que saem satisfeitos indicando que procurarão a companhia no futuro, portanto esse é uma política que deve ser mantido pela empresa, assim como a cordialidade de seus funcionários que também faz a empresa se sobressair sobre as demais.

Já no lado negativo, vimos que a empresa deve se empenhar e despender recursos para diminuir ao máximo os atrasos de voos que é o ponto que ela mais perde para seus concorrentes, assim como melhorar o método de transporte de bagagem pois ela costuma extraviar mais bagagem que os concorrentes. Trabalhando esses dois pontos a companhia diminuirá significativamente o número de passageiros descontentes que ela atualmente esta perdendo para seus concorrentes.

## Authors

- Ricardo Reis
- Marcio Eggers
