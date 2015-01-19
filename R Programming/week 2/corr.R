corr <- function(directory, threshold = 0) {
      corr_out <- c()
      files_list <- list.files(directory, full.names = TRUE)
      id <- seq_along(files_list)
      comp_all <- complete(directory, id)
      for(i in id) {
            if (comp_all[i, "nobs"] > threshold) {
                  data <- data.frame()
                  data <- read.csv(files_list[i])
                  c1 <- data[,"sulfate"]
                  c2 <- data[,"nitrate"]
                  cl <- !is.na(c1) & !is.na(c2)
                  corr_out[i] <- cor(c1[cl], c2[cl])
            }
      }
      corr_out[!is.na(corr_out)]
}