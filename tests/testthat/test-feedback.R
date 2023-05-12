r_code <-
"fibo <- function (n) 
{
    if (n <= 1) {
        return(n)
    }
    else if (n <= 3) {
        return(1)
    }
    else {
        return(myfib(n - 1) + myfib(n - 2))
    }
}"

if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Feedback works", {
        result <- feedback(
            r_code,
            "Write a function to compute the nth Fibonacci number."
        )
        expect_type(result, "list")
        expect_true(all(names(result) == c("lines", "feedback")))
    })
} else {
    skip("API key not set, skipping test.")
}
