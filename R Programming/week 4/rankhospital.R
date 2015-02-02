rankhospital <- function(state, outcome, num = "best") {
      
#       Read outcome data
      data <- read.csv("outcome-of-care-measures.csv", colClasse ="character")
      colnames(data)[11] <- "heart attack"
      colnames(data)[17] <- "heart failure"
      colnames(data)[23] <- "pneumonia"
      
#       Check that state and outcome are valid
      state_all <- unique(data$State)
      outcome_all <- c("heart attack", "heart failure", "pneumonia")
      if(sum(state_all == state) == 0) stop("invalid state")
      if(sum(outcome_all == outcome) == 0) stop("invalid outcome")
      
#       Return hospital name in that state with given rank
#       30-day death rate
      ds <- data$State == state
      hospitals <- data[ds, "Hospital.Name"]
      rate <- as.numeric(data[ds, outcome])
      hos_rate <- cbind(hospitals, rate)
      if(num == "best") num <- 1
      if(num == "worst") num <- sum(!is.na(rate))
      hos_rate[order(rate, hospitals), ][num]
}

rankhospital2 <- function(state, outcome, num = "best") {
      
      #       Read outcome data
      data <- read.csv("outcome-of-care-measures.csv", colClasse ="character")
      colnames(data)[11] <- "heart attack"
      colnames(data)[17] <- "heart failure"
      colnames(data)[23] <- "pneumonia"
      
      #       Check that state and outcome are valid
      state_all <- unique(data$State)
      outcome_all <- c("heart attack", "heart failure", "pneumonia")
      if(sum(state_all == state) == 0) stop("invalid state")
      if(sum(outcome_all == outcome) == 0) stop("invalid outcome")
      
      #       Return hospital name in that state with given rank
      #       30-day death rate
      s <- split(data, data$State)
      rank <- lapply(s, function(x) {
            rate <- as.numeric(x[, outcome])
            x <- x[with(x, order(rate, Hospital.Name)), ]
            if(num == "best") num <- 1
            if(num == "worst") num <- sum(!is.na(rate))
            x[num, "Hospital.Name"]
      })
      do.call(rbind, rank)
}