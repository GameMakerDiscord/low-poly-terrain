gml_pragma("global", "macros();");

#macro WIDTH __view_get( e__VW.WView, 0 )
#macro HEIGHT __view_get( e__VW.HView, 0 )
#macro _DEBUG_ (true || debug_mode)

#region World settings
global.WS_RANGE = 5;
global.WS_OFFSET = 2;
global.WS_SCALE = 10;
global._WAVE_SPEED = .004;
global.WS_SIZE = 100;
global._WATER_HEIGHT = 0;

#macro RANGE (global.WS_RANGE)
#macro OFFSET (global.WS_OFFSET)
#macro WORLD_SCALE (global.WS_SCALE)
#macro WAVE_SPEED (global._WAVE_SPEED)
#macro WORLD_SIZE (global.WS_SIZE)
#macro WATER_HEIGHT (global._WATER_HEIGHT)
#endregion

#region Generation settings
// Color map
#macro COLOUR_SPREAD .45
#macro BiomColorArray [color(201, 197, 109), color(191, 184, 98), color(168, 147, 64), color(0, 128, 64), color(0, 128, 0), color(0, 64, 64)]

// Heightmap
global.HeightMapTexture = -1;
#macro USE_HEIGHTMAP 0
#macro HEIGHTMAP (global.HeightMapTexture)

// Noise
#macro NOISE_SIMPLEX 1
#macro NOISE_PERLIN 2

#macro CURRENT_NOISE NOISE_PERLIN

// Noise settings
#macro SEED 0
#macro AMPLITUDE 30
#macro ROUGHNESS .4
#macro OCTAVES 5
#macro SCALE 1.5
#endregion

#region Light settings
#macro LIGHT_POS [.3, -1, .5]
#macro LIGHT_COL [1, .95, .95]
#macro LIGHT_BIAS [.7, .3] // Normalized [0 - 1] (Ambient light, Diffuse light multiplers)

#macro LIGHT_BIAS_X array_get(LIGHT_BIAS, 0)
#macro LIGHT_BIAS_Y array_get(LIGHT_BIAS, 1)
#macro LIGHT_COL_R array_get(LIGHT_COL, 0)
#macro LIGHT_COL_G array_get(LIGHT_COL, 1)
#macro LIGHT_COL_B array_get(LIGHT_COL, 2)
#endregion

#region Render target
enum RTRGT { PASS_BUFF, PASS_OUT }
global.RENDER_TARGET = RTRGT.PASS_BUFF;

#macro RT_DEPTH_DOWNSCALE 1
#macro RT (global.RENDER_TARGET)
#endregion

#region Camera settings
#macro CAMERA_FAR (16 / (WORLD_SCALE / 10))
#macro VIEW_BOBBLE 0
#endregion

#region Settings
// PostFX
#macro HBAO 1
#macro HBAO_Blur 1
#macro Bokeh 1
#macro DoF 0
#macro RenderOutput 1

// Debug
#macro DEBUG _DEBUG_

// Skybox
#macro SKYBOX 1

#endregion

#region Blur settings
#macro BlurSize 4
#macro BlurStrength 1

#macro BokehSize .125
#macro BokehSamples 5
#macro BokehStength .8
#macro BokehDirection [BokehSize * 0, BokehSize * 1] // (0, 1), (0.866/aspect, 0.5), (0.866/aspect, -0.5)
#macro BokehDirection_X array_get(BokehDirection, 0)
#macro BokehDirection_Y array_get(BokehDirection, 1)

#macro DoF_FocalRange 2
#macro DoF_FocalDistance .3

#macro UseBlur (HBAO_Blur || Bokeh || DoF)
#endregion

#region Window settings
#macro WindowFull 1



#endregion
