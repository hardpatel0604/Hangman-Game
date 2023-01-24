% displays a welcome message
fprintf("Welcome to Hangman\n")


%lines 6-12 just reads in all the images that are required later on in the
%code. they also store the images to variable name so that variable can be
%called later when displaying an image.
starting = imread('start.png');
game_win = imread('game_winner.png');
game_lost = imread('loser.jpeg');
incorrect_1 = imread('lives5.png') ;
incorrect_2 = imread('lives4.png') ;
incorrect_3 = imread('lives3.png') ;
incorrect_4 = imread('lives2.png') ;
incorrect_5 = imread('lives1.png') ;
incorrect_6 = imread('game_over.png') ;

%used from
%https://au.mathworks.com/matlabcentral/answers/341021-how-to-play-and-stop-audio-file.
%simply reads in audio file. player is the variable where audiofile is
%stored so that it can be played later on. 
[y, Fs] = audioread('losing_sound.mp3');
loser = audioplayer(y, Fs);

[y, Fs] = audioread('winning_sound.mp3');
winner = audioplayer(y, Fs);


%set a while loop which will run forever since 'while 1' means while true
%so it will run forever unless a break statement is used. 
while 1

    %ask for players input. Ask if they no how to play game.
    ask_players = input('\nDo you know how to play the game?\n \nType yes if you do or no if you dont. ','s');

    %compares the players input to 'yes' and makes both equal. if players
    %input is equal to 'yes' it prints message and breaks out of while
    %loop. strcmpi was used instead of strcmp to make the input case
    %insensetive
    if strcmpi(ask_players, 'yes')
        fprintf("\nGood luck.")
        break
    
    %compares the players input to 'no' and makes both equal. if players
    %input is equal to 'no' it prints message and breaks out of while
    %loop. strcmpi was used instead of strcmp to make the input case
    %insensetive
    elseif strcmpi(ask_players, 'no')
        
        %if above condition is satisfied, the following messages will be
        %displayed
        fprintf("\nHello, the computer will pick a random word from the category you choose.\n");
        fprintf("you will have 6 incorrect guesses to guess the random word. The computer will show\n");
        fprintf("the number of letters in the word and also the letters you have guessed. Good luck!\n");
        
        %this message wil be displayed before the pause so that they know
        %the code is paused. 
        fprintf('\npress enter to continue\n')
        
        %this will pause the code indefinately until they press a key.
        pause()
        break

    else

        %if user types anything else the while loop is repeated.
        fprintf('\nplease type yes or no only\n')
    end

end

%the following message is displayed
fprintf('\nPlease choose the category you would like the computer to choose a word from\n')

%ask for user input.
category_choice = input('\ntype "1" for sports, "2" for fruits, "3" for maths. ' );

%as mentioned before a while loop is set to run forever unless broken
while 1

    %if statement for users input.  this will run the following code if the
    %users input is 1
    if category_choice == 1

        %if the above condition is satisfied, the function 'sports_input'
        %will be called, with the variables 'secret_word' and 'word_length'
        [secret_word word_length] = sports_input();
        
        break
    
    %elseif statement for users input.  this will run the following code if the
    %users input is 2
    elseif category_choice == 2
        
        %if the above condition is satisfied, the function 'fruits_input'
        %will be called, with the variables 'secret_word' and 'word_length'
        [secret_word word_length] = fruits_input();

        break

    %elseif statement for users input.  this will run the following code if the
    %users input is 3 
    elseif category_choice == 3
        
        %if the above condition is satisfied, the function 'maths_input'
        %will be called, with the variables 'secret_word' and 'word_length'
        [secret_word word_length] = maths_input();

        break

    end 
end 

%lines 110-116 initialises all the variable that will be used after or
%updated after in the following lines of code. 
unknown_dashes = [];

num_lives = 6;

guesses_correct = 0;

guesses_wrong = 0;

%show the starting image. 'WinOnTop' is a function taken from matlab file
%exchange:
%https://au.mathworks.com/matlabcentral/fileexchange/42252-winontop . it
%makes sure that the figure window in alway on top so that when user click
%on command box the image is still on the screen. 
imshow(starting); WinOnTop()

%display the amount of letters in the word. 
fprintf('\nThere are %d letters in the word.\n',word_length)

%for loop will update the vector 'unknown_dashes' to add '-' for each
%letter of the secret word.
for i = 1:word_length
    unknown_dashes = [unknown_dashes '-'];
end

%display the vector unknown_dashes 
fprintf('\n%s', unknown_dashes)

while 1
    % ask user to guess a letter
    letter_guess = input('\n\nplease guess a letter: ', 's');

    %store users guess in guessed letters
    guessed_letters = letter_guess;

    %check if the users guess is in the secret word
    check_guess = strfind(secret_word,letter_guess);
    
    %check how many times the users guess is in the secret word. 
    length_correct = length(check_guess);
    
    % add number of correct guesses for every correct input
    guesses_correct = guesses_correct + length_correct;
    
    
    % check whether there is at least one correct letter guessed
    if length_correct >= 1

        for i = 1:length_correct
            
            % if word is not yet guessed but a letter is correctly guessed
            if guesses_correct ~= word_length

                %display the following message
                fprintf('You guessed the correct Letter!\n');
            
            %if above condition is not satisfied then the user has guessed
            %the word
            elseif guesses_correct == word_length

                %display the following message 
                fprintf('CONGRATULATIONS YOU WIN! The word was %s.\n', secret_word)
                
                %display the winning image
                imshow(game_win)
                
                %play winning audio 
                play(winner)

                %update the dashes 
                unknown_dashes(check_guess(i))=letter_guess;
                
                %display the dashes
                fprintf('%s\n',unknown_dashes)
                
                %if user wins the whole code will stop. 
                return;
            end
            
            % update unknown_dashes vector to user input
            unknown_dashes(check_guess(i))=letter_guess;
            fprintf('%s\n',unknown_dashes)
        end
        
    else  

        % add 1 to guesses_wrong every time users guesses worng letter.
        guesses_wrong = guesses_wrong + 1;

        %lines 194-215 displays images that were loaded in at the very
        %begining depending on how many wrong guesses the user has made. 
        if guesses_wrong == 1
            imshow(incorrect_1);
        end

        if guesses_wrong == 2
            imshow(incorrect_2);
        end

        if guesses_wrong == 3
            imshow(incorrect_3);
        end

        if guesses_wrong == 4
            imshow(incorrect_4);
        end

        if guesses_wrong == 5
            imshow(incorrect_5);
        end

        if guesses_wrong == 6
            imshow(incorrect_6);
        end
    
        %if wrong guesses in not equal to 6 then the following code will
        %work.
        if guesses_wrong ~= 6
                
                %display following message 
                fprintf('\nYou guessed the incorrect letter.\n');
                
                %minus one life
                num_lives = num_lives - 1;

                %display the lives
                fprintf('You have %d lives remaining.\n', num_lives);
                
                %display the last letter the user guessed 
                fprintf('the last letter you guessed was %s\n',guessed_letters);
            
        % if they have no lives remaining 
        else

            %display the dashes
            fprintf('%s\n',unknown_dashes);

            %display losing message and the secret word 
            fprintf('You lose! The word was %s.\n', secret_word)
            
            %display losing image
            imshow(game_lost)
            
            %play the losing audio file that was loaded before. 
            play(loser)

            break     
     
        end       
    end
end
