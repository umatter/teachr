if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Comparing solutions works", {
        compare_solutions(
            attempt_file = "../../inst/testing/example_attempt.R",
            solution_file = "../../inst/testing/example_solution.R"
        )
    })
} else {
    skip("API key not set, skipping test.")
}