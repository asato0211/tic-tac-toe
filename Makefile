in:
	docker exec -ti code /bin/bash

profile:
	docker exec -it code ruby minimax_player/prof_minimax_player.rb
