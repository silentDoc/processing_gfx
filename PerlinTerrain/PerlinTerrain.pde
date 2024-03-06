int cols, rows;
int scl = 15;
int w = 1200;
int h = 900;

float[][] terrainHeights;

float noise_inc = 0.15;
float noise_x = 0;
float noise_y = 0;
float noise_y_start_offset =0;

float min_height = -20;
float max_height = 80;

float fly_speed = 0.15;


int mode = 1; // 0 - static, 1 - flying, motion


void setup()
{
  size(640,480, P3D);
  cols = w/scl;
  rows = h/scl;
  
  terrainHeights = new float[cols][rows];
  
  noise_y = 0;
  
    
  frameRate(25);
}

void draw()
{
  noise_y = noise_y_start_offset;
  for(int y = 0; y < rows; y++)
  {
    noise_x = 0;
    for(int x = 0; x < cols; x++)
    {
        // Noise method in Processing contains perlin random numbers
        terrainHeights[x][y] = map(noise(noise_x,noise_y), 0,1, min_height,max_height);
        noise_x += noise_inc;
    }
    noise_y += noise_inc;
  }
  
  if(mode==1)
    noise_y_start_offset -= fly_speed;
  
  background(0);
  stroke(64);
  
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for(int y = 0; y < rows-1; y++)
  {
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x++)
    {
      int c = int(map(terrainHeights[x][y], min_height,max_height, 0,255));
      fill(c,c,c);
      // Begin Shape : https://processing.org/reference/beginShape_.html
      vertex(x*scl, y*scl, terrainHeights[x][y]);
      vertex(x*scl, (y+1)*scl, terrainHeights[x][y+1]);
      
    }
    endShape();
  }
}
