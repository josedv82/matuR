#' Predicted Height Plot (Inches)
#'
#' This function returns a ggplot object showing the predicted adult height in inches for each athlete in the dataset.
#' For the same plot in centimeters use **`plot_predicted_height_cm()`**
#'
#' @param data A data frame. The object containing the raw data we wish to analize.
#' @return A plot `(ggplot)`
#'
#' @export
#' @examples
#' plot_predicted_height_in(data_sample)
#'

plot_predicted_height_in <- function(data) {

  dat <- maturation_in(data) %>%
    dplyr::mutate(`Error (IN)` = ifelse(Gender == "Male", 2.1 / 2, 1.7 / 2))

  plot <- ggplot2::ggplot(data = dat, ggplot2::aes(x = `Estimated Adult Height (IN)`, y = reorder(Athlete, `Estimated Adult Height (IN)`))) +
    ggplot2::geom_pointrange(ggplot2::aes(xmin = `Estimated Adult Height (IN)` - `Error (IN)`, xmax = `Estimated Adult Height (IN)` + `Error (IN)`)) +
    ggplot2::facet_wrap(~Gender, scales = "free_y") +
    ggplot2::scale_x_continuous(breaks = seq(0, 300, by = 5)) +
    ggplot2::ylab("") + ggplot2::xlab("\n Inches") +
    ggplot2::ggtitle("\n Estimated Adult Height (IN) \n") +
    ggplot2::theme_light() +
    ggplot2::theme(axis.title.x = ggplot2::element_text(color = "grey", hjust = 1),
                   panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(linetype = 2),
                   strip.background = ggplot2::element_rect(fill = "black"),
                   panel.spacing = ggplot2::unit(2, "lines"))

  plot

}
