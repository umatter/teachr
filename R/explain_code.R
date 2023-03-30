#' Explain Code using OpenAI's chat_completion function
#'
#' This function takes a code as input and uses OpenAIR's chat_completion
#' function to generate an explanation for the code.
#'
#' @param code A character string that represents the code that the user wants
#' to explain.
#' @param ... Additional arguments to pass to OpenAIR's chat_completion
#'
#' @return NULL
#'
#' @examples
#' explain_code("for(i in 1:10) { print(i) }")
#'
#' @export
explain_code <- function(code, ...) {

  explanation <-
    lapply(code, FUN = function(code) {

      # Initial user input
      explain_code_input$content[2] <-
        sprintf(fmt = explain_code_input$content[2], code)

      # Chat
      resp <- OpenAIR::chat_completion(explain_code_input, ...)
      total_tokens_used <- OpenAIR::usage(resp)$total_tokens
      message("Total tokens used: ", total_tokens_used)

      # Process response
      msg_resp <- OpenAIR::messages(resp)
      explanation <- msg_resp$content

      return(explanation)
    })

  # Output the message and return NULL
  message(explanation)
  return(NULL)
}
