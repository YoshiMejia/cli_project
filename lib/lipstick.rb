

require_relative './scraper.rb'


class Lipstick < Scraper


    attr_accessor :brand_name, :price, :description

    @@all = []
    
    def initialize(brand_name, description, price)
        @brand_name = brand_name
        @description = description  
        @price = price
        save
    end


    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.search_brand(brand)
        @@all.select {|item| item.brand_name == brand}
    end
    
    
end#class ender




























#---------- UNTOUCHED CODE---------
# require_relative './scraper.rb'


# class Lipstick < Scraper


#     attr_accessor :brand_name, :price, :description

#     @@all = []
    
#     def initialize(brand_name, description, price)
#         @brand_name = brand_name
#         @description = description  
#         @price = price
#         save
#     end


#     def self.all
#         @@all
#     end

#     def self.reset_all
#         @@all.clear
#     end

#     def save
#         @@all << self
#     end

#     def self.search_brand(brand)
#         @@all.select {|item| item.brand_name == brand}
#     end
    
#     def create_lipstick_object
#     lipstick_array = Scraper.get_lipstick
#     self.new(lipstick_array[:brand_name, :description, :price])
#     end

# end#class ender