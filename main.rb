require "./brave"
require "./monster"
require "./games_controller.rb"

games_controller = GamesController.new

terry = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

slime = Monster.new(name: "スライム", hp: 200, offense: 200, defense: 100)

games_controller.battle(brave: terry, monster: slime)


# puts <<~TEXT
# NAME: #{brave.name}
# HP: #{brave.hp}
# OFFENCE: #{brave.offense}
# DFENCE: #{brave.defense}
# TEXT

