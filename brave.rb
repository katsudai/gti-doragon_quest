require "./character"

class Brave < Character
  
  #必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5
  
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
