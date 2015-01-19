pollutantmean <- function(directory, pollutant, id = 1:332) {
        files_list <- list.files(directory, full.names = TRUE)[id]
        data <- data.frame()
        for(i in seq_along(id)) {
                data <- rbind(data, read.csv(files_list[i]))
        }
        mean(data[, pollutant], na.rm = TRUE)
}