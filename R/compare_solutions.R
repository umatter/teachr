#' Compare a user's solution to the intended solution
#'
#' This function takes a user's solution and compares it to the intended
#' solution. If the user's solution is incorrect, the function will provide
#' feedback to the user.
#'
#' @param attempt_file A character string that represents the path to the file
#' that contains the user's solution.
#' @param solution_file A character string that represents the path to the file
#' that contains the intended solution.
#' @param ... Additional arguments to pass to TheOpenAIR's chat_completion
#'
#' @return A character string that compares the user's solution to the intended
#' solution and provides feedback to the user.
#'
#' @examples
#' \dontrun{
#' compare_solutions("R_code/exercise_1.R", "solutions/exercise_1.R")
#' }
#'
#' @export
compare_solutions <- function(attempt_file, solution_file, ...) {
  # Load the user's solution and the intended solution
  solution_list <- source(solution_file, local = TRUE)
  attempt_list <- source(attempt_file, local = TRUE)

    # Apply the user's solution to the inputs
  inputs <- solution_list$value$inputs
  out_user <- lapply(inputs, FUN = attempt_list$value$solution)
  out_intended <- solution_list$value$outputs

  # Find where the user made mistakes, provide the inputs and intended outputs
  # to GPT
  mismatch <- mapply(FUN = function(x, y) {x != y}, out_user, out_intended)
  problem_inputs <- inputs[mismatch]
  out_intended <- out_intended[mismatch]
  out_user <- out_user[mismatch]
  if (!any(mismatch)) {
    return("The solution is correct")
  } else {
    # Format strings
    attempt <- paste0(deparse(attempt_list$value$solution), collapse = "\n")
    solution <- paste0(deparse(solution_list$value$solution), collapse = "\n")
    inputs <- paste0(problem_inputs, collapse = "|")
    user_outputs <- paste0(out_user, collapse = "|")
    intended_outputs <- paste0(out_intended, collapse = "|")

    compare_solutions_input$content[2] <- sprintf(
      fmt = compare_solutions_input$content[2], 
      attempt, solution, inputs, user_outputs, intended_outputs)

    # Chat
    resp <- TheOpenAIR::chat_completion(compare_solutions_input, ...)
    total_tokens_used <- TheOpenAIR::usage(resp)$total_tokens
    message("Total tokens used: ", total_tokens_used)

    # Process response
    msg_resp <- TheOpenAIR::messages(resp)
    comparison <- msg_resp$content

    return(comparison)
  }
}
