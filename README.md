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

WORK IN PROGRESS...

## Authors

- Ricardo Reis
- Marcio Eggers
