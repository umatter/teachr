# Solution to Fibonacci sequence
fib_solution <- function(n) {
    if (n == 0) {
        return(0)
    } else if (n <= 2) {
        return(1)
    } else {
        return(fib_solution(n - 1) + fib_solution(n - 2))
    }
}
inputs <- as.list(c(1:10, 15, 20, 25, 30))
outputs <- lapply(inputs, FUN = fib_solution)

# Store all information into a list for ease of access when sourcing the file
list(
    solution = fib_solution,
    inputs = inputs,
    outputs = outputs
)