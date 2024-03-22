/*
Sample on building Value Noise Noise - 1D, from scratch
Ramon Felip
*/

// Line interpolation

// Provides a cosine interpolation of 2 heights (pa and pb), with 
// px being a value between 0 and 1 that states the distance of the x to interpolate with respect to 
// the x values of pa and pb
float interpolateCosine(float pa, float pb, float px)
{
    float ft = px * PI;  // Radians
    float f = (1 - cos(ft)) * 0.5;
    return pa * (1 - f) + pb * f;
}

// Same but with linear interpolation - faster, in case of intensive computing 
float interpolateLinear(float pa, float pb, float px)
{
    return pa * (1 - px) + pb * px;
}

// Value noise generation
// What we do is to randomly set the heights of the x-points that coincide with the beginning and 
// end of the wavelenght and interpolate the ones in the middle 
float[] generateValueNoise(int num_x_Positions, int min_height, int max_height, int wavelength)
{
  float[] heights = new float[num_x_Positions];
  float height_start = random(min_height, max_height);
  float height_end   = random(min_height, max_height);

  for(int i =0 ; i< num_x_Positions; i++)
  {
    if(i % wavelength ==0)
    {
        // we have a control point, we keep the last height end as our starting one and generate a new height_end
        height_start = height_end;
        height_end   = random(min_height, max_height);
        heights[i] = height_start; 
    }
    else
    {
      // interpolate values
      float interpolation_point = (float) (i % wavelength);
      interpolation_point /= (float) wavelength;
      heights[i] = interpolateCosine( height_start, height_end, interpolation_point);
    }
  }
  return heights;  
}

PFont font;
void setup()
{
  size(640,640);
  noLoop();
  font = createFont("Arial",16,true);
}

void draw()
{
  
  int num_points = width;
  int min_h = 10;
  int max_h = 200;
  int waveLength = 40;
  
  float[] heights = generateValueNoise(num_points, min_h, max_h, waveLength);
  
  background(0);
  stroke(255);
  fill(255);
  textFont(font,16);
  text("Perlin Noise",10, max_h + 20);


  noFill();
  beginShape();
  
  for(int i =0; i<num_points; i++)
    vertex( i, (int) heights[i]);

  endShape();

  // To compare, we also render random noise
  beginShape();
  
  for(int i =0; i<num_points; i++)
    vertex( i, (int) random(min_h, max_h) + height/2);    // we add height/2 to display it on the lower part

  endShape();

  fill(255);
  text("Random Noise",10,height-40);
}
