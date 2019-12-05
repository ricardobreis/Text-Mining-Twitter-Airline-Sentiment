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


# Leitura do Dados --------------------------------------------------------

path <- "C:/Users/Ricardo/Documents/R-Projetos/TwitterAirlineSentiment/"

tweets <- read.csv(paste(path,"tweets.csv",sep=""), sep=",",header = T,stringsAsFactors = F)

# Typecast dos tweets para character
tweets$text <- as.character(tweets$text)


# Tokenização e Remoção de Stop Words -------------------------------------

# Adicionando stop words
custom_stop_words <- tribble(
  ~word, ~lexicon,
  "http", "CUSTOM",
  "win", "CUSTOM",
  "t.co", "CUSTOM"
)

stop_words2 <- stop_words %>% 
  rbind(custom_stop_words)

tidy_tweets <- tweets %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words2)

contagem <- tidy_tweets %>%
  count(word) %>%
  arrange(desc(n)) %>%
  top_n(10, n) %>%
  mutate(word2 = fct_reorder(word, n))

ggplot(contagem, aes(x = word2, n)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Contagem de Palavras",
    subtitle = "Contagem de Palavras",
    x = "Palavras",
    y = "Contagem"
  )
  
  # Criando nuvem de palavras
  wordcloud(
    word = contagem$word, 
    freq = contagem$n,
    max.words = 30
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

ggplot(contagem_palavra_sentimento, aes(x = word2, y = n, fill = sentiment)) +
  # Don't include the lengend for the column plot
  geom_col(show.legend = FALSE) +
  # Facet by whether or not its a complaint and make the y-axis free
  facet_wrap(~ sentiment, scales = "free_y") +
  coord_flip() +
    labs(
      title = "Contagem de Palavras por Sentimento",
      subtitle = "Contagem de Palavras",
      x = "Palavras",
      y = "Contagem"
    )
