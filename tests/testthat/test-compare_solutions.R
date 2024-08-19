if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Comparing solutions works", {
        result <- compare_solutions(
            attempt_file = "../../inst/testing/example_attempt.R",
            solution_file = "../example_solution.R"  # Updated path
        )
        expect_type(result, "character")
    })
} else {
    skip("API key not set, skipping test.")
}
