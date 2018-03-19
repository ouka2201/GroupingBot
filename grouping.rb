require 'rubygems'
require 'discordrb'
require 'mechanize'

# 環境変数のLoad
bot = Discordrb::Commands::CommandBot.new(
  token: ENV["DISCORD_TOKEN"] ,
  client_id: ENV["DISCORD_CLIENT_ID"],
  prefix:'/'
)

bot.command :hello do |event|
 event.send_message("hallo,world! #{event.user.name}")
end

player_list = []

# ポプ子メッセージ
bot.command :hi do |event|
    popuko_img_list = Dir.glob("img/*")
    select_img_path = popuko_img_list[rand(popuko_img_list.length)]
    event.send_file(File.open(select_img_path, 'r'), caption: "#{event.user.name} .")
end

# Inamura
# bot.command :inamura do |event|
#     inamura_img_list = Dir.glob("inamura/*")
#     select_img_path = inamura_img_list[rand(inamura_img_list.length)]
#     event.send_file(File.open(select_img_path, 'r'), caption: "Hi, #{event.user.name} .")
# end

# Food写真提供
bot.command :food do |event|
    agent = Mechanize.new
    link = 'https://source.unsplash.com/random/featured/?Food,Plate'
    agent.get(link).save "pic.png"
    event.send_file(File.open("pic.png", 'r'), caption: "OK, #{event.user.name} .")
    sleep(3)
    delete = File.delete("pic.png")
end

#プレイヤー追加コマンド
bot.command :add do |event, *code|
    player_name = code[0]
    if player_list.include?(player_name)
      event.send_message("#{code[0]} は既に参加済み。")
    else
      player_list.push(player_name)
      event.send_message("#{code[0]} を追加しました。")
    end
    puts player_list
end

#プレイヤー追加コマンド
bot.command :remove do |event, *code|
    player_name = code[0]
    if player_list.include?(player_name)
      player_list.delete(player_name)
      event.send_message("#{code[0]} をリストから削除しました。")
    else
      event.send_message("#{code[0]} はおらんで。")
    end
    puts player_list
end

#プレイヤー追加コマンド
bot.command :list do |event, *code|
    player_name = code[0]
    if player_list.empty?
      event.send_message("誰もリストにはおらんよ")
    else
      event.send_message("#{player_list.join("\n")}")
    end
    puts player_list
end

# 参加者リスト初期化
bot.command :clear do |event|
    player_list.clear
    event.send_message("初期化完了。")
end

#プレイヤーのチーム分け
bot.command :grouping do |event|
    blueteam_list   = []
    orangeteam_list = []
    if player_list.empty?
     event.send_message("参加者は...誰一人居ませんでした...")
    else
      choise_number_list = [*(0..(player_list.length - 1))].sort_by{rand}
      choise_number_list.each_with_index do |x, i|
        puts player_list[x]
        if i.odd?
          orangeteam_list.push(player_list[x])
        else
          blueteam_list.push(player_list[x])
        end
      end
      event.send_message("チーム分け完了")
      event.send_message("【OrangeTeam】")
      event.send_message("#{orangeteam_list.join("\n")}")
      event.send_message("【BlueTeam】")
      event.send_message("#{blueteam_list.join("\n")}")
      event.send_message("Good Luck, Have Fun!")
    end
end

# 鬼ごっこ
bot.command :oni do |event, *code|
  oni_number = code[0].to_i
  puts oni_number
  if oni_number.kind_of?(Integer)
    break  if player_list.length < oni_number
    choise_number_list = [*(0..(player_list.length - 1))].sort_by{rand}
    sledge_number = choise_number_list[0]
    if oni_number == 1
      event.send_message("SLEDGE is #{player_list[sledge_number]}")
    elsif oni_number == 2
      twitch_number = choise_number_list[1]
      event.send_message("SLEDGE is #{player_list[sledge_number]}")
      event.send_message("TWITCH is #{player_list[twitch_number]}")
    elsif oni_number == 3
      twitch_number = choise_number_list[1]
      blitz_number  = choise_number_list[2]
      event.send_message("SLEDGE is #{player_list[sledge_number]}")
      event.send_message("TWITCH is #{player_list[twitch_number]}")
      event.send_message("BLITZ is #{player_list[blitz_number]}")
    end
  else
    event.send_message("数字をちゃんと入れてくだされ。")
  end
end

bot.run
