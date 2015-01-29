best <- function(state, outcome) {
      
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
      
#       Return hospital name in that state with lowest 30-day death rate
      ds <- data$State == state
      hospital <- data[ds, "Hospital.Name"]
      rate <- as.numeric(data[ds, outcome])
      na <- !is.na(rate)
      min <- rate[na] == min(rate[na])
      hos_name <- hospital[na][min]
      sort(hos_name)[1]
}