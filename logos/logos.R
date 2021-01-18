# library(hexSticker)
library(magick)
# library(ggplot2)
# library(png)
library(grid)
library(ROCket)

light_color <- "deepskyblue3"
dark_color <- "deepskyblue4"

# light_color <- "seagreen3"
# dark_color <- "seagreen4"

# light_color <- "dodgerblue3"
# dark_color <- "dodgerblue4"

draw_hexagon <- function(r, color = "black") {
  h <- sqrt(3) / 2
  x = r * c(0, h, h, 0, -h, -h)
  y = r * c(-1, -0.5, 0.5, 1, 0.5, -0.5)
  grid.polygon(x, y, default.units="native", gp = gpar(lwd=0, linejoin="mitre", fill=color))
}

# colors <- getOption("rkt_pride_colors")
# grid.newpage()
# vp <- viewport(xscale = c(-1, 1), yscale = c(-1, 1))
# pushViewport(vp)
# r <- 1
# for (color in colors) {
#   r <- r - 0.05
#   draw_hexagon(r, default.units="native", gp = gpar(lwd=0, linejoin="mitre", fill=color))
# }

png("logos/bg.png", width = 2, height = 2, units = 'in', bg = "transparent", res = 300)
# pdf("logos/bg.pdf", width = 2, height = 2, paper = "special")
grid.newpage()
vp <- viewport(xscale = c(-1, 1), yscale = c(-1, 1))
pushViewport(vp)
draw_hexagon(1, light_color)
draw_hexagon(0.9, dark_color)
dev.off()


png("logos/bg_1.png", width = 2, height = 2, units = 'in', bg = "transparent", res = 300)
# pdf("logos/bg.pdf", width = 2, height = 2, paper = "special")
grid.newpage()
vp <- viewport(xscale = c(-1, 1), yscale = c(-1, 1))
pushViewport(vp)
draw_hexagon(1, light_color)
dev.off()

png("logos/bg_2.png", width = 2, height = 2, units = 'in', bg = "transparent", res = 300)
# pdf("logos/bg.pdf", width = 2, height = 2, paper = "special")
grid.newpage()
vp <- viewport(xscale = c(-1, 1), yscale = c(-1, 1))
pushViewport(vp)
draw_hexagon(0.9, dark_color)
dev.off()

png("logos/mask.png", width = 2, height = 2, units = 'in', bg = "transparent", res = 300)
# pdf("logos/bg.pdf", width = 2, height = 2, paper = "special")
grid.newpage()
vp <- viewport(xscale = c(-1, 1), yscale = c(-1, 1))
pushViewport(vp)
draw_hexagon(0.9, "black")
dev.off()


scores <- 1:5
# totals <- rep(100, length(scores))
s <- seq(0, pi/2, length.out = 1 + length(scores))
fpr <- 1 - cos(s)
tpr <- sin(s)
plot(fpr, tpr)
positives <- rev(diff(round(tpr * 100)))
negatives <- rev(diff(round(fpr * 100)))

prep <- rkt_prep(scores, positives, negatives)
roc <- rkt_roc(prep, 1)
plot(roc)

# fig <- image_graph(width = 600, height = 600, res = 300, bg = "transparent")
# par(mar = c(1, 1, 1, 1), xpd = TRUE)
# plot.new()
# plot(roc, add = TRUE, cex = 4, lwd = 2, draw_area = FALSE)
# dev.off()

# image_info(fig)
# fig <- image_convert(fig, "svg")

# image_write(fig, path = "logos/graph.png")
# image_write(fig, path = "logos/graph.svg", format = "svg")


png("logos/graph.png", width = 2, height = 2, units = 'in', bg = "transparent", res = 300)
par(mar = c(1, 1, 1, 1), xpd = TRUE)
plot.new()
plot(roc, add = TRUE, cex = 4, lwd = 2, draw_area = TRUE, area_col = light_color, density = 3, angle_set = c(-45, 45))
dev.off()



bg <- image_read('logos/bg.png')
bg_1 <- image_read('logos/bg_1.png')
bg_2 <- image_read('logos/bg_2.png')
graph <- image_read('logos/graph.png')
mask <- image_read('logos/mask.png')
rocket <- image_read('logos/rocket.png')



image_mosaic(c(bg, graph))
image_composite(bg, graph)
image_composite(graph, mask, operator = "DstIn")
image_composite(bg, image_scale(graph, "500x500"), offset = "+50+50")

logo <- bg %>%
  image_composite(image_scale(graph, "390x390"), offset = "+80+90") %>%
  # image_composite(graph) %>%
  image_annotate("ROC", color = "white", size = 80, location = "+220+300", weight = 700, font = "mono") %>%
  image_annotate("ket", color = "white", size = 80, location = "+360+300", weight = 400, font = "mono")


# compose_types()
image_composite(mask, graph, offset = "+15+15", operator = "SrcIn")


graph_2 <- image_composite(mask, graph, offset = "+15+15", operator = "SrcIn")

logo <- bg %>%
  # image_composite(image_scale(graph, "390x390"), offset = "+80+90") %>%
  image_composite(graph_2) %>%
  image_annotate("ROC", color = "white", size = 90, location = "+200+330", weight = 700, font = "mono") %>%
  image_annotate("ket", color = "white", size = 90, location = "+360+330", weight = 400, font = "mono")


logo
# strwidth("ROC", family = "mono") * 300 * 2.54

image_write(logo, path = "logos/hex_logo.png")

rocket_2 <- image_composite(bg_2, image_scale(rocket, "300x300"), offset = "+120+90", operator = "DstOut")

logo <- bg_1 %>%
  image_composite(rocket_2) %>%
  image_annotate("ROC", color = "white", size = 90, location = "+200+350", weight = 700, font = "mono") %>%
  image_annotate("ket", color = "white", size = 90, location = "+360+350", weight = 400, font = "mono")

logo

image_write(logo, path = "logos/hex_logo_2.png")


rocket_2 <- image_read('logos/rocket_2.png')

# as.numeric(image_info(bg_2)[1, 2:3]) / 2

rocket_2 <- image_composite(bg_2, image_scale(rocket_2, "100x"), offset = "+250+100", operator = "DstOut")

logo <- bg_1 %>%
  image_composite(rocket_2) %>%
  image_annotate("ROC", color = "white", size = 90, location = "+110+230", weight = 700, font = "mono") %>%
  image_annotate("ket", color = "white", size = 90, location = "+320+230", weight = 400, font = "mono")

logo

image_write(logo, path = "logos/hex_logo_3.png")

# graph <- readPNG("logos/graph.png")
# graph <- rasterGrob(graph, interpolate = TRUE)
#
# gg <- ggplot() +
#   annotation_custom(graph) +
#   theme_void()
#
#
# sticker(
#   # "logos/graph.svg",
#   gg,
#   s_x = 1,
#   s_y = 1,
#   s_width = 1.3,
#   s_height = 1.3,
#
#   package="ROCket",
#   p_x = 1.3,
#   p_y = 0.9,
#   p_color = "black",
#   p_family = "Aller_Rg",
#   p_fontface = "plain",
#   p_size = 20,
#
#   h_size = 2,
#   h_fill = "orange",
#   h_color = "black",
#
#   spotlight = TRUE,
#   l_x = 1.3,
#   l_y = 0.9,
#   l_width = 3,
#   l_height = 3,
#   l_alpha = 0.4,
#
#   url = "",
#   u_x = 1,
#   u_y = 0.08,
#   u_color = "black",
#   u_family = "Aller_Rg",
#   u_size = 1.5,
#   u_angle = 30,
#
#   white_around_sticker = FALSE,
#   asp = 1,
#   dpi = 300,
#   filename="logos/hex_logo.png"
# )
