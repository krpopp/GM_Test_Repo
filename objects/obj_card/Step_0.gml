/// @description Insert description here
// You can write your code in this editor


//if we're in the matching state
//and the card is in the hand
//check to see if the mouse is over the card
//make that card the selected card
if(global.state == global.state_match && in_hand){
	if(!face_up){ //ADDED if the card is not face up
		if(position_meeting(mouse_x, mouse_y, id)){
			target_y = room_height * .75; //ADDED move up a bit
			global.selected = id;
		}else if (global.selected == id){
			target_y = room_height * .8; //ADDED move down a bit
			global.selected = noone;
		} else{
			target_y = room_height * .8; //ADDED move down a bit
		}
	} else{ //ADDED if the card is face up
		target_y = room_height * .75; //ADDED move up a bit
	}

}
