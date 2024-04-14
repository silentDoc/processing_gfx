# Perlin Noise Basics (Very WIP)

## Table of Contents

- [Perlin Noise](#perlin-noise)
    - [From Value Noise to Perlin Noise](#from-value-noise-to-perlin-noise)
    - [From wavelength to frequency](#from-wavelength-to-frequency)
    - [From cosine interpolation to fade function](#from-cosine-interpolation-to-fade-function)
    - [2D Perlin Noise](#2d-perlin-noise)
    - [1D Perlin Noise](#1d-perlin-noise)
- [Improved Perlin Noise](#improved-perlin-noise)
    - [From random gradients to a randomized set](#from-random-gradients-to-a-randomized-set)
    - [Fade function improvements](#fade-function-improvements)
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


# Perlin Noise

Perlin noise was first introduced by Ken Perlin 1985 paper _[An Image Synthesizer](https://dl.acm.org/doi/10.1145/325165.325247)_. The paper is a cornerstone in the research and evolution of CGI, since it presented a novel way to implement solid textures that were generated computationally. The key method to attain such textures (the original paper showed examples of water, crystal, fire, clouds and marble texture) is the **Perlin noise algorithm**.

We have already introduced _value noise_, so we're familiar with the noise function concepts and properties that differ from pure randomness. I will try to explain how Perlin Noise is generated, making use of the process we have already seen with value noise.

## From Value Noise to Perlin Noise

## From wavelength to frequency
To speak about that, we will introduce here the term **frequency** as it is commonly used among the literature and we should be familiar enough with wavelength and amplitude. 

```
frequency = 1 / wavelength
```
Ok, so frequecy is the inverse of wavelength. What does it mean? 

Frequency tells us **how often we encounter a lattice point**, or **how much space do we have between lattice points**.

A frequency of 1 would tell us that _every point is a lattice point_, while a frequency of `1/500 = 0.002` would tell us that we have a lattice point every 500 points (wavelength = 500).

## From cosine interpolation to fade function
## 2D Perlin Noise
## 1D Perlin Noise

    





# Improved Perlin Noise
## From random gradients to a randomized set
## Fade function improvements

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






