library(sparklyr)

# Start the session in Spark
sc <- spark_connect(master = "local", version = "3.5")

# Int This case I cansider use the dataset in my local machine "occurence.csv"
# caminho_do_arquivo <- "occurence.csv"

# read a dataframe using spark 
df_spark <- spark_read_csv(sc, "occurence_spark", caminho_do_arquivo)

df_spark <- df_spark %>%
  filter(country == "Poland")

# show the head of dataset
head(df_spark)

# save the CSV consider only Poland
caminho_do_arquivo_salvo <- "polandy/"

# Save the dataframe
spark_write_csv(df_spark, path = caminho_do_arquivo_salvo, mode = "overwrite")

# disconect session
spark_disconnect(sc)

# Create only a single CSV file

arquivos_csv <- list.files('polandy/', pattern = "\\.csv$", full.names = TRUE)

df_merged <- read.csv(arquivos_csv[1], h=T, sep = ',')

# loop to build a single CSV file
for (i in 2:length(arquivos_csv)) {
  df_temp <- read.csv(arquivos_csv[i], h=T, sep = ',')
  df_merged <- rbind(df_merged, df_temp)
}

#save the csv data that I use for the build of the bio App
write.csv(df_merged, "arquivo.csv", row.names = FALSE)

