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


# Leitura do Dados --------------------------------------------------------

path <- "C:/Users/Ricardo/Documents/R-Projetos/TwitterAirlineSentiment/"

tweets <- read.csv(paste(path,"tweets.csv",sep=""), sep=",",header = T,stringsAsFactors = F)[,c(1,6,8,10,11,13,15)]

# Typecast dos tweets para character
tweets$text <- as.character(tweets$text)


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
  "virginamerica", "CUSTOM"
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
  
# Criando nuvem de palavras
wordcloud(
  word = contagem$word, 
  freq = contagem$n,
  max.words = 10
)


# Análise de Sentimentos --------------------------------------------------

sentiment_tweets <- tidy_tweets %>% 
  inner_join(get_sentiments("bing"))

# Contagem de sentimentos
contagem_sentimento <- sentiment_tweets %>% 
  count(sentiment) %>% 
  arrange(desc(n))

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
