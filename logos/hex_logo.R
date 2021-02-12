library(magick)
library(grid)

light_color <- "deepskyblue3"
dark_color <- "deepskyblue4"

draw_hexagon <- function(r, color = "black") {
  h <- sqrt(3) / 2
  x = r * c(0, h, h, 0, -h, -h)
  y = r * c(-1, -0.5, 0.5, 1, 0.5, -0.5)
  grid.polygon(x, y, default.units="native", gp = gpar(lwd=0, linejoin="mitre", fill=color))
}


png("logos/hex_1.png", width = 2, height = 2, units = 'in', bg = "transparent", res = 300)
grid.newpage()
vp <- viewport(xscale = c(-1, 1), yscale = c(-1, 1))
pushViewport(vp)
draw_hexagon(1, light_color)
dev.off()

png("logos/hex_2.png", width = 2, height = 2, units = 'in', bg = "transparent", res = 300)
grid.newpage()
vp <- viewport(xscale = c(-1, 1), yscale = c(-1, 1))
pushViewport(vp)
draw_hexagon(0.85, dark_color)
dev.off()


hex_1 <- image_read('logos/hex_1.png')
hex_2 <- image_read('logos/hex_2.png')
rocket <- image_read('logos/rocket.png') # https://openclipart.org/detail/279653/rocket-silhouette

rocket <- image_scale(rocket, geometry_size_pixels(h=600))
hex_2 <- image_composite(hex_2, rocket, gravity="Center", operator = "DstOut", offset = geometry_point(x=0, y=90))

logo <- hex_1 %>%
  image_composite(hex_2) %>%
  image_annotate("ROC", color = "white", size = 90, gravity="Center", location = geometry_point(x=-105, y=0), weight = 700, font = "mono") %>%
  image_annotate("ket", color = "white", size = 90, gravity="Center", location = geometry_point(x=102, y=0), weight = 400, font = "mono")

logo

image_write(logo, path = "man/figures/hex_logo.png")

file.remove('logos/hex_1.png', 'logos/hex_2.png')

