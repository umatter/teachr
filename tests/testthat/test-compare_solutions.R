if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Comparing solutions works", {
        result <- compare_solutions(
            attempt_file = system.file("inst/testing/example_attempt.R", package = "your_package_name"),
            solution_file = system.file("inst/testing/example_solution.R", package = "your_package_name")  
        )
        expect_type(result, "character")
    })
} else {
    skip("API key not set, skipping test.")
}
