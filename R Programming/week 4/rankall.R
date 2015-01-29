rankall <- function(outcome, num = "best") {
#       Read outcome data
      data <- read.csv("outcome-of-care-measures.csv", colClasse ="character")
      colnames(data)[11] <- "heart attack"
      colnames(data)[17] <- "heart failure"
      colnames(data)[23] <- "pneumonia"
      
#       Check that state and outcome are valid
      outcome_all <- c("heart attack", "heart failure", "pneumonia")
      if(sum(outcome_all == outcome) == 0) stop("invalid outcome")

#       For each state, find the hospital of given rank
      state <- data$State
      hospital <- data$Hospital.Name
      rate <- data[, outcome]
      data <- cbind(hospital, state, rate)
      data <- data.frame(data, stringsAsFactors=FALSE)
      data$rate <- as.numeric(data$rate)
      data <- data[with(data, order(rate, hospital)), ]
      s <- split(data, data$state)
      rank <- lapply(s, function(x) {
            if(num == "best") num <- 1
            if(num == "worst") num <- sum(!is.na(x$rate))
            x[num, c(1,2)]})

#       Return a data frame with the hospital names and the
#       (abbreviated) state name
      do.call(rbind, rank)
}