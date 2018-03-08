/**
 * Program constant definitions.
 */
package Constants;
  // VGA parameters.
  parameter VGA_HEIGHT = 9'd480;
  parameter VGA_WIDTH = 10'd640;

  // Game constants.
  parameter BACKGROUND_VGA_R = 8'h00;
  parameter BACKGROUND_VGA_G = 8'h00;
  parameter BACKGROUND_VGA_B = 8'h00;

  parameter GAME_OVER_VGA_R = 8'hff;
  parameter GAME_OVER_VGA_G = 8'h00;
  parameter GAME_OVER_VGA_B = 8'h00;

  // Bird constants.
  parameter BIRD_CLOCK_SCALE = 16;
  parameter BIRD_DEFAULT_HEIGHT = 9'd450;
  parameter BIRD_DEFAULT_DISTANCE = 10'd80;
  parameter BIRD_MIN_HEIGHT = 9'd20;
  parameter BIRD_MAX_HEIGHT = VGA_HEIGHT - BIRD_MIN_HEIGHT;
  parameter BIRD_VGA_HEIGHT = 9'd40;
  parameter BIRD_VGA_WIDTH = 10'd40;
  parameter BIRD_VGA_X_MIN = 10'd60;
  parameter BIRD_VGA_X_MAX = 10'd100;
  parameter BIRD_VGA_R = 8'hff;
  parameter BIRD_VGA_G = 8'hff;
  parameter BIRD_VGA_B = 8'h0f;

  // Obstacle constants.
  parameter OBSTACLE_CLOCK_SCALE = 17;
  parameter OBSTACLE_MIN_HEIGHT = 9'd80;
  parameter OBSTACLE_MAX_HEIGHT = 9'd120;
  parameter OBSTACLE_MAX_DISTANCE = 10'd720;
  parameter OBSTACLE_MIN_GAP_HEIGHT = 9'd160;
  parameter OBSTACLE_MAX_GAP_HEIGHT = 9'd300;
  parameter OBSTACLE_VGA_WIDTH = 10'd80;
  parameter OBSTACLE_VGA_R = 8'h03;
  parameter OBSTACLE_VGA_G = 8'hff;
  parameter OBSTACLE_VGA_B = 8'h0f;

  parameter OBSTACLE0_INITIAL_HEIGHT = 9'd90;
  parameter OBSTACLE0_INITIAL_DISTANCE = 10'd240;
  parameter OBSTACLE0_INITIAL_GAP_HEIGHT = 9'd380;

  parameter OBSTACLE1_INITIAL_HEIGHT = 9'd180;
  parameter OBSTACLE1_INITIAL_DISTANCE = 10'd480;
  parameter OBSTACLE1_INITIAL_GAP_HEIGHT = 9'd200;

  parameter OBSTACLE2_INITIAL_HEIGHT = 9'd270;
  parameter OBSTACLE2_INITIAL_DISTANCE = 10'd720;
  parameter OBSTACLE2_INITIAL_GAP_HEIGHT = 9'd210;
endpackage: Constants
