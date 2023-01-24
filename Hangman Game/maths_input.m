%variables inside squarebrackets are the variables that need to be returned
%when the function is called. On the right side of the = is the name of the
%functions which will be used to call it in the main script. 
function[secret_word word_length] = fruits_input()
        
        %read in file
        words  = fileread("maths.txt");

        %split the txt file into single words
        words = splitlines(words);
        
        %create an empty vector
        words_array = [];

        %for loop to store the word into the above vectors
        for i = 1:length(words)
            words_array = [words_array string(words(i))];
        end

        %chose a random num from 1 to the amount of words in the vector.
        random_num = randi([1 length(words_array)], 1);

        %choose random word from the vector using the random number 
        rand_word = words_array(random_num);

        %convert to characters
        char_word = char(rand_word);

        %assign the character word to secret word
        secret_word = char_word;
        
        %store word length using strlength function to 'word_length'
        word_length = strlength(secret_word);
        
end