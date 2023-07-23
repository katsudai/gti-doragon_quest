require "./character"

class Monster < Character
  
  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5
  
  #initializeメソッドを定義
  def initialize(**params)
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )
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
