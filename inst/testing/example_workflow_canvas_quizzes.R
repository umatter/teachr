

#

# SET UP  --------------------------------

#library(teachr)
library(exams) 
library(dplyr)
library(stringr)
library(readxl)
library(knitr)

# fix vars
N_Q <- 15
QUESTIONS_PATH <- "/home/umatter/Dropbox/Teaching/HSG/datahandling/datahandling-examination/data/questions_db.xlsx" # these are manually prepared questions for prompts
RMD_SCRIPT <- "~/Dropbox/tools/Exam_Test/rmd_computation.R" # script by A. Sallin
QUESTIONS_OUTPUT <- "/home/umatter/Dropbox/Teaching/HSG/datahandling/datahandling-examination/rep_exam1/exam_files_22/Questions"
OUTPUT_CSV <- "/home/umatter/Dropbox/Teaching/HSG/datahandling/datahandling-examination/rep_exam1/exam_files_22/questions.csv"
EXAM_NAME <- "Data Handling 2022: Alternative Examination Date"
N_BATCHES <- 5
N_INPUT <- 5

iterations <- list()
length(iterations) <- N_INPUT

for (i in 1:N_INPUT){
  # pre-selection
  questions <- readxl::read_excel(QUESTIONS_PATH)
  questions_selected <- questions[sample(1:nrow(questions), N_Q),1:4]
  
  # create questions
  new_questions_list <- lapply(1:N_BATCHES, generate_questions, sample_questions=questions_selected, n_questions=N_Q)
  new_questions_cleaned <- 
    lapply(new_questions_list, FUN = function(x){
      if (4<ncol(x)) x <- x[,1:4]
      names(x) <- c("type", "question", "choices", "solution")
      x <- x[x$type %in% c("mc", "one_correct", "tf"),]
      x <- x[!(x$type=="tf" & !is.na(x$choices)),]
      if (ncol(x)!=4){
        x <- data.frame()
      }
      return(x)
    })
  iterations[[i]]  <- data.table::rbindlist(new_questions_cleaned)
  
}
all_new_questions <- data.table::rbindlist(iterations)

# Verify manually
# View(all_new_questions)
questions_exam <- all_new_questions
questions_exam$choices[is.na(questions_exam$choices)] <- ""
questions_exam$solution["FALSE"==questions_exam$solution] <- "F"
questions_exam$solution["TRUE"==questions_exam$solution] <- "T"
questions_exam <- questions_exam[!is.na(questions_exam$solution)]
questions_exam <- questions_exam[sample(1:nrow(questions_exam),
                                        100, replace = FALSE)]
questions_exam <- questions_exam[order(questions_exam$type, decreasing = TRUE),]
write.csv(questions_exam, OUTPUT_CSV) # manually check, edit, improve!!!


# With knitr::spin and .Rmd, create questions ------------------------------

questions_exam <- readxl::read_excel("/home/umatter/Dropbox/Teaching/HSG/datahandling/datahandling-examination/rep_exam1/exam_files_22/questions_revised_rep_exam22.xlsx")
#' Loop through the questions and create a .Rmd file for each question

for (i in 1:nrow(questions_exam)){
  question <- questions_exam[i,]
  
  print(question$question)
  
  question_type <- if(question$type == "mc"){"mchoice"
  } else if(question$type == "one_correct") {"schoice"
  } else if(question$type == "tf") {"schoice"
  } else if (question$type == "essay") {"essay"}
  
  if(question$type == "one_correct"){
    choices <- unlist(str_split(question$choices, ";"))
    choices <- ifelse(choices == question$solution, "T", "F")
    question$solution <- paste(choices, collapse = ";")
    
    if(length(unique(choices)) == 1){warning("Error with question ", i, ". Revise.")}
  }
  
  if(question$type == "tf"){
    question$choices <- "T;F"
    question$solution <- ifelse(question$solution == "T", "T;F", "F;T")
  }
  
  knitr::spin(RMD_SCRIPT)
  
  file.rename(from = file.path("rmd_computation.md"),
              to = file.path(paste0(QUESTIONS_OUTPUT, "/question", i, ".Rmd")))
  
}

# # to remove problematic cases 
# problem_cases <- unlist(str_extract_all(names(warnings()), "question [0-9]+"))
# problem_paths <- paste0(QUESTIONS_OUTPUT, "/", problem_cases, ".Rmd")
# lapply(problem_paths, unlink) 


# Compile exam ------------------------------------------------------------

# Define exam questions (each item in list is a pool)
myexam <- list.files(paste0(QUESTIONS_OUTPUT), pattern = ".Rmd")

# Render exam
exams2html(myexam, 
           edir = QUESTIONS_OUTPUT)

# Generate the test for canvas
#QuizName is the name of the quiz. You can change it to whatever you want.                       
#maxattempts is self-explanatory. Edit it at will.
exams2canvas(myexam,
             name = EXAM_NAME, 
             dir = QUESTIONS_OUTPUT,
             edir = QUESTIONS_OUTPUT,
             maxattempts = 1)

# # to remove problematic cases 
# problem_cases <- unlist(str_extract_all(names(warnings()), "question[0-9]+"))
# problem_paths <- paste0(QUESTIONS_OUTPUT, "/", problem_cases, ".Rmd")
# lapply(problem_paths, unlink) 
# 

