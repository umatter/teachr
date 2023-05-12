library(expm)

# Solution to Fibonacci sequence
fib_matrix <- function(n) {
    A <- matrix(c(1, 1, 1, 0), nrow = 2, ncol = 2)
    return((A %^% n)[2])
}

inputs <- as.list(c(1:10, 15, 20, 25, 30))
outputs <- lapply(inputs, FUN = fib_matrix)

# Store all information into a list for ease of access when sourcing the file
list(
    solution = fib_matrix,
    inputs = inputs,
    outputs = outputs
)