% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/render_highquality.R
\name{render_highquality}
\alias{render_highquality}
\title{Render High Quality}
\usage{
render_highquality(filename = NULL, light = TRUE,
  lightdirection = 315, lightaltitude = 45, lightsize = NULL,
  lightintensity = 500, lightcolor = "white",
  obj_material = diffuse(), cache_filename = NULL, width = NULL,
  height = NULL, title_text = NULL, title_offset = c(20, 20),
  title_color = "black", title_size = 30, title_font = "sans",
  title_bar_color = NULL, title_bar_alpha = 0.5,
  ground_material = diffuse(), ground_size = 1e+05,
  scene_elements = NULL, camera_location = NULL, camera_lookat = c(0,
  0, 0), camera_interpolate = 1, clear = FALSE,
  print_scene_info = FALSE, ...)
}
\arguments{
\item{filename}{Filename of saved image. If missing, will display to current device.}

\item{light}{Default `TRUE`. Whether there should be a light in the scene. If not, the scene will be lit with a bluish sky.}

\item{lightdirection}{Default `315`. Position of the light angle around the scene. 
If this is a vector longer than one, multiple lights will be generated (using values from 
`lightaltitude`, `lightintensity`, and `lightcolor`)}

\item{lightaltitude}{Default `45`. Angle above the horizon that the light is located. 
If this is a vector longer than one, multiple lights will be generated (using values from 
`lightdirection`, `lightintensity`, and `lightcolor`)}

\item{lightsize}{Default `NULL`. Radius of the light(s). Automatically chosen, but can be set here by the user.}

\item{lightintensity}{Default `500`. Intensity of the light.}

\item{lightcolor}{Default `white`. The color of the light.}

\item{obj_material}{Default `rayrender::diffuse()`. The material properties of the object file.}

\item{cache_filename}{Name of temporary filename to store OBJ file, if the user does not want to rewrite the file each time.}

\item{width}{Defaults to the width of the rgl window. Width of the rendering.}

\item{height}{Defaults to the height of the rgl window. Height of the rendering.}

\item{title_text}{Default `NULL`. Text. Adds a title to the image, using magick::image_annotate.}

\item{title_offset}{Default `c(20,20)`. Distance from the top-left (default, `gravity` direction in 
image_annotate) corner to offset the title.}

\item{title_color}{Default `black`. Font color.}

\item{title_size}{Default `30`. Font size in pixels.}

\item{title_font}{Default `sans`. String with font family such as "sans", "mono", "serif", "Times", "Helvetica", 
"Trebuchet", "Georgia", "Palatino" or "Comic Sans".}

\item{title_bar_color}{Default `NULL`. If a color, this will create a colored bar under the title.}

\item{title_bar_alpha}{Default `0.5`. Transparency of the title bar.}

\item{ground_material}{Default `diffuse()`. Material defined by the rayrender material functions.}

\item{ground_size}{Default `100000`. The width of the plane representing the ground.}

\item{scene_elements}{Default `NULL`. Extra scene elements to add to the scene, created with rayrender.}

\item{camera_location}{Default `NULL`. Custom position of the camera. The `FOV`, `width`, and `height` arguments will still
be derived from the rgl window.}

\item{camera_lookat}{Default `NULL`. Custom point at which the camera is directed. The `FOV`, `width`, and `height` arguments will still
be derived from the rgl window.}

\item{camera_interpolate}{Default `c(0,0)`. Maximum `1`, minimum `0`. Sets the camera at a point between the `rgl` view and the `camera_location` 
and `camera_lookat` vectors.}

\item{clear}{Default `FALSE`. If `TRUE`, the current `rgl` device will be cleared.}

\item{print_scene_info}{Default `FALSE`. If `TRUE`, it will print the position and lookat point of the camera.}

\item{...}{Additional parameters to pass to rayrender::render_scene()}
}
\description{
Renders a raytraced version of the displayed rgl scene, using the `rayrender` package. 
User can specify the light direction, intensity, and color, as well as specify the material of the 
ground and add additional scene elements.

Note: This version does not yet support meshes with missing entries (e.g. if any NA values are present,
output will be ugly and wrong).
}
\examples{
#Render the volcano dataset using pathtracing
\donttest{
volcano \%>\%
 sphere_shade() \%>\%
 plot_3d(volcano,zscale = 2)
render_highquality()
}

#Change position of light
\donttest{
render_highquality(lightdirection = 45)
}

#Change vertical position of light
\donttest{
render_highquality(lightdirection = 45, lightaltitude=10)
}

#Change the ground material
\donttest{
render_highquality(lightdirection = 45, lightaltitude=60, 
                  ground_material = rayrender::diffuse(checkerperiod = 30, checkercolor="grey50"))
}

#Add three different color lights and a title
\donttest{
render_highquality(lightdirection = c(0,120,240), lightaltitude=45, 
                  lightcolor=c("red","green","blue"), title_text = "Red, Green, Blue",
                  title_bar_color="white", title_bar_alpha=0.8)
}

#Change the camera:
\donttest{
render_camera(theta=-45,phi=60,fov=60,zoom=0.8)
render_highquality(lightdirection = c(0), 
                  title_bar_color="white", title_bar_alpha=0.8)
}
#Add a shiny metal sphere
\donttest{
render_camera(theta=-45,phi=60,fov=60,zoom=0.8)
render_highquality(lightdirection = c(0,120,240), lightaltitude=45, 
                  lightcolor=c("red","green","blue"),
                  scene_elements = rayrender::sphere(z=-60,y=0,
                                                     radius=20,material=rayrender::metal()))
}

#Add a red light to the volcano and change the ambient light to dusk
\donttest{
render_camera(theta=45,phi=45)
render_highquality(lightdirection = c(240), lightaltitude=30, 
                  lightcolor=c("#5555ff"),
                  scene_elements = rayrender::sphere(z=0,y=15, x=-18, radius=5,
                                   material=rayrender::light(color="red",intensity=10)))
}
#Manually change the camera location and direction
\donttest{
render_camera(theta=45,phi=45,fov=90)
render_highquality(lightdirection = c(240), lightaltitude=30, lightcolor=c("#5555ff"), 
                  camera_location = c(50,10,10), camera_lookat = c(0,15,0), 
                  scene_elements = rayrender::sphere(z=0,y=15, x=-18, radius=5,
                                   material=rayrender::light(color="red",intensity=10)))
rgl::rgl.close()
}
}
