/// @description Insert description here
// You can write your code in this editor


shake_screen = shake_screen -1; //ADDED count down the screen shake timer
alarm[0] = shake_screen; //ADDED reset this alarm to go off at the new time
camera_set_view_pos(view_camera[0], irandom_range(-shake_screen,shake_screen),irandom_range(-shake_screen,shake_screen)); 
//ADDED move the camera's position within a random range based on our timer
if(shake_screen <= 0){ //ADDED if we reach 0, reset the alarm
	shake_screen = 5;
}