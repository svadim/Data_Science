
# vers. 1 (45s) ---------------------------------------------------------------

pollutantmean <- function(directory, pollutant, id = 1:332) {
        files_list <- list.files(directory, full.names = TRUE)[id]
        data <- data.frame()
        for(i in seq_along(id)) {
                data <- rbind(data, read.csv(files_list[i]))
        }
        mean(data[, pollutant], na.rm = TRUE)
}

# vers. 2 (6s) ----------------------------------------------------------------

pollutantmean <- function(path, pollutant, id){
      flist <- list.files(path, full.names=TRUE)[id]
      data <- do.call(rbind, lapply(flist, read.csv))
      mean(data[, pollutant], na.rm = TRUE)
}

# vers. 3 (61s и комп завис) --------------------------------------------------

pollutantmean <- function(path, pollutant, id){
      flist <- list.files(path, full.names=TRUE)[id]
      data <- data.frame()
      lapply(flist, function(x)
            data <<- rbind(data, read.csv(x)))
      mean(data[, pollutant], na.rm = TRUE)
}