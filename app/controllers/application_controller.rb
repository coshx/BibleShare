class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'net/http'
  
  def authenticate_owner_or_member(passage)
    unless((passage.permission.users.include? current_user) || (passage.user.eql? current_user))
      return false
    end
    return true
  end
  
  def authenticate_content_owner(content_user_id)
    unless user_signed_in? && current_user.id == content_user_id
      return false
    end
    return true
  end
  
  def authenticate_subcontent_owner(content_user_ids)
    if user_signed_in?
      content_user_ids.each do |user_id|
        if current_user.id == user_id
          return true
        end
      end
    end
    return false
  end
  
  def render_bible_verses(param)
    bible_verses = param
    base_url = "http://api.preachingcentral.com/bible.php?passage="
    final_url = base_url + bible_verses
    source = Net::HTTP.get(URI.parse(URI.encode(final_url)))
    xml = Nokogiri::XML(source)
    
    parse_passage_xml(xml)
  end
  
  def parse_passage_xml(param)
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
    return_string
  end
  
  def parse_tagging_xml(param)
    return_string = ""
    param.xpath("bible/range").each_with_index do |range, index|
      check_chapter = false
    
      range.xpath("result").each do |title|
        title = "<h5>" + title + "</h5>"

        return_string = return_string + title
      end
      
      range.xpath("item").each do |item|
        verse = "<b>" + item.xpath("verse").text + "</b>" + " "
        text = item.xpath("text").text + " "
        return_string = return_string + verse + text
      end

    end
    return_string  
  end
  
  def handle_bible_verse_tagging(param)
    base_url = "http://api.preachingcentral.com/bible.php?passage="
    verse_array = param.scan(/@(.*?)@/).flatten
    replace_array = param.scan(/@.*?@/).flatten
    scripture_array = []
    
    verse_array.each do |verse|
      final_url = base_url + verse
      source = Net::HTTP.get(URI.parse(URI.encode(final_url)))
      xml = Nokogiri::XML(source)
      scripture = parse_tagging_xml(xml)
      scripture_array << scripture
    end
    
    replace_array.each_with_index do |replace, index|
      param = param.gsub(replace, scripture_array[index] + "<br /> <br />")
    end 
    
    param
  end

end
