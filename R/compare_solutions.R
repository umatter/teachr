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
#'
#' @return NULL
#'
#' @examples
#' compare_solutions("R/solutions/solution_1.R", "R/solutions/solution_1.R")
#'
#' @export
compare_solutions <- function(attempt_file, solution_file) {
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
        message("The solution is correct!")
        return(NULL)
    } else {
        # TODO: Is there a possibility to mapply this? Do we even want to?
        # Error in dots[[1L]][[1L]] : object of type 'closure' is not
        # subsettable

        # Format strings
        attempt <- paste0(deparse(attempt_list$value$solution),
            collapse = "\n")
        solution <- paste0(deparse(solution_list$value$solution),
            collapse = "\n")
        inputs <- paste0(problem_inputs, collapse = "|")
        user_outputs <- paste0(out_user, collapse = "|")
        intended_outputs <- paste0(out_intended, collapse = "|")

        compare_solutions_input$content[2] <- sprintf(
            fmt = compare_solutions_input$content[2],
            attempt, solution, inputs, user_outputs, intended_outputs)

        # Chat
        resp <- OpenAIR::chat_completion(compare_solutions_input)
        total_tokens_used <- OpenAIR::usage(resp)$total_tokens
        message("Total tokens used: ", total_tokens_used)

        # Process response
        msg_resp <- OpenAIR::messages(resp)
        comparison <- msg_resp$content

        message(comparison)
        return(NULL)
    }
}