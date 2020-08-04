switch(global.state){
  case global.state_deal:
	  if(move_timer == 0){ //ADDED when the move timer goes off
		    var cards_in_hand = ds_list_size(global.hand);
		    if (cards_in_hand < 4){
		      var dealt_card = global.deck[| ds_list_size(global.deck)-1];
			  ds_list_delete(global.deck, ds_list_size(global.deck)-1);
		      ds_list_add(global.hand, dealt_card);
		      dealt_card.target_x = room_width/4  + cards_in_hand * 100; 
		      dealt_card.target_y = room_height * .8;
			  dealt_card.in_hand = true; 
		    } 
		    if(cards_in_hand == 4) { //ADDED when we have a full hand, change to the next state
				global.state = global.state_match; 
			}
	  }
    break;
  case global.state_match:
	if(global.selected != noone){ //ADDED if we're hovering over a card
		part_particles_create(parts,global.selected.x,global.selected.y,spark, 5); //run the particle system
	}
	if (mouse_check_button_pressed(mb_left)){
	   if (global.selected != noone){
		  if(!global.selected.face_up){
			ds_list_add(global.face_up_cards, global.selected); 
			global.selected.face_up = true; 
			global.selected = noone;
		  }
	   }
	}
	if(ds_list_size(global.face_up_cards) >= 2){ 
		wait_timer++; 
		if(wait_timer > 30){
			global.face_up_cards[| 0].face_up = false; 
			global.face_up_cards[| 1].face_up = false;
			if(global.face_up_cards[| 0].face_index == global.face_up_cards[| 1].face_index){ 
				alarm[1] = bg_color; //ADDED this is an alarm that contains our background color code
				global.state = global.state_clean_up; 
			} else{
				alarm[0] = shake_screen; //ADDED this is an alarm that contains our screen shake code
			}
			ds_list_clear(global.face_up_cards); ///ADDED moved this here to so it only happens once
			wait_timer = 0; //ADDED moved this here so it only happens once
		}
	}
	break;
  case global.state_clean_up:
		wait_timer++;
		if(move_timer == 0 && wait_timer > 30){ //ADDED when both timers go off
			var cards_in_hand = ds_list_size(global.hand); //ADDED get the hand size
			if(cards_in_hand > 0){ //ADDED if we have cards in the hand
				var return_card = global.hand[| cards_in_hand-1]; //ADDED get the next hand card
				return_card.target_x = room_width - 100; 
				return_card.target_y = y - (ds_list_size(global.discard) *2); //ADDED move it to the discard, but staggered
				return_card.in_hand = false; 
				ds_list_add(global.discard, global.hand[| cards_in_hand-1]); 
				ds_list_delete(global.hand, cards_in_hand-1); //ADDED remove it from the hand
				return_card.targetdepth = -ds_list_size(global.discard); //ADDED change its depth
			} else{
				ds_list_clear(global.hand); //ADDED moved this here so it only happens once
				if(ds_list_size(global.discard) >= global.numcards){ 
					global.state = global.state_reshuffle; 
				} else{
					global.state = global.state_deal;
				}
				wait_timer = 0;
			}
		}

	break;
  case global.state_reshuffle:
		wait_timer++;
		if(move_timer % 4 == 0 && ds_list_size(global.discard) > 0){ //ADDED move_timer is divisible by 4 and there are still cards in the discard
			//ADDED instead of using a for loop, we're moving cards every four frames or so
			var return_card = global.discard[| ds_list_size(global.discard)-1];
			ds_list_delete(global.discard, ds_list_size(global.discard)-1);
			ds_list_add(global.deck, return_card);
			return_card.target_x = x;
			return_card.target_y = y - (2*ds_list_size(global.discard)-1);
			if(ds_list_size(global.deck) == global.numcards){
				ds_list_shuffle(global.deck);
				current_card = 0; //ADDED this is to count cards that must be shuffled in a few lines
			}
		}

		if(wait_timer > 100 && ds_list_size(global.deck) == global.numcards){////ADDED wait a bit so the player can see what happened
			if(move_timer % 2 == 0){ //ADDED if move_timer is even
				//ADDED reset the newly shuffled cards to their new depths
				//ADDED this is similar to what we do in create after shuffling
				global.deck[| current_card].x = x;
				global.deck[| current_card].y = y - (2*current_card);
				global.deck[| current_card].target_x = global.deck[| current_card].x;
				global.deck[| current_card].target_y = global.deck[| current_card].y;
				global.deck[| current_card].targetdepth = global.numcards - current_card;	
				current_card++; //ADDED move to the next card
			}
			
			if(current_card == ds_list_size(global.deck)){ //ADDED when all the cards have been shuffled
				global.state = global.state_deal;
				wait_timer = 0;
			}
		}
   break;
 }

move_timer++; //ADDED increase the move timer
//ADDED the move timer is a short timer that counts down between frames when we're moving cards from different positions 
if(move_timer == 16){ //ADDED reset the move timer
	move_timer = 0;
}