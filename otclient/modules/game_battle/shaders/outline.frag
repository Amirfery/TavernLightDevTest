// Define a constant offset for sampling neighboring texels
const float offset = 1.0 / 512.0;

// Uniform variable representing time
uniform float u_Time;

// Uniform sampler for input texture
uniform sampler2D u_Tex0;

// Interpolated texture coordinate for the fragment
varying vec2 v_TexCoord;

void main()
{
    // Sample the color at the current texture coordinate
    vec4 col = texture2D(u_Tex0, v_TexCoord);
    
    // Check if the alpha value of the sampled color is fully opaque
    if (col.a == 1)
        gl_FragColor = col; // Fully opaque, so use the sampled color directly
    else {
        // Calculate the sum of alpha values of neighboring texels
        float a = texture2D(u_Tex0, vec2(v_TexCoord.x + offset, v_TexCoord.y)).a +
                  texture2D(u_Tex0, vec2(v_TexCoord.x, v_TexCoord.y - offset)).a +
                  texture2D(u_Tex0, vec2(v_TexCoord.x - offset, v_TexCoord.y)).a +
                  texture2D(u_Tex0, vec2(v_TexCoord.x, v_TexCoord.y + offset)).a;
        
        // If the sampled color is not fully opaque and any neighboring texel has nonzero alpha,
        // mark the fragment as red; otherwise, use the sampled color
        if (col.a < 1.0 && a > 0.0) {
            gl_FragColor = vec4(1, 0, 0, 1); // Red color indicating non-opaque fragment
        } else {
            gl_FragColor = col; // Use the sampled color
        }
    }
}
