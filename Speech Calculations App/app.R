library(shiny)
library(stringr)

ui <- fluidPage(
  titlePanel("Speech Calculations App"),
  
  tabsetPanel(  #tab 1
    tabPanel(
      p("Speech Rate Calculator"),
      numericInput("numwords", "Enter the number of words", value = 0),
      numericInput("duration", "Enter the duration of speech (in minutes)", value = 0),
      textOutput("speech_rate")
      
    ),
    tabPanel(  #tab 2
      p("Syllable Counter"),
      textInput("word", "Enter word here"),
      actionButton('count', "Count Syllables"),
      textOutput("syllables")
    ),
    tabPanel(  #tab 3
      p("Mean Length of Utterance Calculator"),
      helpText("This Mean Length of Utterance Calculator divides the total number of morphemes by the number of utterances. To use this app, input 100 utterances, with one utterance per line and each morpheme within a word separated by a dot. A morpheme is the smallest indivisible unit of language that has meaning. For example -ing, -ed, and im-. An example of the proper formatting for using the app is: I am runn.ing"),
      textAreaInput("text", "Utterances:", height = "400px"),
      verbatimTextOutput("result")
    )
    
  )
)

server <- function(input, output, session) {
  
  speech_rate_calc <- reactive({
    input$numwords / input$duration
  })
  
  output$speech_rate <- renderText({
    paste("Your speech rate is", speech_rate_calc(), "words per minute.")
  })
  
  observeEvent(input$count, {
    word <- input$word
    n_syllables <- str_count(word, "[AEIOUYaeiouy]+[AEIOUYaeiouy^]*[AEIOUYaeiouy]*") #identifies syllables as strings with one or more vowels or y, followed by zero or more characters that are not vowels or y, and ends with zero or more characters that are vowels or y
    output$syllables <- renderText(paste0("The word '", word, "' has ", n_syllables, " syllables."))
  })
  
  {
    output$result <- renderPrint({
      input_text <- input$text
      utterances <- strsplit(input_text, "\n")[[1]] #identifies utterances based on new lines
      morphemes <- lapply(strsplit(utterances, "\\.|\\s", ), length) #identifies morphemes based on periods and whitespaces
      total_morphemes <- sum(unlist(morphemes)) #the unlisted elements are then added together using sum() to get the total number of morphemes
      total_utterances <- length(utterances)
      mean_length <- total_morphemes / total_utterances
      paste0("Mean length of utterance (in morphemes): ", round(mean_length, 2))
    })
  }
}

shinyApp(ui, server)

