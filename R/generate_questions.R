#' Generate Questions Function
#'
#' This function generates a specified number of questions based on provided sample questions. 
#' The questions are generated using OpenAI's GPT model. This function can also accept a text file as input for the sample questions.
#'
#' @param sample_questions Character string or path to text file. Sample questions or path to a text file containing the sample questions.
#' @param n_questions Numeric. The number of questions to generate.
#' @param additional_instructions Character string. Additional instructions to guide the question generation. Default is an empty string.
#' 
#' @details The function begins by checking if the `sample_questions` parameter is a path to an existing file. If so, it reads the lines from the file, otherwise, it assumes that `sample_questions` is a string of sample questions.
#' The function then processes the user input to create an appropriate input for the OpenAI chat model. After the chat process, it calculates and displays the total number of tokens used in the generation process.
#' Lastly, it processes the response from the chat model to extract the generated questions, which it then returns.
#'
#' @return A data frame containing the generated questions.
#'
#' @examples
#' \dontrun{
#' generate_questions("What is R?", 5, "Make the questions intermediate level.")
#' }
#' 
#' @seealso \url{https://openai.com/research/openai-chatgpt/}
#' 
#' @export
generate_questions <- 
  function(sample_questions, n_questions, additional_instructions="", ...) {
    
    # verify user input
    if (is.data.frame(sample_questions)){
      tmp_file_path <- tempfile()
      readr::write_csv(sample_questions, file = tmp_file_path)
      sample_q <- paste(readLines(tmp_file_path), collapse = "\n")
    } else {
      if (file.exists(sample_questions)){
        sample_q <- paste(readLines(sample_questions), collapse = "\n")
      } else {
        sample_q <- sample_questions
      }
      
    }

    # Process initial user input
    generate_questions_input$content[2] <-
      sprintf(fmt = generate_questions_input$content[2], sample_q, n_questions, additional_instructions)
    
    # Chat
    resp <- TheOpenAIR::chat_completion(generate_questions_input, ...)
    total_tokens_used <- TheOpenAIR::usage(resp)$total_tokens
    message("Total tokens used: ", total_tokens_used)
    
    # Process response
    msg_resp <- TheOpenAIR::messages(resp)
    generated_q <- readr::read_csv(msg_resp$content)
    
    return(generated_q)
    
  }
