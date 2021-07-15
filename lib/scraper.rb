require 'pry'
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
    
    
    end #class ender