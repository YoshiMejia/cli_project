require 'pry'
require 'net/http'
require 'open-uri'
require 'json'
require 'nokogiri'

class Scraper 

    def get_lipstick
    lipstick_info = []
    lipsticks_url = "http://makeup-api.herokuapp.com/api/v1/products?product_type=lipstick"
    doc = Nokogiri::HTML(open(lipsticks_url))
        doc.css("div.product_section").each do |product|
            product.css(".panel-body").each do |item|
                brand_name = item.css("h3").text
                description = item.css("h4").text
                price = item.css("p")[1].text
                lipstick_info << {brand: brand_name, price: price, info: description}
            end
        end
        lipstick_info
    end



    def search_tags(tag)
        tagged_lipsticks = []
        tagged_url = "http://makeup-api.herokuapp.com/api/v1/products?product_tags=#{tag}&product_type=lipstick"
        doc = Nokogiri::HTML(open(tagged_url))
            doc.css("div.product_section").each do |product|
                product.css(".panel-body").each do |item|
                    brand_name = item.css("h3").text
                    description = item.css("h4").text
                    price = item.css("p")[1].text
                tagged_lipsticks << {brand: brand_name, price: price, info: description}
                end
            end 
    tagged_lipsticks
    end


    def search_brand(brand)
        get_lipstick.select {|item| item[:brand] == brand}
    end

    def new_lipstick 
        get_lipstick.each {|lipstick| Lipstick.new(lipstick[:brand], lipstick[:info], lipstick[:price])}
    end

    def brand_list(brand)
        search_brand(brand).each {|lipstick| Lipstick.new(lipstick[:brand], lipstick[:info], lipstick[:price])}.map do |item|
        puts "==============================="
        puts "Brand: #{item[:brand]}"
        puts "Price: #{item[:price]}"
        puts "Description: #{item[:info]}"
        end

    end

    def tag_list(tag)
        search_tags(tag).each {|lipstick| Lipstick.new(lipstick[:brand], lipstick[:info], lipstick[:price])}.map do |item|
            puts "==============================="
            puts "Brand: #{item[:brand]}"
            puts "Price: #{item[:price]}"
            puts "Description: #{item[:info]}"
        end
    end



    

    
    















newbie = Scraper.new 
# newbie.get_lipstick ------JSON METHOD
    #binding.pry
"pls work"
    
end#class ender