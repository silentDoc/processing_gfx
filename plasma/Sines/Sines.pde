/**
Basic Sine Representation
**/
int num_waves = 5;
int[] buffer;
int pix_color;
int mode =4; // 0 - vertical, 1 - horizontal , 2 - sloped, 3 - circular , 4 composition of many

void setup() 
{
  size(512, 512);
  buffer = new int[width*height];
  noLoop();
}

void setup_vertical()
{
  for(int y = 0; y < height; y++)
    for(int x = 0; x < width; x++)
    {
      // Angle must be in radians
      pix_color = int(128.0 + 128.0 * sin( (x * num_waves * TWO_PI) / width));
      buffer[y*height + x] = color(pix_color,pix_color,pix_color);
    }
}

void setup_horizontal()
{
  for(int y = 0; y < height; y++)
    for(int x = 0; x < width; x++)
    {
      // Angle must be in radians
      pix_color = int(128.0 + 128.0 * sin( (y * num_waves * TWO_PI) / width));
      buffer[y*height + x] = color(pix_color,pix_color,pix_color);
    }
}

void setup_sloped()
{
  for(int y = 0; y < height; y++)
    for(int x = 0; x < width; x++)
    {
      // Angle must be in radians
      pix_color = int(128.0 + 128.0 * sin( ((x+y) * num_waves * TWO_PI) / width));
      buffer[y*height + x] = color(pix_color,pix_color,pix_color);
    }
}

void setup_circular()
{
  int w = width;
  int h = height;
  for(int y = 0; y < height; y++)
    for(int x = 0; x < width; x++)
    {
      // Angle must be in radians
      pix_color = int(128.0 + 128.0 * sin( (sqrt((x - w / 2.0) * (x - w / 2.0) + (y - h / 2.0) * (y - h / 2.0)) * num_waves * TWO_PI) / width));
      buffer[y*height + x] = color(pix_color,pix_color,pix_color);
    }
}

void setup_composition()
{
  int w = width;
  int h = height;
  for(int y = 0; y < height; y++)
    for(int x = 0; x < width; x++)
    {
      float value1 = sin((sqrt((x - w / 2.0) * (x - w / 2.0) + (y - h / 2.0) * (y - h / 2.0)) * num_waves * 3 * TWO_PI) / width);  // circular
      float value2 = sin((x * num_waves * TWO_PI) / width); // vertical
      float value3 = sin((sqrt((x - w / 4.0) * (x - w / 4.0) + (y - h / 3.0) * (y - h / 3.0)) * num_waves * TWO_PI) / width);  // elliptical
      float value4 = sin(((x+y) * num_waves * 2 * TWO_PI) / width); // Sloped
      
      // Angle must be in radians
      pix_color = int(128.0 + 128.0 * ( (value1 + value2 + value3 + value4)/4.0 ));
      buffer[y*height + x] = color(pix_color,pix_color,pix_color);
    }
}


void draw() 
{
  background(0);
  
  switch(mode)
  {
    case 0:
      setup_vertical();
      break;
    case 1:
      setup_horizontal();
      break;
    case 2:
      setup_sloped();
      break;
    case 3:
      setup_circular();
      break;
    case 4:
      setup_composition();
      break;
    default:
      setup_vertical();
      
  }
  
  
  loadPixels();
  for (int i = 0; i < buffer.length; i++) 
  {                    
    pixels[i] =  buffer[i];
  }
  
  updatePixels();
}
