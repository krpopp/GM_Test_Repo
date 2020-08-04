/// @description Insert description here
// You can write your code in this editor
bg_color = bg_color - 1; //ADDED count down the timer
alarm[1] = bg_color; //ADDED reset the alarm to go off a the new time
if(bg_color % 2 == 0){ //ADDED if the timer is even
	layer_background_blend(back_id, -1); //ADDED make the background white
} else{ //ADDED if the timer is odd
	layer_background_blend(back_id, $4C1616); //ADDED make the background red
}
if(bg_color <= 0){ //ADDEDwhen the timer runs out
	layer_background_blend(back_id, $16164C); //ADDED make the timer red
	bg_color = 5; //ADDED reset the timer
}