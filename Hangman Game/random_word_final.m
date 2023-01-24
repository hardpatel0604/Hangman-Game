%this section of code is the final improved and final version of the
%previous code. Previously the same chunk of 20 lines of code was repeated
%for each possible category with only one line different which was the line
%where the .txt file was called in, because the the name of txt file will
%be different for each category. 

%therefore a function was created for each category where the previous
%chunk of code was copied into so that the main scipt noe only had 1 line
%of code which calls the function rather than 20 lines. 



fprintf('\nPlease choose the category you would like the computer to choose a word from\n')

category_choice = input('\ntype "1" for sports, "2" for fruits, "3" for maths. ' );

while 1

    if category_choice == 1

        [word_length] = sports_input();
        
        break
    
    elseif category_choice == 2

        [word_length] = fruits_input();

        break
     
    elseif category_choice == 3

        [word_length] = maths_input();

        break

    end
end 