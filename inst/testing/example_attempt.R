myfib <- function(n) {
    if (n == 0) {
        return(0)
    } else if (n <= 3) {
        return(1)
    } else {
        return(myfib(n - 1) + myfib(n - 2))
    }
}


list(
    solution = myfib
)
