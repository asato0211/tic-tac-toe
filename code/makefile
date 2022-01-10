# コマンド(make rbtest)を作成

up:
	docker-compose up -d

in:
	docker exec -ti code /bin/bash

down:
	docker-compose down

rbtest:
	ruby game/game_test.rb
	ruby guest_player/guest_player_test.rb
	ruby random_player/random_player_test.rb
	ruby minimax_player/minimax_player_test.rb
	echo "complete test"
