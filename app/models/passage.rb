class Passage < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  has_one :permission, :dependent => :destroy
  belongs_to :user
  attr_accessible :bible, :content, :title, :scripture, :user_id, :is_private
  
  scope :public_passages, where(:is_private => 'false')
  scope :private_passages, where(:is_private => 'true')
  
  validates :title, :presence => true
  validates :bible, :presence => true
  validates :scripture, :presence => true
  
  
  
  def render_bible_verses
    bible_verses = self.bible
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
        title = "<h4>" + title + "</h4>"
        if(index > 0)
          title = "<br /> <br /> <br />" + title
        end
        return_string = return_string + title
      end
      
      init_chapter_number = range.xpath("item[1]/chapter").text
      init_chapter = "<h6>" + "Chapter " + init_chapter_number + "</h6>"
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
end
