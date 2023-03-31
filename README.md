
# teachr <img src="man/figures/logo.png" align="right" height="138" />

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of **teachr** is to provide a comprehensive and interactive learning experience for students who are learning to code, by leveraging the power of [OpenAI API](https://github.com/umatter/openair) to generate explanations, and personalized feedback. **teachr** aims to empower learners by offering tailored learning paths, real-time code assessments, and clear, step-by-step guidance in understanding complex code snippets. By fostering an interactive, dynamic, and engaging learning environment, **teachr** aims to accelerate learning and development for students, equipping them with the confidence, knowledge, and skills they need to become proficient coders.

## Installation

You can install the development version of **teachr** from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("umatter/teachr")
```

## Usage

To use the package, you'll need to have an OpenAI API key. You can sign up for an API key [here](https://beta.openai.com/signup/). Once you have your API key, you can start using *teachr*:

``` r
# Load the package
library("teachr")

# Register your api key
openai_api_key("YOUR-API-KEY"")
```

Then, you can start interacting with the API:

``` r
# Explain a snippet of code
explain_code("A %*% B")
```

``` 
In R, the `%*%` operator is used for matrix multiplication. The code `A %*% B` performs matrix multiplication between two matrices A and B, and it returns the resulting product. The matrices should be compatible for matrix multiplication, meaning the number of columns in the first matrix (A) should match the number of rows in the second matrix (B).

For a deeper understanding, let's look at an example:

Suppose we have two matrices A and B:

A = [ 1  2 ]
    [ 3  4 ]
    
B = [ 5  6 ] 
    [ 7  8 ]
    
The R code `A %*% B` will perform matrix multiplication like this:

[ (1*5) + (2*7)  (1*6) + (2*8) ]
[ (3*5) + (4*7)  (3*6) + (4*8) ]

After the operations, the resulting product will be:

[ 19  22 ]
[ 43  50 ]

It's important to note that matrix multiplication is NOT element-wise multiplication. It follows the rules of linear algebra, as demonstrated in the example."
```

``` r
# Provide feedback on a snippet of code that you have written
feedback(
    task="Create a list of powers of 2", # The task you are aiming to solve
    code="x <- c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024)" # Your code
)
```


| lines | feedback |
|--:|:--|
| NA    | "A more efficient way to generate the powers of 2 would be to use vectorized operations and the '2^n' formula." |
| 1     | "Use the ':' operator to form a sequence of powers and then apply the power operation to generate the corresponding powers of 2." |