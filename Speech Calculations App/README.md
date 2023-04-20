# Description of the App
I've made a Speech Calculations App that calculates speech rate, number of syllables and mean length of utterance.The speech rate calculator uses the formula number of words/duration of speech (mins)  to calculate the speech rate. 

The syllable counter uses the stringr package to identify syllables. It does this by defining a syllable as any string that begins with one or more vowels or y, followed by zero or more characters that are not vowels or y, and ends with zero or more characters that are vowels or y.

The mean length of utterance (MLU) calculator splits the text into individual utterances using strsplit, and registers each new line as a new utterance. Each utterance is then split into morphemes using either a whitespace or a period. The number of morphemes is then calculated. The unlist function is used to take the morphemes out of the list they were put in by the lapply function. The unlisted elements are then added together using sum() to get the total number of morphemes. The total number of utteracnces is found using length(). MLU is then calculated by dividing the number of morphemes by the number of utterances.

# How to use
1. Open the Shiny app file and, click "Run App" in the upper right corner. 
2. The Shiny App will automatically launch.
3. You can now use the app!
