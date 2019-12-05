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


# Leitura do Dados --------------------------------------------------------

path <- "C:/Users/Ricardo/Documents/R-Projetos/TwitterAirlineSentiment/"

tweets <- read.csv(paste(path,"tweets.csv",sep=""), sep=",",header = T,stringsAsFactors = F)

# Typecast dos tweets para character
tweets$text <- as.character(tweets$text)


# Tokenização e Remoção de Stop Words -------------------------------------

tidy_tweets <- tweets %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

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
  ggtitle("Contagem de Palavras")


# Análise de Sentimentos --------------------------------------------------

sentiment_tweets <- tidy_tweets %>% 
  inner_join(get_sentiments("bing"))

# Contagem de sentimentos
contagem_sentimento <- sentiment_tweets %>% 
  count(sentiment) %>% 
  arrange(desc(n))
