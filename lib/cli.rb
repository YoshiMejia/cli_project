require_relative './scraper.rb'

class Cli < Scraper
    @@tags = ["Canadian", "CertClean", "Chemical Free", "Vegan", "EWG Verified", "Organic", "Non-gmo", "Gluten Free", "Hypoallergenic", "Natural"]
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
    Scraper.new_lipstick
    puts "Welcome to my program!"
    puts "Please select an option, by it's number, to proceed!"
    index = self.main_menu
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
            self.error_message
            self.main_menu
        elsif index == 0
            self.tag_menu
            elsif index == 1
                self.brand_menu
            elsif index == 2
                self.all_lipsticks
            else index == 3
                self.farewell
        end
    index
end

def re_prompt_message(type) 
    puts "=========================================="
    puts "How would you like to proceed?"
    puts "1. Back to the Main Menu!"
    puts "2. Ehhh get me outta here..."
    puts "3. Can I see those #{type} options again?"
end

def tag_re_prompt
    self.re_prompt_message("Tag")
    input = gets.chomp #get input from user
    index = input_to_index(input)
    if !index.between?(0,2)
        self.error_message
    elsif index == 0
        self.main_menu
    elsif index == 1
        self.farewell
    else index == 3
        self.tag_menu
    end #if ender
    self.tag_re_prompt
end

def brand_re_prompt
  
    self.re_prompt_message("Brand")
    input = gets.chomp #get input from user
    index = input_to_index(input)

    if !index.between?(0,2)
        self.error_message
    elsif index == 0
        self.main_menu
    elsif index == 1
        self.farewell
    else index == 3
        self.brand_menu
    end 
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
        self.error_message
    elsif index == 0
        self.main_menu
    else index == 1
        self.farewell
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
            self.error_message
        elsif index == 0
            Lipstick.all.map do |item|
                
                puts "Brand: #{item.brand_name.capitalize}"
                    if item.price == "$0.00" 
                        puts "Price: Unlisted"
                    else
                    puts "Price: #{item.price}"
                    end
                puts "Description: #{item.description}"
                puts "==============================="
                end
                self.basic_re_prompt
            else index == 1
                self.main_menu
        end
        
self.long_list_re_prompt
end

def farewell
    puts "Goodbye!!!"
        Lipstick.reset_all
        exit
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
        self.error_message
    elsif index == 0
        self.main_menu
    elsif index == 1
       self.farewell
    else index == 2
        self.long_list_warning
    end
    
    self.long_list_re_prompt
end#method ender

def all_lipsticks
    puts "Please enjoy the (shortened) list of Brands below! :)"
    puts "======================================================="
    Lipstick.all.map do |item|

        puts "Brand: #{item.brand_name.capitalize}"
            if item.price == "$0.00" 
                puts "Price: Unlisted"
            else
            puts "Price: #{item.price}"
            end
        puts "Description: #{item.description}"
        puts "===================================="
    end

    self.long_list_re_prompt 
end

def brand_menu
    puts "Please select a number from the list of Brands below! :)"
    self.display_brands
    input = gets.chomp 
    index = input_to_index(input)
    brand = Cli.brands[index] 
    brands = Lipstick.search_brand(brand) 
    output_lipsticks(brands) 
    if !index.between?(0,13)
        self.error_message
        self.brand_menu
    end
self.brand_re_prompt
end

def error_message
        puts "======================================================"
        puts "ERROR: Please enter one of the numbers listed below!"
        puts "======================================================"
end

def tag_menu
    puts "Please select a number from the list of Product Tags below! :)"
    self.display_tags 
        input = gets.chomp #get input from user
        index = input_to_index(input) #convert input to index number to access @@tags
        tag = Cli.tags[index]
        self.tag_list(tag)
        if !index.between?(0,9)
            self.error_message
            self.tag_menu
        end
    self.tag_re_prompt
end

def output_lipsticks(lipsticks)
    lipsticks.each do |i| 
    puts "==============================="
        puts "Brand: #{i.brand_name.capitalize}"
            if i.price == "$0.00" 
                puts "Price: Unlisted"
            else
            puts "Price: #{i.price}"
            end
        puts "Description: #{i.description.capitalize}"
        end
    
    end#output ender
    
end#class ender




