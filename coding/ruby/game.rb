class GameEntity
	attr_accessor :name, :hp
	
	def initialize(name, hp)
		self.name = name
		self.hp = hp
	end
end

class GameLoop
	attr_accessor :player, :enemy, :turn
		
	def initialize
		self.turn = 0
		self.player = GameEntity.new('Player', 20)
		self.enemy = GameEntity.new('Enemy', 5)
	end
	
	def game_over
		self.player.hp <= 0 || self.enemy.hp <= 0
	end
	
	def resolve_combat()
		puts "##### START TURN #{turn} #####"

		old_player_hp = self.player.hp
		enemy_damage = 1
		self.player.hp -= enemy_damage
		if block_given?
			yield 'Enemy', enemy_damage, 'Player', old_player_hp, self.player.hp
		end

		old_enemy_hp = self.enemy.hp
		player_damage = 1
		self.enemy.hp -= player_damage
		if block_given?
			yield 'Player', player_damage, 'Enemy', old_enemy_hp, self.enemy.hp
		end
		puts "##### END   TURN #{turn} #####"
		puts "########################"
		self.turn += 1
	end
end

loop = GameLoop.new
begin
	loop.resolve_combat() {|source,damage,target,old_hp,new_hp|
		puts "  #{source} dealt #{damage} damage to #{target} (#{old_hp} HP => #{new_hp} HP)"
	}
end until loop.game_over
