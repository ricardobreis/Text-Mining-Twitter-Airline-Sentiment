################################################################################################
#
# ANÁLISE DE MÍDIAS SOCIAIS E MINERAÇÃO DE TEXTO - MBA Business Analytics e Big Data
# Por: RICARDO REIS
#
# CASE - TWITTER AIRLINE SENTIMENT
#
#
################################################################################################


# Carrega Pacotes ---------------------------------------------------------

library(tidytext)
library(dplyr)
library(ggplot2)
library(wordcloud)
library(forcats)
library(tm)
library(sna)
library(igraph)
library(stringr)


# Leitura do Dados --------------------------------------------------------

path <- "C:/Users/Ricardo/Documents/R-Projetos/TwitterAirlineSentiment/"

tweets <- read.csv(paste(path,"tweets.csv",sep=""), sep=",",header = T,stringsAsFactors = T)[,c(1,6,8,10,11,13,15)]


# Análise Exploratória ----------------------------------------------------

glimpse(tweets)
head(tweets)
summary(tweets)

# Typecast dos tweets para character
tweets$text <- as.character(tweets$text)
tweets$tweet_created <-  as.Date(tweets$tweet_created)

# Contar de tweets por airline
contagem_tweets_airline <- tweets %>%
  count(airline)

# Plotar tweets por airline
ggplot(contagem_tweets_airline, aes(x = airline, n)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Tweets por Companhia",
    subtitle = "Total de Tweets por Companhia",
    x = "Companhias",
    y = "Tweets"
  )

# Contar de tweets por timezone
contagem_tweets_timezone <- tweets %>%
  count(user_timezone) %>%
  filter(n > 10)

# Plotar contagem de tweets por timezone
ggplot(contagem_tweets_timezone, aes(x = user_timezone, n)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Tweets por Timezone",
    subtitle = "Total de Tweets por Timezone",
    x = "Timezones",
    y = "Tweets"
  )

# Contagem tweets por dia
contagem_tweets_dia <- tweets %>%
  group_by(tweet_created) %>%
  count(tweet_created)

# Plot de tweets por dia
ggplot(contagem_tweets_dia, aes(tweet_created, n)) +
  geom_line() +
  labs(
    title = "Contagem de Tweets",
    subtitle = "Contagem de Tweets por Dia",
    x = "Dias",
    y = "Contagem"
  )

# Contagem tweets por dia por airline
contagem_tweets_dia_airline <- tweets %>%
  group_by(airline, tweet_created) %>%
  count(tweet_created)

# Plot de tweets por dia por airline
ggplot(contagem_tweets_dia_airline, aes(tweet_created, n, color = airline)) +
  geom_line() +
  labs(
    title = "Contagem de Tweets",
    subtitle = "Contagem de Tweets por Dia por Companhia",
    x = "Dias",
    y = "Contagem"
  )


# Tokenização e Remoção de Stop Words -------------------------------------

# Adicionando stop words
custom_stop_words <- tribble(
  ~word, ~lexicon,
  "http", "CUSTOM",
  "win", "CUSTOM",
  "t.co", "CUSTOM",
  "2", "CUSTOM",
  "americanair", "CUSTOM",
  "aa", "CUSTOM",
  "â", "CUSTOM",
  "southwestair", "CUSTOM",
  "united", "CUSTOM",
  "usairways", "CUSTOM",
  "virginamerica", "CUSTOM",
  "amp","CUSTOM",
  "ðÿ","CUSTOM"
)

stop_words2 <- stop_words %>% 
  rbind(custom_stop_words)

# Tokenizar e remover stop words
tidy_tweets <- tweets %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words2)

# Contar palavras
contagem <- tidy_tweets %>%
  count(word) %>%
  arrange(desc(n)) %>%
  top_n(10, n) %>%
  mutate(word2 = fct_reorder(word, n))

# Plotar contagem de palavras
ggplot(contagem, aes(x = word2, n)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Contagem de Palavras",
    subtitle = "Contagem de Palavras Geral",
    x = "Palavras",
    y = "Contagem"
  )

# Contar palavras por companhia
contagem_airline <- tidy_tweets %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  top_n(10, n) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

ggplot(contagem_airline, aes(x = word, y = n, fill = airline)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ airline, scales = "free_y") +
  coord_flip() +
  labs(
    title = "Contagem de Palavras",
    subtitle = "Contagem de Palavras por Companhia",
    x = "Palavras",
    y = "Contagem"
  )
  
contagem_nuvem <- tidy_tweets %>%
  count(word) %>%
  arrange(desc(n)) %>%
  mutate(word2 = fct_reorder(word, n))

# Criando nuvem de palavras
wordcloud(
  word = contagem_nuvem$word, 
  freq = contagem_nuvem$n,
  max.words = 50
)


# Análise de Sentimentos --------------------------------------------------

sentiment_tweets <- tidy_tweets %>% 
  inner_join(get_sentiments("bing"))

# Contagem de sentimentos
contagem_sentimento <- sentiment_tweets %>% 
  count(sentiment) %>% 
  arrange(desc(n))

# Contagem de sentimento negativo por dia
contagem_sentimento_negativo_dia <- sentiment_tweets %>%
  filter(sentiment == "negative") %>%
  group_by(tweet_created) %>%
  count(tweet_created)

# Plot de sentimento negativo por dia
ggplot(contagem_sentimento_negativo_dia, aes(tweet_created, n)) +
  geom_line() +
  labs(
    title = "Contagem de Sentimentos Negativos",
    subtitle = "Contagem de Sentimentos Negativos por Dia",
    x = "Dias",
    y = "Contagem"
  )

# Contagem de sentimento positivo por dia
contagem_sentimento_positivo_dia <- sentiment_tweets %>%
  filter(sentiment == "positive") %>%
  group_by(tweet_created) %>%
  count(tweet_created)

# Plot de sentimento positivo por dia
ggplot(contagem_sentimento_positivo_dia, aes(tweet_created, n)) +
  geom_line()  +
  labs(
    title = "Contagem de Sentimentos Positivos",
    subtitle = "Contagem de Sentimentos Positivos por Dia",
    x = "Dias",
    y = "Contagem"
  )

# Contagem de sentimento negativo por dia por companhia
contagem_sentimento_negativo_dia_airline <- sentiment_tweets %>%
  filter(sentiment == "negative") %>%
  group_by(airline, tweet_created) %>%
  count(tweet_created)

# Plot de sentimento negativo por dia por companhia
ggplot(contagem_sentimento_negativo_dia_airline, aes(tweet_created, n, color=airline)) +
  geom_line() +
  labs(
    title = "Contagem de Sentimentos Negativos",
    subtitle = "Contagem de Sentimentos Negativos por Dia por Companhia",
    x = "Dias",
    y = "Contagem"
  )

# Contagem de sentimento positivo por dia por companhia
contagem_sentimento_positivo_dia_airline <- sentiment_tweets %>%
  filter(sentiment == "positive") %>%
  group_by(airline, tweet_created) %>%
  count(tweet_created)

# Plot de sentimento positivo por dia por companhia
ggplot(contagem_sentimento_positivo_dia_airline, aes(tweet_created, n, color=airline)) +
  geom_line() +
  labs(
    title = "Contagem de Sentimentos Positivos",
    subtitle = "Contagem de Sentimentos Positivos por Dia por Companhia",
    x = "Dias",
    y = "Contagem"
  )

# Contagem de sentimentos por companhia
contagem_sentimento_companhia <- sentiment_tweets %>% 
  count(sentiment, airline) %>% 
  arrange(desc(n))

# Plot de sentimento por companhia
ggplot(sentiment_tweets, aes(sentiment_tweets$airline, fill=sentiment)) +
  geom_bar() +
  labs(
    title = "Contagem de Sentimentos por Companhia",
    subtitle = "Contagem de Sentimentos Positivos e Negativos por Companhia",
    x = "Companhias",
    y = "Contagem"
  )

# Contagem de palavras por sentimento
contagem_palavra_sentimento <- sentiment_tweets %>% 
  count(word, sentiment) %>%
  group_by(sentiment) %>%
  arrange(desc(n)) %>%
  top_n(10, n) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Plot de contagem de palavras por sentimento
ggplot(contagem_palavra_sentimento, aes(x = word2, y = n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ sentiment, scales = "free_y") +
  coord_flip() +
    labs(
      title = "Contagem de Palavras",
      subtitle = "Contagem de Palavras por Sentimento",
      x = "Palavras",
      y = "Contagem"
    )

# Contar palavras por sentimento positivo por companhia
contagem_sentimento_positivo_airline <- sentiment_tweets %>%
  filter(sentiment == "positive") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  top_n(10, n) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Plot de contagem de palavras de sentimento positivo por companhia
ggplot(contagem_sentimento_positivo_airline, aes(x = word2, y = n, fill = airline)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ airline, scales = "free_y") +
  coord_flip() +
  labs(
    title = "Contagem de Palavras",
    subtitle = "Contagem de Palavras de Sentimento Positivo por Companhia",
    x = "Palavras",
    y = "Contagem"
  )

# Contar palavras por sentimento negativo por companhia
contagem_sentimento_negativo_airline <- sentiment_tweets %>%
  filter(sentiment == "negative") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  top_n(10, n) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Plot de contagem de palavras de sentimento negativo por companhia
ggplot(contagem_sentimento_negativo_airline, aes(x = word2, y = n, fill = airline)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ airline, scales = "free_y") +
  coord_flip() +
  labs(
    title = "Contagem de Palavras",
    subtitle = "Contagem de Palavras de Sentimento Negativo por Companhia",
    x = "Palavras",
    y = "Contagem"
  )

# VIRGIN AMERICA
# Contar palavras por sentimento positivo por companhia
contagem_sentimento_positivo_virgin_nuvem <- sentiment_tweets %>%
  filter(sentiment == "positive" & airline == "Virgin America") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento positivo por companhia
wordcloud(
  word = contagem_sentimento_positivo_virgin_nuvem$word, 
  freq = contagem_sentimento_positivo_virgin_nuvem$n,
  max.words = 50
)

# UNITED
# Contar palavras por sentimento positivo por companhia
contagem_sentimento_positivo_united_nuvem <- sentiment_tweets %>%
  filter(sentiment == "positive" & airline == "United") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento positivo por companhia
wordcloud(
  word = contagem_sentimento_positivo_united_nuvem$word, 
  freq = contagem_sentimento_positivo_united_nuvem$n,
  max.words = 50
)

# SOUTHWEST
# Contar palavras por sentimento positivo por companhia
contagem_sentimento_positivo_southwest_nuvem <- sentiment_tweets %>%
  filter(sentiment == "positive" & airline == "Southwest") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento positivo por companhia
wordcloud(
  word = contagem_sentimento_positivo_southwest_nuvem$word, 
  freq = contagem_sentimento_positivo_southwest_nuvem$n,
  max.words = 50
)

# DELTA
# Contar palavras por sentimento positivo por companhia
contagem_sentimento_positivo_delta_nuvem <- sentiment_tweets %>%
  filter(sentiment == "positive" & airline == "Delta") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento positivo por companhia
wordcloud(
  word = contagem_sentimento_positivo_delta_nuvem$word, 
  freq = contagem_sentimento_positivo_delta_nuvem$n,
  max.words = 50
)

# US AIRWAYS
# Contar palavras por sentimento positivo por companhia
contagem_sentimento_positivo_usairways_nuvem <- sentiment_tweets %>%
  filter(sentiment == "positive" & airline == "US Airways") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento positivo por companhia
wordcloud(
  word = contagem_sentimento_positivo_usairways_nuvem$word, 
  freq = contagem_sentimento_positivo_usairways_nuvem$n,
  max.words = 50
)

# AMERICAN
# Contar palavras por sentimento positivo por companhia
contagem_sentimento_positivo_american_nuvem <- sentiment_tweets %>%
  filter(sentiment == "positive" & airline == "American") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento positivo por companhia
wordcloud(
  word = contagem_sentimento_positivo_usairways_nuvem$word, 
  freq = contagem_sentimento_positivo_usairways_nuvem$n,
  max.words = 50
)

# VIRGIN AMERICA
# Contar palavras por sentimento negativo
contagem_sentimento_negativo_virgin_nuvem <- sentiment_tweets %>%
  filter(sentiment == "negative" & airline == "Virgin America") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento negativo
wordcloud(
  word = contagem_sentimento_negativo_virgin_nuvem$word, 
  freq = contagem_sentimento_negativo_virgin_nuvem$n,
  max.words = 50
)

# UNITED
# Contar palavras por sentimento negativo
contagem_sentimento_negativo_united_nuvem <- sentiment_tweets %>%
  filter(sentiment == "negative" & airline == "United") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento negativo
wordcloud(
  word = contagem_sentimento_negativo_united_nuvem$word, 
  freq = contagem_sentimento_negativo_united_nuvem$n,
  max.words = 50
)

# SOUTHWEST
# Contar palavras por sentimento negativo
contagem_sentimento_negativo_southwest_nuvem <- sentiment_tweets %>%
  filter(sentiment == "negative" & airline == "Southwest") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento negativo
wordcloud(
  word = contagem_sentimento_negativo_southwest_nuvem$word, 
  freq = contagem_sentimento_negativo_southwest_nuvem$n,
  max.words = 50
)

# DELTA
# Contar palavras por sentimento negativo
contagem_sentimento_negativo_delta_nuvem <- sentiment_tweets %>%
  filter(sentiment == "negative" & airline == "Delta") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento negativo
wordcloud(
  word = contagem_sentimento_negativo_delta_nuvem$word, 
  freq = contagem_sentimento_negativo_delta_nuvem$n,
  max.words = 50
)

# US AIRWAYS
# Contar palavras por sentimento negativo
contagem_sentimento_negativo_usairways_nuvem <- sentiment_tweets %>%
  filter(sentiment == "negative" & airline == "US Airways") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento negativo
wordcloud(
  word = contagem_sentimento_negativo_usairways_nuvem$word, 
  freq = contagem_sentimento_negativo_usairways_nuvem$n,
  max.words = 50
)

# AMERICAN
# Contar palavras por sentimento negativo
contagem_sentimento_negativo_american_nuvem <- sentiment_tweets %>%
  filter(sentiment == "negative" & airline == "American") %>%
  count(word, airline) %>%
  group_by(airline) %>%
  arrange(desc(n)) %>%
  ungroup() %>% 
  mutate(word2 = fct_reorder(word, n))

# Nuvem de palavras de sentimento negativo
wordcloud(
  word = contagem_sentimento_negativo_american_nuvem$word, 
  freq = contagem_sentimento_negativo_american_nuvem$n,
  max.words = 50
)


# Análise de Rede ---------------------------------------------------------

# SYDNEY
# Cria o DTM filtrando por uma timezone
dtm_tweets <- tweets %>%
  filter(user_timezone == "Sydney") %>% 
  count(airline, tweet_id) %>% 
  cast_dtm(tweet_id, airline, n)

# Transforma o DTM em matriz para ter acesso aos valores
matrix_tweets <- as.matrix(dtm_tweets)

# transforma a matriz em grafo no formato do igraph
graph <- graph_from_incidence_matrix(t(matrix_tweets))

# Plot da rede
plot(graph, vertex.size=degree(graph, v = V(graph)), vertex.label.dist=3,
     vertex.label = ifelse(degree(graph, v = V(graph)) > 1,V(graph)$name,NA), vertex.color="red", layout = layout_nicely(graph) )

# Medidas de centralidade
degree(graph, v = V(graph)[1:6])
betweenness(graph, v = V(graph)[1:6])
closeness(graph, vids = V(graph)[1:6])

# ALASKA
# Cria o DTM filtrando por uma timezone
dtm_tweets <- tweets %>%
  filter(user_timezone == "Alaska") %>% 
  count(airline, tweet_id) %>% 
  cast_dtm(tweet_id, airline, n)

# Transforma o DTM em matriz para ter acesso aos valores
matrix_tweets <- as.matrix(dtm_tweets)

# transforma a matriz em grafo no formato do igraph
graph <- graph_from_incidence_matrix(t(matrix_tweets))

# Plot da rede
plot(graph, vertex.size=degree(graph, v = V(graph)), vertex.label.dist=3,
     vertex.label = ifelse(degree(graph, v = V(graph)) > 1,V(graph)$name,NA), vertex.color="red", layout = layout_nicely(graph) )

# Medidas de centralidade
degree(graph, v = V(graph)[1:6])
betweenness(graph, v = V(graph)[1:6])
closeness(graph, vids = V(graph)[1:6])

# AMSTERDAM
# Cria o DTM filtrando por uma timezone
dtm_tweets <- tweets %>%
  filter(user_timezone == "Amsterdam") %>% 
  count(airline, tweet_id) %>% 
  cast_dtm(tweet_id, airline, n)

# Transforma o DTM em matriz para ter acesso aos valores
matrix_tweets <- as.matrix(dtm_tweets)

# transforma a matriz em grafo no formato do igraph
graph <- graph_from_incidence_matrix(t(matrix_tweets))

# Plot da rede
plot(graph, vertex.size=degree(graph, v = V(graph)), vertex.label.dist=3,
     vertex.label = ifelse(degree(graph, v = V(graph)) > 1,V(graph)$name,NA), vertex.color="red", layout = layout_nicely(graph) )

# Medidas de centralidade
degree(graph, v = V(graph)[1:6])
betweenness(graph, v = V(graph)[1:6])
closeness(graph, vids = V(graph)[1:6])

# Palavras Negativas por companhia
dtm_tweets <- sentiment_tweets %>%
  filter(sentiment == "negative") %>% 
  count(airline, word) %>% 
  cast_dtm(word, airline, n)

matrix_tweets <- as.matrix(dtm_tweets)

# transforma a matriz em grafo no formato do igraph
graph <- graph_from_incidence_matrix(matrix_tweets)

# Plot da rede
plot(graph, vertex.size=degree(graph, v = V(graph))/20, vertex.label.dist=2,
     vertex.label = ifelse(degree(graph, v = V(graph)) > 10,V(graph)$name,NA), vertex.color="red", layout = layout_nicely(graph) )

# Palavras Positivas por companhia
dtm_tweets <- sentiment_tweets %>%
  filter(sentiment == "positive") %>% 
  count(airline, word) %>% 
  cast_dtm(word, airline, n)

matrix_tweets <- as.matrix(dtm_tweets)

# transforma a matriz em grafo no formato do igraph
graph <- graph_from_incidence_matrix(matrix_tweets)

# Plot da rede
plot(graph, vertex.size=degree(graph, v = V(graph))/20, vertex.label.dist=2,
     vertex.label = ifelse(degree(graph, v = V(graph)) > 10,V(graph)$name,NA), vertex.color="red", layout = layout_nicely(graph) )
