# Related topics and Applications

## Table of contents

- [Interpolation and fade functions](#interpolation-and-fade-functions)
    - [Linear interpolation](#linear-interpolation)
    - [Cosine interpolation](#cosine-interpolation)
    - [Original Perlin Fade Function](#original-perlin-fade-function)
    - [Improved Perlin Fade Function](#original-perlin-fade-function)

- [Composition and textures](#composition-and-textures)
    - [Octaves](#octaves)
    - [Fractality](#fractality)
    - [Textures from noise](#textures-from-noise)
        - [Turbulence](#turbulence)
        - [Marble](#marble)
        - [Wood](#wood)
        - [Water](#water)
        - [Fire](#fire)
        - [Clouds](#clouds)

# Interpolation and Fade functions

When reviewing Value noise and Perlin noise, the use of interpolation methods  (or fade functions) is very important. They play a key role in one of the properties we are looking for in a noise function: **smoothness**.  

I think it is good to 

Another change that I am introducing in the Perlin noise with respect to the Value noise is the fade functions to interpolate values. When rendering Value noise, we do not have any interpolation alogrithm or fade function that is standard, we can choose any that fits our need, from the most basic linear interpolation to more advanced ones (see [interpolation](https://en.wikipedia.org/wiki/Interpolation) or [Paul bourke quick review](https://paulbourke.net/miscellaneous/interpolation/) which is succint and easy to understand). 

In the discussion below, we will assume a 1D signal interpolation with the following notation:
```math
(x_0, y_0) \qquad \text{The first interpolation point}
```
```math
(x_1, y_1) \qquad \text{The second interpolation point}
```
```math
(x_p, y_p) \qquad \text{The point to be interpolated}
```
## Linear interpolation

## Cosine interpolation (cosine fade function)
To render value noise, I take advantage of the **cosine interpolation** method to interpolate a function between two points. I opt for that method because consine interpolators only need 2 data points to interpolate the ones in the middle, it is fast and simple and it provides a much more smoother transition than the basic linear interpolator. 

I have already discussed the implementation details of the cosine interpolator in the [value noise aricle](./valuenoise.md#how-is-it-generated), but just for quick comparison, the interpolation formula is the following:

```math
angle = x_p * \Pi  \qquad ;x_p \in (0,1)
```
```math
w = \frac{1 - \cos{(angle)}}{2}
```
```math
y_p = y_1*(1-w) + y_0 * w
```
The cosine interpolation function in the interval `(0,1)` looks like this:
<div style="width:50%; margin: auto;">
<p align="center" width='50%'>
<img src="images/cosineInterp.png" alt="Interpolation of the first lattice of value noise" />
</p>
</div>

Notice how the function is not a straight line from 0 to 1, but is has some degree of curve provided by the trigonometric function. That curve is the smooth factor that we can see in transition between lattices in our noise. 

## Original Perlin Fade Function
In his original article, Ken Perlin proposed the following fade function to be used along a linear interpolation. The function was really simple and looks like this:

```math
w = 3x_p^2 - 2x_p^3 \qquad ;x_p \in (0,1)
```
```math
y_p = y_1*(1-w) + y_0 * w
```
The function looks very similar to the cosine interpolation function:

<div style="width:50%; margin: auto;">
<p align="center" width='50%'>
<img src="images/perlinInterp.png" alt="Interpolation of the first lattice of value noise" />
</p>
</div>

Why did Ken Perlin come up with something so similar to existing interpolators? I guess the answer has to be computational efficiency. The original article is from the 80s and back then we were used to count processor cycles to speed up things ;). 

Perlin original fade function can be computed like this:

```csharp
// 3x^2 - 2x^3
fade = x*x * (3 - 2*x);
```
Coding the fade function like this is efficient and does not use of any `cos` or other trigonometric programming instruction, wich were introduced in the 386 intel processor (after Perlin's article) and had to be solved using LUTs (indirecting memory was way slower than multiplying.)

The fade function though, does the trick, it provides results that depend only on two interpolation points and it also yields smooth transitions between lattices. 

## Improved Perlin Fade Function


# Composition and textures


## Octaves

In most of the articles online, frequency is used to talk about noise and octaves, so just be aware that frequency is just another way to refer to wavelength. Now on to octaves.

Each octave represents a noise function at a different frequency and amplitude. Higher-frequency (lower wavelength) octaves have more rapid changes in values, while lower-frequency (higher wavelength) octaves have smoother transitions. Similarly, higher-amplitude octaves contribute more to the overall noise function's amplitude, while lower-amplitude octaves have less influence.

The term "octave" originates from music theory, where octaves represent doubling or halving of frequency. In the context of noise functions, each octave typically has a frequency that is twice that of the previous octave, and its amplitude is typically halved. This scaling allows for the creation of noise functions with a wide range of scales and levels of detail.

To generate fractal noise, multiple octaves of a base noise function (e.g., Perlin noise or value noise) are combined by adding them together. The contribution of each octave is determined by its **frequency**, **amplitude**, and **persistence** (a factor controlling how quickly the amplitude decreases with each successive octave).

In order to generate a composition of noise from octaves, we generally do the following (pseudocode):

```csharp
int initial_frequency   // Starting frquency (wavelength)
int intial_amplitude    // Starting amplitude
int persistance         // Factor that is applied between octaves 
int num_octaves         // number of octaves to calculate

int num_Points          // The number of points in the sequence. Ideally numPoints >>> wavelength
int[] yValues           // The array that will store the values of the curve

int frequency = initial_frequency
int amplitude = initial_amplitude

for(int octave = 0; octave < num_octaves; octave++)
{
   int[] octave_noise = noise(num_Points, frequency, amplitude)   

   yValues   += octave_noise    // This is an actual sum by elements
   frequency *= persistance
   amplitude /= persistance
}

return yValues;
```
## Fractality

The resulting noise function from combining a set of octaves is called **Fractal Browsian noise (fBn)**

Fractal Brownian Noise (fBm) is a type of fractal noise that is commonly used in computer graphics, procedural generation, and simulations to generate complex and realistic-looking textures, terrains, and patterns. It is an extension of Perlin/Value noise and other types of gradient noise.

Here's a breakdown of the key characteristics and components of Fractal Brownian Noise:

- **Fractal Nature:**
Fractal Brownian Noise exhibits self-similarity across multiple scales, meaning that the noise pattern looks similar regardless of the level of detail at which it is viewed.
This self-similarity allows for the creation of natural-looking textures and terrains with intricate detail.
- **Brownian Motion:**
Fractal Brownian Noise is based on the concept of Brownian motion, which describes the random movement of particles in a fluid or gas. In the context of noise generation, Brownian motion refers to the cumulative effect of combining multiple layers (octaves) of noise with varying frequencies and amplitudes.
- **Octaves:**
Fractal Brownian Noise combines multiple octaves of a base noise function, such as Perlin noise or value noise.
Each octave represents a layer of noise with a different frequency and amplitude. Higher-frequency octaves contribute fine detail to the overall noise pattern, while lower-frequency octaves contribute broader features.
- **Persistence:**
Persistence is a parameter that controls the influence of each successive octave on the final noise output. A higher persistence value results in stronger influence from higher-frequency octaves, leading to more detailed and "noisy" output. Lower persistence values produce smoother noise patterns with less high-frequency detail.
- **Generation Process:**
Fractal Brownian Noise is generated by summing together multiple octaves of noise, each scaled by a factor determined by its frequency and persistence. The noise values from each octave are added together to produce the final output, which exhibits characteristics of both randomness and structure.

In summary, Fractal Brownian Noise is a type of fractal noise that combines multiple layers of noise with varying frequencies and amplitudes to create complex, self-similar patterns.


## Textures from noise

### Turbulence
### Marble
### Wood
### Water
### Fire
### Clouds
