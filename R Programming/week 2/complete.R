complete <- function(directory, id = 1:332) {
        files_list <- list.files(directory, full.names = TRUE)[id]
        data <- data.frame()
        data_out <- data.frame()
        for(i in seq_along(id)) {
                data <- read.csv(files_list[i])
                c1 <- !is.na(data[,"sulfate"])
                c2 <- !is.na(data[,"nitrate"])
                data_out[i, "id"] <- id[i]
                data_out[i, "nobs"] <- sum(c1 & c2)
        }
        data_out
}