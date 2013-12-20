require 'cinch'
require 'sqlite3' 

require_relative 'commands.rb'
require_relative 'logic.rb'

$db = SQLite3::Database.open "markovirc.db"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["##test"]
    c.nick = "markovirc"
    c.user = "markovirc"
    
    c.delimeter = "!"
  end

  on :message, /^('?sup|he[y]+|hello)(\s+[a-z0-9_-]*)?/i do |m, greeting, text|
    if text != "" and text != bot.nick
      next
    end
    
    if m.user.nick == "lae"
      m.reply "Hey Musee!"
		elsif m.user.nick == 'Aaron5367'
			m.reply "/xe/ billy!"
    else
      m.reply "Hello #{m.user.nick}"
    end
  end

  on :message, /^!([a-z]*)(.*)/i do |msg, command, args|
    commandHandle command, args, msg
  end

  on :message do |msg|
	puts msg
    logHandle $db, msg
  end
end

bot.start