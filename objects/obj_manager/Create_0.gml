
randomize();

global.state_deal = 0;
global.state_reshuffle = 1;
global.state_match = 2;
global.state_clean_up = 3;

global.state = global.state_deal;

global.numcards = 24;

global.hand = ds_list_create();
global.deck = ds_list_create();
global.face_up_cards = ds_list_create();
global.discard = ds_list_create();



for (i=0; i<global.numcards; i++) {
   var newcard = instance_create_layer(x,y,"Instances",obj_card); 
   newcard.face_index = i % 3; //ADDED set the card's face
   //mod (%) is a math expression that returns the remainder of the two values
   //this allows us to loop through 0, 1, 2 for our card faces
   newcard.target_x = x; 
   newcard.target_y = y;
   newcard.face_up = false; 
   newcard.in_hand = false; 
   newcard.targetdepth = 0; //ADDED this variable will help us create the effect of staggered cards
   ds_list_add(global.deck,newcard); 
}

ds_list_shuffle(global.deck);
for(var i = 0; i < global.numcards; i++){ //ADDED we need to loop through the newly shufffled deck
	global.deck[| i].x = x; 
	global.deck[| i].y = y - (2*i); //ADDED this gives us the staggered look of a deck, placing each card below the next
	global.deck[| i].target_x = global.deck[| i].x;
	global.deck[| i].target_y = global.deck[| i].y; 
	global.deck[| i].targetdepth = global.numcards - i; //ADDED base the depth of the card on its index so that 
	//cards on the top of the list are visually on the top of the deck
}

move_timer = 0; //ADDED this will count down to move cards from position to position
wait_timer = 0; 
shake_screen = 5; //ADDED this sets our screen shake alarm
bg_color = 5; //ADDED this sets our screen shake alarm
global.selected = noone;

lay_id = layer_get_id("Background"); //ADDED for change my background color in code
back_id = layer_background_get_id(lay_id); //ADDED for change my background color in code

parts = part_system_create(); //ADDED particle systems run all our particle effects
part_system_depth( parts, 30); //ADDED set the particles to display behind the cards
spark = part_type_create(); //ADDED all particles have a "type" or kind. this is how we set the look and feel of individual particles in a system


//ADDED all of the following functions change the look, size, physics, and time of our particles
part_type_shape(spark, pt_shape_star);
part_type_size(spark, .1, .2, 0, 0);
part_type_speed(spark, 2, 5, -0.10, 0);
part_type_direction(spark, 0, 360, 0, 0);
part_type_color3(spark, c_white, c_yellow, c_yellow);
part_type_life(spark, 15, 30);
