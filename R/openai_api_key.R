#' Set OpenAI API Key as an Environment Variable
#'
#' This function sets the OpenAI API key as an environment variable in the
#' current R session. It takes the API key as an input and stores it as an
#' environment variable, allowing other functions to access the key when needed.
#'
#' This function is only a wrapper around the function from TheOpenAIR, see
#' \url{https://github.com/umatter/openair} for more information.
#'
#' @param api_key A character string containing the OpenAI API key.
#'
#' @return Nothing is returned; the function is called for its side effects.


#' @seealso \url{https://beta.openai.com/docs/} for more information on the 
#' OpenAI API.
#'
#' @examples
#' \dontrun{
#' # Set the OpenAI API key for the current R session
#' openai_api_key("your_api_key_here")
#' }
#'
#' @export
openai_api_key <- function(api_key) {
  TheOpenAIR::openai_api_key(api_key)
}