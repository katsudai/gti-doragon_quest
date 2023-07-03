class Brave
  
  #attr_readerの記述でゲッターを省略できる
  attr_reader :name, :offence, :defence
  
  attr_accessor :hp
  
  #initializeメソッドを定義
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offence = params[:offence]
    @defence = params[:defence]
  end
  
end









brave = Brave.new(name: "テリー", hp: 500, offence: 150, defence: 100)

puts <<~TEXT
NAME: #{brave.name}
HP: #{brave.hp}
OFFENCE: #{brave.offence}
DFENCE: #{brave.defence}
TEXT

brave.hp -= 30

puts "#{brave.name}はダメージを受けた!　残りHPは#{brave.hp}だ"