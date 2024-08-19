if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Comparing solutions works", {
        result <- compare_solutions(
            attempt_file = system.file("example_attempt.R", package = "teachr"),
            solution_file = system.file("example_solution.R", package = "teachr")  
        )
        expect_type(result, "character")
    })
} else {
    skip("API key not set, skipping test.")
}
