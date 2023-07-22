class Brave
  
  #attr_readerの記述でゲッターを省略できる
  attr_reader :name, :offense, :defense
  
  attr_accessor :hp
  
  #必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5
  
  #initializeメソッドを定義
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
  
  #攻撃処理を実装するメソッド
  def attack(monster)
    
    puts "#{@name}の攻撃"
    
    attack_type = decision_attack_type
    damage = calculate_damage(target: monster, attack_type: attack_type)
      
    cause_damage(target: monster, damage: damage)
    
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end
  
  private
  
  #攻撃の種類(通常攻撃 or 必殺攻撃)を判定するメソッド
  def decision_attack_type
    
    #0~3の間でランダムに数字が変わる
    attack_num = rand(4)
    
    #4分の1の確率でspecial_attackを実行
    if attack_num == 0
      puts "必殺攻撃"
      "special_attack"
    else
      puts "通常攻撃"
      "normal_attack"
    end
  end
  
  #ダメージの計算メソッド
  def calculate_damage(**params)
    target = params[:target]
    attack_type = params[:attack_type]
    
    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end
  
  #HPにダメージを反映させる
  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]
    
    target.hp -= damage
    
    #もしターゲットのHPがマイナスになるなら0を代入
    target.hp = 0 if target.hp < 0    
    
    puts "#{target.name}は#{damage}のダメージを受けた"
  end
  
  def calculate_special_attack
    @offense * SPECIAL_ATTACK_CONSTANT
  end

end




class Monster
  
  #attr_readerの記述でゲッターを省略できる
  attr_reader :offense, :defense
  
  attr_accessor :hp, :name
  
  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5
  
  #initializeメソッドを定義
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
    
    #モンスターが変身したかどうかを判断するフラグ
    @transform_flag = false
    
    #変身する際の閾値(トリガー)を計算
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end
  
  
  #攻撃処理を実装するメソッド
  def attack(brave)
    
    #hpが半分より大きければ通常攻撃
    if @hp <= @trigger_of_transform && @transform_flag == false
      @transform_flag = true
      
      transform
    end
    
    puts "#{@name}の攻撃"
    
    damage = calculate_damage(brave)
    
    cause_damage(target: brave, damage: damage)
    
    
    puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end
  
  private
  
  def calculate_damage(target)
    @offense - target.defense
  end
  
  def cause_damage(**params)
    target = params[:target]
    damage = params[:damage]
    
    target.hp -= damage
    
    #もしターゲットのHPがマイナスになるなら0を代入
    target.hp = 0 if target.hp < 0  
    
    puts "#{target.name}は#{damage}のダメージを受けた"
  end
  
  #変身メソッドの定義
  def transform
    
    #変身後の名前
    transform_name = "ドラゴン"
    
    #変身メッセージ
    puts <<~EOS
    #{@name}は怒っている
    #{@name}は#{transform_name}に変身した
    EOS
    
    @offense *= POWER_UP_RATE
    
    @name = transform_name
    
  end
end

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

monster = Monster.new(name: "スライム", hp: 200, offense: 200, defense: 100)

loop do
  brave.attack(monster)
  
  break if monster.hp <= 0
  
  monster.attack(brave)
  
  if brave.hp <= 0
    break
  end
  
end

battle_result = brave.hp > 0

if battle_result
  exp = (monster.offense + monster.defense)*2
  gold = (monster.offense + monster.defense)*3
  
  puts "#{brave.name}はたたかいに勝った"
  puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
else
  puts "#{brave.name}はたたかいに負けた"
  puts "目の前が真っ暗になった"
end
# puts <<~TEXT
# NAME: #{brave.name}
# HP: #{brave.hp}
# OFFENCE: #{brave.offense}
# DFENCE: #{brave.defense}
# TEXT

