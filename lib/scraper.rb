require 'pry'
require 'open-uri'
require 'json'
require 'nokogiri'

class Scraper 

    def self.get_lipstick 
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
    
        def self.new_lipstick 
            get_lipstick.each {|lipstick| Lipstick.new(lipstick[:brand], lipstick[:info], lipstick[:price])}
        end
    
        def brand_list(brand)
            find_brands = search_brand(brand) 
             find_brands.each do |lip_hash|
                Lipstick.all.select do |lippy_obj|
                   if lip_hash[:brand] == lippy_obj.brand_name && lip_hash[:price] == lippy_obj.price
                puts "==============================="
                puts "Brand: #{lippy_obj.brand_name.capitalize}"
                    if lippy_obj.price == "$0.00" 
                    puts "Price: Unlisted"
                    else
                    puts "Price: #{lippy_obj.price}"
                    end
                    puts "Description: #{lippy_obj.description}"
                    end

                end
            end
        end
    
       
        def tag_list(tag)           
            find_tags = search_tags(tag) 
             find_tags.each do |lip_hash|
                Lipstick.all.select do |lippy_obj|
                   if lip_hash[:brand] == lippy_obj.brand_name && lip_hash[:price] == lippy_obj.price
                puts "==============================="
                puts "Brand: #{lippy_obj.brand_name.capitalize}"
                    if lippy_obj.price == "$0.00" 
                        puts "Price: Unlisted"
                    else
                    puts "Price: #{lippy_obj.price}"
                    end
                        puts "Description: #{lippy_obj.description}"
                    end
                end
            end
        end
    
    
    end#class ender

