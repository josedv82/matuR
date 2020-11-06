#' % Adult Height vs Maturity Offset in Years
#'
#' This function returns a scatterplot showing the % of adult height vs the maturity offset `(in years)`.
#'
#' @param data A data frame. The object containing the raw data we wish to analize.
#' @return A plot `(ggplot)`
#'
#' @export
#' @examples
#' plot_puberty_stages(data_sample)
#'

plot_puberty_stages <- function(data) {

 plot <- maturation_cm(data) %>%
   ggplot2::ggplot(ggplot2::aes(x = `Maturity Offset (years)`, y = `% Adult Height`, label = Athlete)) +
   ggplot2::annotate("rect", xmin = -Inf, xmax = 4.5, ymin = 100, ymax = 102, fill = "black") +
   ggplot2::annotate("rect", xmin = -Inf, xmax = 4.5, ymin = -Inf, ymax = 88, fill = "gray", alpha = 0.4) +
   ggplot2::annotate("rect", xmin = -Inf, xmax = 4.5, ymin = 88, ymax = 95, fill = "gray", alpha = 0.6) +
   ggplot2::annotate("rect", xmin = -Inf, xmax = 4.5, ymin = 95, ymax = 100, fill = "gray", alpha = 0.8) +
   ggplot2::annotate("rect", xmin = 4.5, xmax = Inf, ymin = -Inf, ymax = Inf, fill = "white") +
   ggplot2::annotate("text", x = 0, y = 101, label = "Growth Spurt", size = 3, color = "white") +
   ggplot2::annotate("text", x = -2.7, y = 101, label = "Pre-Puberty", size = 3, color = "white") +
   ggplot2::annotate("text", x = 2.7, y = 101, label = "Post-Puberty", size = 3, color = "white") +
   ggplot2::annotate("text", x = -4, y = 85, label = "< 88%", size = 3, color = "black") +
   ggplot2::annotate("text", x = -4, y = 91.5, label = "88-95%", size = 3, color = "black") +
   ggplot2::annotate("text", x = -4, y = 97.5, label = "> 95%", size = 3, color = "black") +
   ggplot2::geom_vline(xintercept = -1, color = "white") +
   ggplot2::geom_vline(xintercept = 1, color = "white") +
   ggrepel::geom_text_repel(nudge_x = 6, direction = "y", angle = 0, hjust = -1, segment.size = 0.01, point.padding = 1, segment.alpha = 0.1, size = 3, color = "black") +
   ggplot2::geom_point(size = 2.5, alpha = 0.5, color = "red", shape = 21) +
   ggplot2::ylim (83, 102) +
   ggplot2::scale_x_continuous(limits = c(-4,5.5), breaks = seq(-4, 4, by = 1)) +
   ggplot2::ylab("% Adult Height \n") + ggplot2::xlab("\n Maturity Offset (Years)") +
   ggplot2::ggtitle("\n % Predicted Adult Height", subtitle =  "       Maturity Offset \n") +
   ggplot2::theme_light() +
   ggplot2::theme(panel.grid = ggplot2::element_blank(),
         panel.border = ggplot2::element_blank(),
         axis.title.x = ggplot2::element_text(color = "grey", hjust = 0.8),
         axis.title.y = ggplot2::element_text(color = "grey", hjust = 0.8),
         axis.text.y = ggplot2::element_blank(),
         axis.ticks.y = ggplot2::element_blank(),
         plot.subtitle = ggplot2::element_text(color = "darkgray"),
         legend.title = ggplot2::element_blank())

 plot

}
