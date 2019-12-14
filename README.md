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

WORK IN PROGRESS...

## Authors

- Ricardo Reis
- Marcio Eggers
