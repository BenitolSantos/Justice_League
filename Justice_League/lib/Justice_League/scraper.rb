#DON'T use ruby bin/console to run (THIS WAS WRONG)
#puts 'Hello'


class JusticeLeague::Scraper
  def self.testmethod
    puts "in test method"
  end

  def self.scrape_justice_league_page #should be instance instead of class method.
    #index_page = Nokogiri::HTML(html) #parameter added
    puts "**********Scraping Main Page*******"
    index_page = Nokogiri::HTML(open("http://dc.wikia.com/wiki/Justice_League_(Prime_Earth)"))
    current_league_members = []
    index_page.css("div.notice a").first(9).collect do |member|
    #a trap when coding is coding and not calling it
     league_hash = {
      :name => member.text,
      :alias => member.attribute("title").value.gsub(" (Prime Earth)",""),
      :profile_url => "http://dc.wikia.com/" + member.attribute("href").value
     }
     current_league_members << league_hash
    end
  end

  def self.scrape_member_page(profile_url)
    league_member = {

     }
    puts "**********Scraping Detail page ***********"
    profile_page = Nokogiri::HTML(open(profile_url))
      profile_page.css("section.pi-item.pi-group.pi-border-color h2.pi-item-spacing.pi-secondary-background").each do |header|
        if header.text == "Status"
          profile_page.css("section.pi-item.pi-group.pi-border-color div.pi-item.pi-data.pi-item-spacing.pi-border-color").each do |word|
            #USE CASE STATMENTS!!! don't convert each to symbol. Converting to symbol doesn't work because not every attribute has a link.
            #ALSO FIX THE ATTR attr_accessor in league_member.rb
            x = word.css("h3.pi-data-label.pi-secondary-font").text
            case x
            when "Alignment"
                 alignment = word.css("div.pi-data-value.pi-font a").text
                 #had to assign variables due to nil showing up in attributes_hash
                 #no explicit conversion error fixed with this ^
                 league_member[:alignment] = alignment
              when "Identity"
                identity = word.css("div.pi-data-value.pi-font a").text
                league_member[:identity] = identity
              when "Race"
                race_array = []
                word.css("div.pi-data-value.pi-font a").each do |race|
                    race_array << race.text
                end
                league_member[:race] = race_array
              when "Citizenship"
                nationality_array = []
                word.css("div.pi-data-value.pi-font a").each do |nationality|
                  nationality_array << nationality.text
                end
                league_member[:citizenship] =  nationality_array
              when "Marital Status"
                marital_status = word.css("div.pi-data-value.pi-font a").text
                league_member[:marital_status] =  marital_status
              when "Occupation"
                job_array = []
                word.css("div.pi-data-value.pi-font a").each do |job|
                  job_array << job.text
                end
                league_member[:occupation] =  job_array
              else
            end
            #word.css("div.pi-data-value.pi-font").each do |answer|
            #  answer_array = []
            #  answer_array << answer.text
            #end
            #league_member[hero_attribute] = answer_array
          end
          end
        end
        league_member #implicit return (ruby only)
    end #DON'T FORCE PUSH! IT OVERWRITES THE COMMIT HISTORY

end
