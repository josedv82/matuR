#' Height (current + predicted) vs growth curves plot for females.
#'
#' This function returns a ggplot object showing the **current** and **predicted height** vs normal growth charts for american population.
#'
#' Data for growth charts was obtained from the National Center for Health Statistics.
#'
#' Please visit \url{https://www.cdc.gov/growthcharts/percentile_data_files.htm} to learn more about this information.
#'
#' Be aware, players from different populations to the one used on these growth charts may not be well represented.
#'
#' For males, use documentation for **`plot_growth_male()`**
#'
#'
#' @param data A data frame. The object containing the raw data we wish to analize.
#' @param athlete A character string with the name of the athlete we wish to plot.
#' @return A plot `(ggplot)`
#'
#' @export
#' @examples
#' plot_growth_female(data_sample, "Athlete 18")
#'

plot_growth_female <- function(data, athlete) {

  curve <- matuR::curves %>%
    dplyr::mutate(Years = round(Agemos / 12, 2)) %>%
    dplyr::select(Gender, Years, everything(), -Agemos, -Power, -Median, -CV) %>%
    dplyr::filter(Gender == "Female")

  athlete <- maturation_cm(data) %>% dplyr::filter(Athlete %in% c(athlete))

  plot <- ggplot2::ggplot(curve) +
    ggplot2::annotate("rect", xmin = 1.9, xmax = 6, ymin = 187, ymax = 216, fill = "white") +
    ggplot2::annotate("text", x = 3.9, y = 215, label = "Normal Growth Curve", color = "black", size = 3) +
    ggplot2::annotate("rect", xmin = 2, xmax = 2.6, ymin = 205, ymax = 210, fill = "skyblue1") +
    ggplot2::annotate("text", x = 4, y = 208, label = "3-97 Percentiles", color = "black", size = 2) +
    ggplot2::annotate("rect", xmin = 2, xmax = 2.6, ymin = 200, ymax = 205, fill = "skyblue2") +
    ggplot2::annotate("text", x = 4, y = 203, label = "5-95 Percentiles", color = "black", size = 2) +
    ggplot2::annotate("rect", xmin = 2, xmax = 2.6, ymin = 195, ymax = 200, fill = "skyblue3") +
    ggplot2::annotate("text", x = 4, y = 198, label = "10-90 Percentiles", color = "black", size = 2) +
    ggplot2::annotate("rect", xmin = 2, xmax = 2.6, ymin = 190, ymax = 195, fill = "skyblue4") +
    ggplot2::annotate("text", x = 4, y = 193, label = "25-75 Percentiles", color = "black", size = 2) +
    ggplot2::annotate("rect", xmin = 20, xmax = 22, ymin = max(curve$P3), ymax = max(curve$P97), fill = "black", alpha = .8) +
    ggplot2::annotate("text", x = 21.5, y = 75, label = "Adult Years", color = "black", size = 3) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin=P3, ymax=P97, x=Years), fill = "skyblue1") +
    ggplot2::geom_ribbon(ggplot2::aes(ymin=P5, ymax=P95, x=Years), fill = "skyblue2") +
    ggplot2::geom_ribbon(ggplot2::aes(ymin=P10, ymax=P90, x=Years), fill = "skyblue3") +
    ggplot2::geom_ribbon(ggplot2::aes(ymin=P25, ymax=P75, x=Years), fill = "skyblue4") +
    ggplot2::geom_line(ggplot2::aes(y=P50, x=Years), colour = "gray", linetype = 2) +
    ggplot2::geom_vline(ggplot2::aes(xintercept = 20), color = "black") +
    ggplot2::geom_curve(data = athlete, ggplot2::aes(x = Age, y = `Height (CM)`, xend = 16.5, yend = 135), color = "black", curvature = 0.2, size = 0.5, linetype = 1) +
    ggplot2::annotate("text", x = 17, y = 125, label = "Current \n Height", color = "black", size = 3) +
    ggplot2::geom_point(data = athlete, ggplot2::aes(Age, `Height (CM)`), color = "deeppink", size = 3) +
    ggplot2::geom_point(data = athlete %>% dplyr::mutate(Age = 21), ggplot2::aes(Age, `Estimated Adult Height (CM)`), color = "deeppink", size = 3) +
    ggplot2::geom_text(data = athlete %>% dplyr::mutate(Age = 21), ggplot2::aes(Age, `Estimated Adult Height (CM)`, label = `Estimated Adult Height (CM)`), color = "deeppink", size = 3, vjust = -1) +
    ggplot2::geom_curve(data = athlete %>% dplyr::mutate(Age2 = 21), ggplot2::aes(x = Age, y = `Height (CM)`, xend = Age2, yend = `Estimated Adult Height (CM)`), color = "deeppink", curvature = -0.05, size = 0.5, linetype = 1) +
    ggplot2::scale_x_continuous(breaks = seq(0, 20, by = 2.5)) +
    ggplot2::ylim(75, 220) +
    ggplot2::ylab("Height (CM) \n") + ggplot2::xlab("Years") +
    ggplot2::labs(title = "Projected Height (CM)", subtitle = "vs standard growth curves: United States \n", caption = "For more information about growth charts visit https://www.cdc.gov/growthcharts/") +
    ggplot2::theme_light() +
    ggplot2::theme(axis.title.x = ggplot2::element_text(color = "grey", hjust = 1),
          axis.title.y = ggplot2::element_text(color = "grey", hjust = 1),
          plot.subtitle = ggplot2::element_text(color = "darkgray"),
          plot.caption = ggplot2::element_text(color = "lightblue"),
          panel.grid.minor = ggplot2::element_blank(),
          panel.grid.major = ggplot2::element_line(linetype = 2),
          legend.title = ggplot2::element_blank())

  plot

}
