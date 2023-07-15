// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

//!DESC RAVU-Zoom (yuv, r3, compute)
//!HOOK NATIVE
//!BIND HOOKED
//!BIND ravu_zoom_lut3
//!WIDTH OUTPUT.w
//!HEIGHT OUTPUT.h
//!OFFSET ALIGN
//!WHEN LUMA.w 0 > HOOKED.w OUTPUT.w < * HOOKED.h OUTPUT.h < *
//!COMPUTE 32 8
#define LUTPOS(x, lut_size) mix(0.5 / (lut_size), 1.0 - 0.5 / (lut_size), (x))
shared vec3 samples[532];
void hook() {
ivec2 group_begin = ivec2(gl_WorkGroupID) * ivec2(gl_WorkGroupSize);
ivec2 group_end = group_begin + ivec2(gl_WorkGroupSize) - ivec2(1);
ivec2 rectl = ivec2(floor(HOOKED_size * HOOKED_map(group_begin) - 0.5)) - 2;
ivec2 rectr = ivec2(floor(HOOKED_size * HOOKED_map(group_end) - 0.5)) + 3;
ivec2 rect = rectr - rectl + 1;
for (int id = int(gl_LocalInvocationIndex); id < rect.x * rect.y; id += int(gl_WorkGroupSize.x * gl_WorkGroupSize.y)) {
int y = id / rect.x, x = id % rect.x;
samples[x + y * 38] = HOOKED_tex(HOOKED_pt * (vec2(rectl + ivec2(x, y)) + vec2(0.5,0.5) + HOOKED_off)).xyz;
}
groupMemoryBarrier();
barrier();
vec2 pos = HOOKED_size * HOOKED_map(ivec2(gl_GlobalInvocationID));
vec2 subpix = fract(pos - 0.5);
pos -= subpix;
subpix = LUTPOS(subpix, vec2(9.0));
vec2 subpix_inv = 1.0 - subpix;
subpix /= vec2(5.0, 288.0);
subpix_inv /= vec2(5.0, 288.0);
ivec2 ipos = ivec2(floor(pos)) - rectl;
int lpos = ipos.x + ipos.y * 38;
vec3 sample0 = samples[-78 + lpos];
vec3 sample1 = samples[-40 + lpos];
vec3 sample2 = samples[-2 + lpos];
vec3 sample3 = samples[36 + lpos];
vec3 sample4 = samples[74 + lpos];
vec3 sample5 = samples[112 + lpos];
vec3 sample6 = samples[-77 + lpos];
vec3 sample7 = samples[-39 + lpos];
vec3 sample8 = samples[-1 + lpos];
vec3 sample9 = samples[37 + lpos];
vec3 sample10 = samples[75 + lpos];
vec3 sample11 = samples[113 + lpos];
vec3 sample12 = samples[-76 + lpos];
vec3 sample13 = samples[-38 + lpos];
vec3 sample14 = samples[0 + lpos];
vec3 sample15 = samples[38 + lpos];
vec3 sample16 = samples[76 + lpos];
vec3 sample17 = samples[114 + lpos];
vec3 sample18 = samples[-75 + lpos];
vec3 sample19 = samples[-37 + lpos];
vec3 sample20 = samples[1 + lpos];
vec3 sample21 = samples[39 + lpos];
vec3 sample22 = samples[77 + lpos];
vec3 sample23 = samples[115 + lpos];
vec3 sample24 = samples[-74 + lpos];
vec3 sample25 = samples[-36 + lpos];
vec3 sample26 = samples[2 + lpos];
vec3 sample27 = samples[40 + lpos];
vec3 sample28 = samples[78 + lpos];
vec3 sample29 = samples[116 + lpos];
vec3 sample30 = samples[-73 + lpos];
vec3 sample31 = samples[-35 + lpos];
vec3 sample32 = samples[3 + lpos];
vec3 sample33 = samples[41 + lpos];
vec3 sample34 = samples[79 + lpos];
vec3 sample35 = samples[117 + lpos];
vec3 abd = vec3(0.0);
float gx, gy;
gx = (sample13.x-sample1.x)/2.0;
gy = (sample8.x-sample6.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample14.x-sample2.x)/2.0;
gy = (-sample10.x+8.0*sample9.x-8.0*sample7.x+sample6.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample15.x-sample3.x)/2.0;
gy = (-sample11.x+8.0*sample10.x-8.0*sample8.x+sample7.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample16.x-sample4.x)/2.0;
gy = (sample11.x-sample9.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (-sample25.x+8.0*sample19.x-8.0*sample7.x+sample1.x)/12.0;
gy = (sample14.x-sample12.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (-sample26.x+8.0*sample20.x-8.0*sample8.x+sample2.x)/12.0;
gy = (-sample16.x+8.0*sample15.x-8.0*sample13.x+sample12.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample27.x+8.0*sample21.x-8.0*sample9.x+sample3.x)/12.0;
gy = (-sample17.x+8.0*sample16.x-8.0*sample14.x+sample13.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample28.x+8.0*sample22.x-8.0*sample10.x+sample4.x)/12.0;
gy = (sample17.x-sample15.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (-sample31.x+8.0*sample25.x-8.0*sample13.x+sample7.x)/12.0;
gy = (sample20.x-sample18.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (-sample32.x+8.0*sample26.x-8.0*sample14.x+sample8.x)/12.0;
gy = (-sample22.x+8.0*sample21.x-8.0*sample19.x+sample18.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample33.x+8.0*sample27.x-8.0*sample15.x+sample9.x)/12.0;
gy = (-sample23.x+8.0*sample22.x-8.0*sample20.x+sample19.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.07901060453704994;
gx = (-sample34.x+8.0*sample28.x-8.0*sample16.x+sample10.x)/12.0;
gy = (sample23.x-sample21.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample31.x-sample19.x)/2.0;
gy = (sample26.x-sample24.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
gx = (sample32.x-sample20.x)/2.0;
gy = (-sample28.x+8.0*sample27.x-8.0*sample25.x+sample24.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample33.x-sample21.x)/2.0;
gy = (-sample29.x+8.0*sample28.x-8.0*sample26.x+sample25.x)/12.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.06153352068439959;
gx = (sample34.x-sample22.x)/2.0;
gy = (sample29.x-sample27.x)/2.0;
abd += vec3(gx * gx, gx * gy, gy * gy) * 0.04792235409415088;
float a = abd.x, b = abd.y, d = abd.z;
float T = a + d, D = a * d - b * b;
float delta = sqrt(max(T * T / 4.0 - D, 0.0));
float L1 = T / 2.0 + delta, L2 = T / 2.0 - delta;
float sqrtL1 = sqrt(L1), sqrtL2 = sqrt(L2);
float theta = mix(mod(atan(L1 - a, b) + 3.141592653589793, 3.141592653589793), 0.0, abs(b) < 1.192092896e-7);
float lambda = sqrtL1;
float mu = mix((sqrtL1 - sqrtL2) / (sqrtL1 + sqrtL2), 0.0, sqrtL1 + sqrtL2 < 1.192092896e-7);
float angle = floor(theta * 24.0 / 3.141592653589793);
float strength = mix(mix(0.0, 1.0, lambda >= 0.004), mix(2.0, 3.0, lambda >= 0.05), lambda >= 0.016);
float coherence = mix(mix(0.0, 1.0, mu >= 0.25), 2.0, mu >= 0.5);
float coord_y = ((angle * 4.0 + strength) * 3.0 + coherence) / 288.0;
vec3 res = vec3(0.0);
vec4 w;
w = texture(ravu_zoom_lut3, vec2(0.0, coord_y) + subpix);
res += sample0 * w[0];
res += sample1 * w[1];
res += sample2 * w[2];
res += sample3 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.2, coord_y) + subpix);
res += sample4 * w[0];
res += sample5 * w[1];
res += sample6 * w[2];
res += sample7 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.4, coord_y) + subpix);
res += sample8 * w[0];
res += sample9 * w[1];
res += sample10 * w[2];
res += sample11 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.6, coord_y) + subpix);
res += sample12 * w[0];
res += sample13 * w[1];
res += sample14 * w[2];
res += sample15 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.8, coord_y) + subpix);
res += sample16 * w[0];
res += sample17 * w[1];
w = texture(ravu_zoom_lut3, vec2(0.0, coord_y) + subpix_inv);
res += sample35 * w[0];
res += sample34 * w[1];
res += sample33 * w[2];
res += sample32 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.2, coord_y) + subpix_inv);
res += sample31 * w[0];
res += sample30 * w[1];
res += sample29 * w[2];
res += sample28 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.4, coord_y) + subpix_inv);
res += sample27 * w[0];
res += sample26 * w[1];
res += sample25 * w[2];
res += sample24 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.6, coord_y) + subpix_inv);
res += sample23 * w[0];
res += sample22 * w[1];
res += sample21 * w[2];
res += sample20 * w[3];
w = texture(ravu_zoom_lut3, vec2(0.8, coord_y) + subpix_inv);
res += sample19 * w[0];
res += sample18 * w[1];
res = clamp(res, 0.0, 1.0);
imageStore(out_image, ivec2(gl_GlobalInvocationID), vec4(res, 1.0));
}
//!TEXTURE ravu_zoom_lut3
//!SIZE 45 2592
//!FORMAT rgba16f
//!FILTER LINEAR