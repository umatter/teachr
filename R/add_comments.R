#' Add comments to code
#'
#' This function takes a code as input and uses TheOpenAIR's chat_completion
#' function to generate comments for the code.
#'
#' @param code A character string that represents the code that the user wants
#' to comment.
#' @param ... Additional arguments to pass to TheOpenAIR's chat_completion
#'
#' @return A character string that represents the commented code.
#'
#' @examples
#' \dontrun{
#' add_comments("for(i in 1:100)
#' { if(i %% 3 == 0 && i %% 5 == 0) { print('FizzBuzz') } else if(i %% 3 == 0)
#' { print('Fizz') } else if(i %% 5 == 0)
#' { print('Buzz') } else { print(i) } }")
#' }
#' @export
add_comments <- function(code, ...) {

  requireNamespace("dplyr", quietly = TRUE)

  # Initial user input
  add_comments_input$content[2] <-
    sprintf(fmt = add_comments_input$content[2], code)

  # Chat
  resp <- TheOpenAIR::chat_completion(add_comments_input, ...)
  total_tokens_used <- TheOpenAIR::usage(resp)$total_tokens
  message("Total tokens used: ", total_tokens_used)

  # Process response
  msg_resp <- TheOpenAIR::messages(resp)
  comments <- msg_resp$content

  return(comments)
}
