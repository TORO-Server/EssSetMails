require "yaml"

Message,
SenderName,
SenderUuid = ARGV
# timestamp 文字列を数値に変換
Timestamp = ARGV[3] == nil ? (Time.now.to_f * 1000).to_i : ARGV[3].to_i
# fill 文字列を数値に変換
FillCount = ARGV[4] == nil ? 1 : ARGV[4].to_i

puts "メッセージ: #{Message}"
puts "送信元プレイヤー名: #{SenderName}"
puts "送信元プレイヤーUUID: #{SenderUuid}"
puts "送られた時間: #{Time.at(Timestamp / 1000)}"
puts "メールの個数: #{FillCount}"
puts "\n"

def generateMails(message, senderName, senderUuid, timestamp, loop)
  mails = []
  # 繰り返し処理を実行
  loop.times do |i|
    mails.push({
      "legacy" => false,
      "read" => false,
      "message" => message,
      "sender-name" => senderName,
      "sender-uuid" => senderUuid,
      "timestamp" => timestamp,
      "expire" => 0,
    })
    puts "ループ数: #{i}回"
  end
  return mails
end

fileData = {}
fileData["mail"] = generateMails(Message, SenderName, SenderUuid, Timestamp, FillCount)
YAML.dump(fileData, File.open("result.yml", "w"))
