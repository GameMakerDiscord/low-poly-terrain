/// @desc createSkyboxMesh();
// Skybox textures
global.texture_skybox_top = sprite_get_texture(bac_skybox_top, -1);
global.texture_skybox_bottom = sprite_get_texture(bac_skybox_bottom, -1);
global.texture_skybox_left = sprite_get_texture(bac_skybox_left, -1);
global.texture_skybox_right = sprite_get_texture(bac_skybox_right, -1);
global.texture_skybox_front = sprite_get_texture(bac_skybox_front, -1);
global.texture_skybox_back = sprite_get_texture(bac_skybox_back, -1);

// Skybox model
scr_create_skybox_model(-20, -20, -20, +20, +20, +20);
