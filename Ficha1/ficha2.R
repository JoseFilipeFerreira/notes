proba <- c(0.1, 0.1, 0.1, 0.1, 0.2, 0.4)
freqesp <- 100*proba
lanc <- sample(1:6, 100, replace=T, prob=proba)
freqobs <- as.vector(table(lanc))
plot(table(lanc))
plot(1:6, freqobs, type="h")