require 'pry'
#a cli is a user interface.
#a user can make a choice what to scrape.
# type list or details
#it shouldn't start in console
#it should start in its own file in bin.
#move cli, scraper, and league member in Justice League folder

#USE WORLDS BEST RESTAURANTS as an example.

#it should use the justice_league.rb file.
#create a new repo to delete extra justice_league_database folder.
#justice league only no database
#redo readme file inside folder.
#this is going to be the one for my portfolio for my job.
#dm or slack Nancy with the new repo.

#ADD CLI LOGIC
#MOVE ENVIORNMENT SETUP IN Justice_League.rb
#RUN FROM FILE OTHER THAN CONSOLE
#ADD A PROPER readme
#CLEANUP FILE STRUCTURE
#scrape names first only and show names on text.
#list of justice league members.
#go small with the CLI

class JusticeLeague::CommandLineInterface

  def call
    #JusticeLeague::Scraper.new
    JusticeLeague::Scraper.scrape_justice_league_page #remember the difference between instance and class methods
    #class methods ^ can be called without instances of the class created.
    puts "...Dwarf Starf Star engine engaged..."
    puts "...System Online..."
    puts "..."
    puts "...Searching Watchtower Database..."
    puts "Loading..."
    puts "Accessing Database."
    puts ""
    puts "Login:"
    @User = gets.chomp
    puts "Password:"
    @Password = gets.chomp
    puts "Running facial scan..."
    puts ""
    puts "Running DNA scan..."
    puts ""
    puts "Greetings #{@User}. Welcome to the Justice League Database."
    run
    start
  end

  def start
    puts "Use /help for options. Otherwise enter your command."
    @input = gets.chomp.downcase #REMEMBER CASES DONT NEED =
      while @input != "123456789"
      case @input
        when "/help"
          puts ""
          puts "Accessing help desk..."
          puts ""
          puts "Loading..."
          puts ""
          puts "List of commands:"
          puts "/display_members_list - Display a list of current justice league members."
          puts "/access_member_file - Accesses member's file."
          puts "/display_members_weaknesses - Displays a list of ways used to take down the justice league."
          puts "/shutdown - Exits database."
          puts "/self_destruct - Erases all info on database and begins Watchtower self destruct sequence."
          puts ""
        @input = gets.chomp.downcase
        when "/display_members_list"
          puts ""
          display_members_list
          puts ""
          puts "Use /help for options. Otherwise enter your command."
          @input = gets.chomp.downcase
        when "/access_member_file"
          puts ""
          puts "Please input the member you wish to see info on..."
          puts "If the member is not recognized, the system will ask for a new command."
          puts "Please consult /display_members_list."
          puts ""
          @member = gets.chomp.downcase
          JusticeLeague::League_Member.current_members.each do |leaguer| #leaguer.name not in pipes.
            if leaguer.name.downcase == @member
              puts "Displaying Justice League Member, "+ leaguer.name + "."
              puts "Alias:" + leaguer.alias
              puts "Alignment:" + leaguer.alignment
              puts "Identity:" + leaguer.identity
              puts "Nonhuman Race(empty if human):" + leaguer.race.to_s
              puts "Citizenship:" + leaguer.citizenship.to_s.gsub("[]","")
              puts "Martial Status:" + leaguer.marital_status
              puts "Occupation:" + leaguer.occupation.to_s.gsub("[]","")
            end
          end
          puts ""
          puts "Use /help for options. Otherwise enter your command."
          puts ""
          @input = gets.chomp.downcase
        when "/display_members_weaknesses"
          puts ""
          puts "Enter password:"
          @weakness_password = gets.chomp.to_s.downcase
            if @weakness_password == "deltacharlie-27-5-1939"
              puts "loading agamemno contingency..."
              puts "https://www.youtube.com/watch?v=ZJVvrmLSTsg"
            else
              puts ""
              puts "Access Denied."
            end
          puts ""
          puts "Use /help for options. Otherwise enter your command."
          puts ""
          @input = gets.chomp.downcase
        when "/shutdown"
          puts ""
          puts "Logging out ..."
          break
        when "/self_destruct"
          puts ""
          puts "WARNING: ACTIVATION CREATES A 50 KILOTON EXPLOSION."
          puts "ENTER DETONATION CODE:"
          @code = gets.chomp.to_s
          if @code == "52"
            puts ""
            puts "OVERHEATING DWARFSTAR DRIVE"
            puts ""
            puts "COUNTDOWN TIMER STARTING..."
            @count = 600
            while @count != 0
              @count -= 1
            puts " "
            puts " "
            puts " "
            puts " "
            puts " "
            puts " "
            puts "TIME REMAINING BEFORE DETONATION: #{@count}"
            puts " "
            puts " "
            puts " "
            puts " "
            puts " "
            puts " "
            end
            puts "BOOOOOOOOOOOOOOMMMMMM!!!!"
            break
          end
        else
          puts "Unknown input detected."
          puts "Use /help for options. Please enter a working command."
          @input = gets.chomp
        end
      end
    end

  def run
    make_members
    add_attributes_to_members
  end

  def make_members
    league_array = JusticeLeague::Scraper.scrape_justice_league_page
    #league_array = Scraper.scrape_justice_league_page(BASE_PATH + 'justiceleague.html')
    JusticeLeague::League_Member.create_from_collection(league_array)

  end

  def add_attributes_to_members
    #there was a problem with arrays becoming nil so this was the workaround
    JusticeLeague::League_Member.current_members.each do |member|
     attributes = JusticeLeague::Scraper.scrape_member_page(member.profile_url)
     member.add_member_attributes(attributes)
    end
  end

  def display_members_list
    puts ""
    puts "Displaying current Justice League Members..."
    JusticeLeague::League_Member.current_members.each do |member|
        puts member.name
    end
  end
end
