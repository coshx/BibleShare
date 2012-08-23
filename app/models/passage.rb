class Passage < ActiveRecord::Base
  has_many :posts
  attr_accessible :bible, :content, :title
  require 'net/http'

  def render_bible_verses
    bible_verses = self.bible  
    base_url = "http://api.preachingcentral.com/bible.php?passage="
    final_url = base_url.concat(bible_verses)
    source = Net::HTTP.get(URI.parse(URI.encode(final_url)))
    xml = Nokogiri::XML(source)
    
    parse_xml(xml)
  end
  
  def parse_xml(param)
    return_string = ""
    param.xpath("bible/range").each_with_index do |range, index|

      range.xpath("result").each do |title|
        title = "<h1>" + title + "</h1>"
        if(index > 0)
          title = "<br /> <br /> <br />" + title
        end
        return_string = return_string + title
      end
      
      init_chapter_number = range.xpath("item[1]/chapter").text
      init_chapter = "<h3>" + "Chapter " + init_chapter_number + "</h3>"
      return_string = return_string + init_chapter
      
      range.xpath("item").each do |item|
        chapter_number = item.xpath("chapter").text
        if(chapter_number != init_chapter_number)
          chapter = "<h3>" + "Chapter " + item.xpath("chapter").text + "</h3>"
          init_chapter_number = chapter_number
          return_string = return_string + chapter
        end
        
        verse = "<b>" + item.xpath("verse").text + "</b>" + " "
        text = item.xpath("text").text + " "
        return_string = return_string + verse + text
      end

    end
    return return_string
  end
  
end
