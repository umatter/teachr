if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Feedback works", {
        result <- explain_code("for(i in 1:10) { print(i) }")
        expect_type(result, "character")
    })
} else {
    skip("API key not set, skipping test.")
}