
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
    
    
end#class ender