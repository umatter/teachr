devtools::load_all()
my_key <- "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"
OpenAIR::openai_api_key(my_key)


solution_file <- rep("example_solution.R", 2)
attempt_file <- rep("example_attempt.R", 2)

compare_solutions(attempt_file, solution_file)





chat("Return a single random word to this prompt.")


code <- "
  fib <- function(n) {
    a <- 0
    b <- 1
    for(i in 1:n) {
      c <- a + b
      a <- b
      b <- c
    }
    return(c)
  }
"

code2 <- "for(i in 1:10) { print(i) }"

n <- 5
a <- 0
b <- 1
for(i in 1:n) {
  c <- a + b
  a <- b
  b <- c
}


task <- "Write a function to compute the nth Fibonacci number."


f <- feedback(example_r_code, task)
cat(f)


feedback_input$content[2] <- sprintf(fmt = feedback_input$content[2], task, example_r_code)

cat(feedback_input$content[2])
# z <- chat_completion(feedback_input)




# ------------------------------------------------------------------------------

# Make RDA files

# feedback
# -----
feedback_input <- data.frame(
  role = c("system", "user"),
  content = c(
    "You provide feedback to an undergraduate student learning about programming on how to improve in the following R code.",

"Provide feedback on how to improve in the R code below. 
The task the user is trying to accomplish is: '%s'
              
The user's code is: 
%s
              
Return your feedback in a CSV-file format with the two columns: line numbers with format [beginning-ending], feedback.
Thereby please place each CSV cell value in double quotes in order to make sure that the CSV can be parsed properly. 
Leave the line numbers empty if the feedback applies to the code in general and not to a specific part.")
)

save(feedback_input, file="data/feedback_input.rda")

# explain_code
# -----
explain_code_input <- data.frame(
  role = c("system", "user"),
  content = c(
    "You are a teaching assistant for an undergraduate programming class.", 
"Explain what the R code below does. Your target audience is undergraduate students from an introductory programming class.

%s."
  )
)

save(explain_code_input, file="data/explain_code_input.rda")

# compare_solutiions
 # -----

compare_solutions_input <- data.frame(
    role = c("system", "user"),
    content = c(
        "You compare the attempt of an undergraduate student at an R exercise with its true solution and provide feedback to the user.",

"The user's attempt at the R exercise is: 
%s

The intended solution is: 
%s

The user got the following test cases wrong:
%s

The user's output were:
%s

The intended output were:
%s

Provide feedback on what went wrong in the user's attempt. Be aware that there may be different way to solve the intended exercise.")
)

save(compare_solutions_input, file="data/compare_solutions_input.rda")

# add_comments
# -----

add_comments_input <- data.frame(
    role = c("system", "user"),
    content = c(
        "You are an AI assistant for an undergraduate introduction to programming course.",
"Add comments to better explain the R code below and return the full output. Return only the code with its comments, do not add anything else around it.

%s"))

save(add_comments_input, file="data/add_comments_input.rda")


# ------------------------------------------------------------------------------



