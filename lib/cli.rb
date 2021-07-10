require_relative './scraper.rb'

class Cli < Scraper
            #      1        2               3               4           5            6           7           8           9                   10
    @@tags = ["Canadian", "CertClean", "Chemical Free", "Vegan", "EWG Verified", "Organic", "Non-gmo", "Gluten Free", "Hypoallergenic", "Natural"]
              #     1       2           3       4           5           6           7           8           9       10      11      12          13      14
    @@brands = ["almay", "benefit", "boosh", "clinique", "colourpop", "covergirl", "fenty", "glossier", "iman", "milani", "nyx", "pacifica", "revlon", "nudus"]


def input_to_index(input)
input.to_i - 1
end

def self.tags
    @@tags
end

def self.brands
    @@brands
end

def display_tags
    Cli.tags.each_with_index {|tag, index| puts "#{index+1}. #{tag}" }
end

def display_brands
    Cli.brands.each_with_index {|brand, index| puts "#{index+1}. #{brand.capitalize}" }
end

def start
    puts "Welcome to my program!"
    puts "Please select an option, by it's number, to proceed!"
    index = self.main_menu # SHOWING MAIN MENU
end

def main_menu
    puts "======================MAIN MENU=========================="
    puts "1. Search by lipstick tag (i.e. Allergen-free/Vegan/etc.)" #0
    puts "2. Search by lipstick brand (i.e. Colourpop, Boosh, etc.)"    #1
    puts "3. View all lipsticks on the site!" #2
    puts "4. Where am I? Get me outta here!!"
    input = gets.chomp #get input from user
    index = input_to_index(input) #convert input to index number to access @@tags
        if !index.between?(0,3)
            puts "============================================"
            puts "ERROR: Please enter a number from 1-3, only!"
            puts "============================================"
            self.main_menu
        elsif index == 0
            self.tag_menu
            elsif index == 1
                self.brand_menu
            elsif index == 2
                self.all_lipsticks
            else index == 3
                puts "Goodbye!!!"
                exit
        end
    index
end


def tag_re_prompt
    puts "=========================================="
    puts "How would you like to proceed?"
    puts "1. Back to the Main Menu!"
    puts "2. Ehhh get me outta here..."
    puts "3. Can I see those Tag options again?"
    input = gets.chomp #get input from user
    index = input_to_index(input)

    if !index.between?(0,2)
        puts "============================================"
        puts "ERROR: Please choose a number from 1-3, only!"
        puts "============================================"
    elsif index == 0
        self.main_menu
    elsif index == 1
        puts "Goodbye!!!"
        exit
    else index == 3
        self.tag_menu
    end #if ender
    self.tag_re_prompt
end

def brand_re_prompt
    puts "=========================================="
    puts "How would you like to proceed?"
    puts "1. Back to the Main Menu!"
    puts "2. Ehhh get me outta here..."
    puts "3. Can I see those Brand options again?"
    input = gets.chomp #get input from user
    index = input_to_index(input)

    if !index.between?(0,2)
        puts "============================================"
        puts "ERROR: Please choose a number from 1-3, only!"
        puts "============================================"
    elsif index == 0
        self.main_menu
    elsif index == 1
        puts "Goodbye!!!"
        exit
    else index == 3
        self.brand_menu
    end #if ender
    self.brand_re_prompt
end

def basic_re_prompt
    puts "=========================================="
    puts "How would you like to proceed?"
    puts "1. Back to the main menu!"
    puts "2. Ehhh get me outta here..."
    input = gets.chomp #get input from user
    index = input_to_index(input)

    if !index.between?(0,1)
        puts "============================================"
        puts "ERROR: Please choose either 1 or 2, only!"
        puts "============================================"
    elsif index == 0
        self.main_menu
    else index == 1
        puts "Goodbye!!!"
        exit
    end
    self.basic_re_prompt
end

def long_list_warning
    puts "================================================="
    puts "Are you sure? The whole list is about 125 items..."
    puts "It's reccomended that you refine your search with"
    puts "our Search By Tag/Brand feature!"
    puts "1. Nah, bring on the long list!!"  #0
    puts "2. Alright fine, back to the main menu please..." #  1
    input = gets.chomp #get input from user
    index = input_to_index(input)
        if !index.between?(0,1)
            puts "================================================="
            puts "ERROR: Please enter either 1 or 2, only!"
            puts "================================================="
        elsif index == 0
            self.get_lipstick[26..-1].map do |item|
                # binding.pry
                puts "Brand: #{item[:brand].capitalize}"
                    if item[:price] == "$0.00" 
                        puts "Price: Unlisted"
                    else
                    puts "Price: #{item[:price]}"
                    end
                puts "Description: #{item[:info]}"
                puts "==============================="
                end#map ender
                self.basic_re_prompt
            else index == 1
                self.main_menu
        end #if ender
        
self.long_list_re_prompt
end

def long_list_re_prompt
    puts "================================================="
    puts "How would you like to proceed?"
    puts "1. Back to the main menu!"
    puts "2. Ehhh get me outta here..."
    puts "3. I'd like to see the rest of the list, please!"
    input = gets.chomp #get input from user
    index = input_to_index(input)

    if !index.between?(0,2)
        puts "================================================="
        puts "ERROR: Please enter a number between 1-3, only!"
        puts "================================================="
    elsif index == 0
        self.main_menu
    elsif index == 1
        puts "Goodbye!!!"
        exit
    else index == 2
        self.long_list_warning
        # end#map ender
    end#elsif ender
    
    self.long_list_re_prompt
end#method ender

def all_lipsticks
    puts "Please enjoy the (shortened) list of Brands below! :)"
    puts "======================================================="
    self.get_lipstick[1..25].map do |item|
        # binding.pry
        puts "Brand: #{item[:brand].capitalize}"
            if item[:price] == "$0.00" 
                puts "Price: Unlisted"
            else
            puts "Price: #{item[:price]}"
            end
        puts "Description: #{item[:info]}"
        puts "===================================="
    end

    self.long_list_re_prompt #changed from self.re_prompt
end

def brand_menu
    puts "Please select a number from the list of Brands below! :)"
    self.display_brands
    input = gets.chomp #get input from user
    index = input_to_index(input) #convert input to index number to access @@tags
    brand = Cli.brands[index]
    self.brand_list(brand) #view list of brands
    if !index.between?(0,13) #check for valid input
        puts "============================================"
        puts "ERROR: Please enter a number from 1-14, only!"
        puts "============================================"
        self.brand_menu
    end
self.brand_re_prompt
end

def tag_menu
    puts "Please select a number from the list of Product Tags below! :)"
    self.display_tags #VIEW TAG LIST ---------
        input = gets.chomp #get input from user
        index = input_to_index(input) #convert input to index number to access @@tags
        tag = Cli.tags[index]
        #  self.search_tags(tag)
        self.tag_list(tag)
        # binding.pry
        if !index.between?(0,9)
            puts "============================================"
            puts "ERROR: Please enter a number from 1-10, only!"
            puts "============================================"
            self.tag_menu
        end
    self.tag_re_prompt
end


    
    
end#class ender