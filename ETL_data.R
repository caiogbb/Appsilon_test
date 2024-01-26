library(sparklyr)

# Inicializar uma sessão do Spark
sc <- spark_connect(master = "local", version = "3.5")

# Substitua "caminho/do/arquivo/multimedia.csv" pelo caminho real do seu arquivo CSV
caminho_do_arquivo <- "occurence.csv"

# Ler o arquivo CSV para um DataFrame Spark
df_spark <- spark_read_csv(sc, "occurence_spark", caminho_do_arquivo)

# Mostrar as primeiras linhas do DataFrame Spark
head(df_spark)

# Substitua "caminho/do/arquivo/salvo.csv" pelo caminho onde você deseja salvar o arquivo CSV
caminho_do_arquivo_salvo <- "polandy/"

# Salvar o DataFrame Spark em um arquivo CSV
spark_write_csv(df_spark, path = caminho_do_arquivo_salvo, mode = "overwrite")

spark_disconnect(sc)

arquivos_csv <- list.files('polandy/', pattern = "\\.csv$", full.names = TRUE)

df_merged <- read.csv(arquivos_csv[1], h=T, sep = ',')

# Loop para carregar e fazer join com os próximos arquivos
for (i in 2:length(arquivos_csv)) {
  # Carregar o próximo arquivo CSV
  df_temp <- read.csv(arquivos_csv[i], h=T, sep = ',')
  
  df_merged <- rbind(df_merged, df_temp)
}

write.csv(df_merged, "arquivo.csv", row.names = FALSE)

