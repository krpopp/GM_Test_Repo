/// @description Insert description here
// You can write your code in this editor

//if the card is not at the end position
//move a little bit closer to the end position
if (abs(x - target_x) > 1) {
	x = lerp(x,target_x,0.2);
	depth = -1000; //ADDED when the card is moving, make sure it appears above all the other cards
}
else {
	x = target_x;
	depth = targetdepth; //ADDED when the card is not moving, go to the right depth
}
if (abs(y - target_y) > 1) {
	y = lerp(y,target_y,0.2);
	depth = -1000; //ADDED when the card is moving, make sure it appears above all the other cards
}
else {
	y = target_y;
	depth = targetdepth; //ADDED when the card is not moving, go to the right depth
}

//assigns the face sprite depending on the card's face index 
if (face_index == 0) sprite_index = spr_red;
if (face_index == 1) sprite_index = spr_blue;
if (face_index == 2) sprite_index = spr_yellow;
if (face_up == false) sprite_index = spr_card;

draw_sprite(sprite_index, image_index, x, y);