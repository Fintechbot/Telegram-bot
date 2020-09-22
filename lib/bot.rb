require 'telegram/bot'
require_relative './articles'
require 'dotenv'
Dotenv.load

class MyBot
  Telegram::Bot::Client.run(ENV['TELEGRAM_KEY']) do |bot|
    bot.listen do |message|
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Welcome, #{message.from.first_name},to my bot. You may enter ./article for a programming article to read, /saying for a programming saying, /joke for  a joke or /stop to stop the bot!")
      when '/stop'  
        bot.api.send_message(chat_id: message.chat.id, text: "Don't say bye, #{message.from.first_name}!", date: message.date)
      when '/article'
        article = Atricles.new
        bot.api.send_message(chat_id: message.chat.id, text: article.random_article)
      else bot.api.send_message(chat_id: message.chat.id, text: "Invalid command, #{message.from.first_name}, Please enter /start, /stop or /article")
      end
    end
  end
end