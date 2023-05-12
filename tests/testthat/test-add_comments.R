if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Adding comments works", {
        result <- add_comments(
"for(i in 1:100) { 
    if(i %% 3 == 0 && i %% 5 == 0) { 
        print('FizzBuzz') 
    } else if(i %% 3 == 0) { 
        print('Fizz') 
    } else if(i %% 5 == 0) { 
        print('Buzz') 
    } else { 
        print(i) 
    } 
}")
    expect_type(result, "character")
    })
} else {
    skip("API key not set, skipping test.")
}